<script setup>
import { ref, onMounted, computed, watch } from "vue";
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

onMounted(() => {
  pinnedChats.value = Array.isArray(props.getPinned)
    ? props.getPinned
    : Object.values(props.getPinned);

  isSidebarOpen.value = localStorage.getItem("isSidebarOpen") === "true";
  window.addEventListener("resize", () => {
    windowWidth.value = window.innerWidth;
  });
});

watch(
  () => props.users,
  (newUsers) => {
    getUsers.value = Object.entries(newUsers).map(([id, name]) => ({ id, name }));
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

// ✅ Show modal only if fetch successful
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
    matchedUsers.value = data.matchedUsers;

    // ✅ Only show modal if there are results
    if (matchedUsers.value.length > 0) {
      const modal = new bootstrap.Modal(
        document.getElementById("matchedUsersModal")
      );
      modal.show();
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
      class="position-fixed top-0 start-0 w-100 h-100"
      style="background-color: rgba(0, 0, 0, 0.3); z-index: 999"
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
      />

      <img
        v-if="pinnedChats.length === 0"
        src="/images/empty-chat.png"
        alt="No pinned chats"
        class="img-fluid mt-4"
        style="opacity: 0.5"
      />
    </div>

    <!-- ✅ Modal (Shown only if fetch successful) -->
    <div
      class="modal fade"
      id="matchedUsersModal"
      tabindex="-1"
      aria-labelledby="matchedUsersModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="matchedUsersModalLabel">
              Search Results
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <SearchResults :matchedUsers="matchedUsers" />
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Close
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Right content -->
    <main class="right" :class="{ 'sidebar-open': isSidebarOpen }">
      <div
        class="d-flex flex-row align-items-center gap-2 d-md-none ps-2 pt-2"
      >
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
</style>
