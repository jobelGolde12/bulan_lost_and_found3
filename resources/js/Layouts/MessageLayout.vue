<script setup>
import { ref, onMounted, onUnmounted, computed, watch } from "vue";
import { Link, usePage, Head } from "@inertiajs/vue3";
import PinnedChats from "@/Components/message/PinnedChats.vue";
import { useSidebarStore } from "@/piniaStore/useSidebarStore";
import SearchResults from "@/Components/message/SearchResults.vue";
const sidebar = useSidebarStore();

const props = defineProps({
  users: { type: Object, default: () => ({}) },
  getPinned: { type: Object, default: () => ({}) },
  activeMessage: { type: Number, default: () => null },
  currentUserId: { type: Number },
  hasMessages: { type: Array, default: () => [] },
});

const page = usePage();
const getUsers = ref([]);
const searchQuery = ref("");
let userId = ref(null);
const pinnedChats = ref([]);
const getActiveMessage = ref(null);
let getCurrentUserId = ref(0);
const matchedUsers = ref([]);

const isSidebarOpen = ref(localStorage.getItem("isSidebarOpen") === "true");
const windowWidth = ref(window.innerWidth);
const isMobile = computed(() => windowWidth.value <= 768);

// NEW: control showing of our custom modal
const showMatchedUsersModal = ref(false);

onMounted(() => {
  pinnedChats.value = Array.isArray(props.getPinned)
    ? props.getPinned
    : Object.values(props.getPinned || {});

  isSidebarOpen.value = localStorage.getItem("isSidebarOpen") === "true";
  window.addEventListener("resize", () => {
    windowWidth.value = window.innerWidth;
  });

  // close modal on Escape
  const onKey = (e) => {
    if (e.key === "Escape") hideModal();
  };
  window.addEventListener("keydown", onKey);
  // store so we can remove later
  onUnmounted(() => {
    window.removeEventListener("keydown", onKey);
  });
});

watch(
  () => props.users,
  (newUsers) => {
    getUsers.value = Object.entries(newUsers || {}).map(([id, name]) => ({ id, name }));
  },
  { immediate: true }
);

watch(
  () => props.currentUserId,
  (newId) => {
    getCurrentUserId.value = newId;
  },
  { immediate: true }
);

watch(
  () => props.getPinned,
  (newItem) => {
    if (Array.isArray(newItem)) {
      pinnedChats.value = newItem.filter((data) => data.id != getCurrentUserId.value);
    }
  },
  { immediate: true }
);

watch(
  () => props.activeMessage,
  (newItem) => {
    getActiveMessage.value = newItem;
  },
  { immediate: true }
);

const toggleSidebar = () => {
  isSidebarOpen.value = !isSidebarOpen.value;
  localStorage.setItem("isSidebarOpen", isSidebarOpen.value);
  sidebar.toggleSidebar();
};

// show / hide helpers for our custom modal
const showModal = () => {
  showMatchedUsersModal.value = true;
  // prevent background scrolling while modal open
  document.body.style.overflow = "hidden";
};
const hideModal = () => {
  showMatchedUsersModal.value = false;
  document.body.style.overflow = "";
};

// ✅ Show modal only if fetch successful (replaced bootstrap modal)
const search = async () => {
  try {
    const response = await fetch(
      `/message-search-v2?name=${encodeURIComponent(searchQuery.value)}`,
      {
        method: "GET",
        headers: {
          Accept: "application/json",
          "X-Requested-With": "XMLHttpRequest",
        },
        credentials: "same-origin",
      }
    );

    if (!response.ok) {
      throw new Error("Network response was not ok");
    }

    const data = await response.json();
    matchedUsers.value = data.matchedUsers || [];

    // ✅ Only show modal if there are results
    if (matchedUsers.value.length > 0) {
      showModal();
    } else {
      alert("No users found.");
    }
  } catch (error) {
    console.error("Error fetching search results:", error);
  }
};

const selectUser = () => {
  const matchingOption = document.querySelector(
    `#userSuggestions option[value="${searchQuery.value}"]`
  );
  if (matchingOption) {
    userId.value = matchingOption.getAttribute("data-id");
  } else {
    userId.value = null;
  }
};
</script>

<template>
  <Head title="Message" />
  <div class="main-container bg-light d-flex flex-row">
    <!-- Overlay for mobile -->
    <div
      v-if="isSidebarOpen && isMobile"
      class="position-fixed top-0 start-0 w-100 h-100 mobile-overlay"
      @click="toggleSidebar"
    ></div>

    <!-- Sidebar -->
    <div class="sidebar" :class="{ closed: !isSidebarOpen, open: isSidebarOpen }">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 v-if="isSidebarOpen" class="text-success mb-0">Messages</h5>
        <div
          class="flex flex-row align-center gap-2"
          :class="{
            'flex-column justify-content-center align-items-center': !isSidebarOpen,
          }"
        >
          <div>
            <Link
              :href="route('dashboard')"
              class="text-dark d-flex justify-content-center align-items-center"
              title="Go back"
            >
              <i class="bi bi-house back"></i>
            </Link>
          </div>

          <div
            class="bi bi-list pointer text-dark fw-bolder fs-3"
            @click="toggleSidebar"
            :class="{ 'mt-1 d-flex': !isSidebarOpen }"
          ></div>
        </div>
      </div>

      <div v-if="isSidebarOpen" class="input-group mb-3">
        <form
          @submit.prevent="search"
          class="search-form container-fluid d-flex align-items-center justify-content-center gap-2 py-2"
        >
          <div class="position-relative flex-grow-1">
            <input
              type="text"
              class="form-control modern-input ps-5"
              placeholder="Search users..."
              v-model="searchQuery"
              list="userSuggestions"
              @input="selectUser"
            />
            <i
              class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"
            ></i>
            <datalist id="userSuggestions">
              <option
                v-for="user in pinnedChats"
                :key="user.id"
                :value="user.name"
                :data-id="user.id"
              />
            </datalist>
          </div>

          <button class="btn modern-btn px-4" type="submit">
            <i class="bi bi-search"></i>
          </button>
        </form>
      </div>

      <small v-if="isSidebarOpen" class="text-muted">CHATS</small>
      <div v-if="pinnedChats.length === 0" class="mt-2 text-muted">
        Start chatting by searching people.
      </div>

      <PinnedChats
        :pinned="pinnedChats"
        :active="getActiveMessage"
        :hasMessages="hasMessages"
        :users="getUsers"
        :currentUserId="page?.props?.auth?.user.id"
      />

      <img
        v-if="pinnedChats.length === 0"
        src="/images/empty-chat.png"
        alt="No pinned chats"
        class="img-fluid mt-4"
        style="opacity: 0.5"
      />
    </div>

    <!-- ✅ Custom modal (no Bootstrap) -->
    <transition name="modal-fade">
      <div
        v-if="showMatchedUsersModal"
        class="custom-modal-overlay"
        @click.self="hideModal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="matchedUsersModalLabel"
      >
        <div class="custom-modal-dialog" @click.stop>
          <header class="custom-modal-header">
            <h2 id="matchedUsersModalLabel" class="modal-title">Search Results</h2>
            <button aria-label="Close" class="modal-close-btn" @click="hideModal">✕</button>
          </header>

          <section class="custom-modal-body">
            <!-- reuse your SearchResults component -->
            <SearchResults :matchedUsers="matchedUsers" />
          </section>

          <footer class="custom-modal-footer">
            <button class="modal-btn modal-btn-secondary" @click="hideModal">Close</button>
          </footer>
        </div>
      </div>
    </transition>

    <!-- Right content -->
    <main class="right" :class="{ 'sidebar-open': isSidebarOpen }">
      <div class="d-flex flex-row align-items-center gap-2 d-md-none ps-2 pt-2">
        <div class="pointer text-dark fw-bolder fs-3" @click="toggleSidebar">
          <i class="bi bi-list"></i>
        </div>
        <div><p class="message-text">Messages</p></div>
      </div>
      <slot />
    </main>
  </div>
</template>

<style scoped>
@import "../../css/message/layout.css";

/* --------- Mobile overlay (replaces inline style) --------- */
.mobile-overlay {
  background-color: rgba(0, 0, 0, 0.3);
  z-index: 999;
  position: fixed;
  top: 0;
  left: 0;
}

/* --------- Custom modal styles (simple, accessible) --------- */
.custom-modal-overlay {
  position: fixed;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.45);
  z-index: 2000;
  padding: 1rem;
}

/* Dialog */
.custom-modal-dialog {
  width: 100%;
  max-width: 680px;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
  overflow: hidden;
  transform-origin: center center;
  display: flex;
  flex-direction: column;
  max-height: 90vh;
}

/* Header */
.custom-modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem 1.25rem;
  border-bottom: 1px solid #eee;
  background: #fafafa;
}

.modal-title {
  margin: 0;
  font-size: 1.125rem;
  font-weight: 600;
}

/* Close button */
.modal-close-btn {
  background: transparent;
  border: none;
  font-size: 1.125rem;
  cursor: pointer;
  line-height: 1;
  padding: 0.25rem;
}

/* Body */
.custom-modal-body {
  padding: 1rem 1.25rem;
  overflow: auto;
  /* if SearchResults is long, it will scroll inside modal */
}

/* Footer */
.custom-modal-footer {
  padding: 0.75rem 1.25rem;
  border-top: 1px solid #eee;
  display: flex;
  justify-content: flex-end;
  gap: 0.5rem;
  background: #fff;
}

.modal-btn {
  padding: 0.45rem 0.9rem;
  border-radius: 6px;
  border: 1px solid transparent;
  cursor: pointer;
  font-size: 0.95rem;
}

.modal-btn-secondary {
  background: #f1f1f1;
  border-color: #e0e0e0;
}

/* Simple transition */
.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 180ms ease, transform 180ms ease;
}
.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
  transform: scale(0.98);
}
.modal-fade-enter-to,
.modal-fade-leave-from {
  opacity: 1;
  transform: scale(1);
}

/* Responsive consideration */
@media (max-width: 480px) {
  .custom-modal-dialog {
    max-width: 95%;
    border-radius: 8px;
  }

  .modal-title {
    font-size: 1rem;
  }
}
</style>
