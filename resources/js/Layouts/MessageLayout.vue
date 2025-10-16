<script setup>
import { ref, onMounted, computed, watch } from "vue";
import { Link, usePage, Head, router } from "@inertiajs/vue3";
import BackButton from "@/Components/message/BackButton.vue";
import PinnedChats from "@/Components/message/PinnedChats.vue";
import { useSidebarStore } from "@/piniaStore/useSidebarStore";

const sidebar = useSidebarStore();
const props = defineProps({

  users: {
    type: Object,
    default: () => ({})
  },
  getPinned: {
    type: Object,
    default: () => ({})
  },
  activeMessage: {
    type: Number,
    default: () => null
  },
  currentUserId: {
    type: Number,
  },
  hasMessages: {
    type: Array,
    default: () => []
  },
})

const getUsers = ref([]);
const searchQuery = ref("");
let userId = ref(null);
const pinnedChats = ref([]);
const getActiveMessage = ref(null);
let getCurrentUserId = ref(0);
onMounted(() => {
    pinnedChats.value = Array.isArray(props.getPinned)
        ? props.getPinned
        : Object.values(props.getPinned);
});

watch(
  () => props.users,
  (newUsers) => {
    getUsers.value = Object.entries(newUsers).map(([id, name]) => ({ id, name }))
  },
  { immediate: true }
)
watch(
  () => props.currentUserId,
  (newId) => {
    getCurrentUserId.value = newId;
  },
  {immediate: true}
)
watch(
  () => props.getPinned,
  (newItem) => {
    if (Array.isArray(newItem)) {
        pinnedChats.value = newItem.filter(data => data.id != getCurrentUserId.value);
    }
  },
  {immediate: true}
)
watch(
  () => props.activeMessage,
  (newItem) => {
    getActiveMessage.value = newItem;
  },
  {immediate: true}
)

//Para sa unahan ang pinaka latest na pinned message
const reversePinnedMessage = pinnedChats.value.reverse();

const user = usePage().props.auth?.user;
const currentRoute = usePage().url;
const isSidebarOpen = ref(localStorage.getItem("isSidebarOpen") === "true");
const windowWidth = ref(window.innerWidth);
const isMobile = computed(() => windowWidth.value <= 768);

const toggleSidebar = () => {
    isSidebarOpen.value = !isSidebarOpen.value;
    localStorage.setItem("isSidebarOpen", isSidebarOpen.value);
    sidebar.toggleSidebar();
};

onMounted(() => {
    isSidebarOpen.value = localStorage.getItem("isSidebarOpen") === "true";
    window.addEventListener("resize", () => {
        windowWidth.value = window.innerWidth;
    });
});

const search = () => {
     router.get(route('message.searchV2'), { name: searchQuery.value })
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
const pinnedChatAction = () => {
    let action2 = document.querySelector(".action2");
    action2.style.display = "block";
};
</script>

<template>
    <Head title="Message" />
    <div class="main-container bg-light d-flex flex-row">
        <div
            v-if="isSidebarOpen && isMobile"
            class="position-fixed top-0 start-0 w-100 h-100"
            style="background-color: rgba(0, 0, 0, 0.3); z-index: 999"
            @click="toggleSidebar"
        ></div>

        <div
            class="sidebar"
            :class="{ closed: !isSidebarOpen, open: isSidebarOpen }"
        >
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 v-if="isSidebarOpen" class="text-success mb-0"> Messages</h5>

                <div class="flex flex-row align-center gap-2"
                :class="{'flex-column justify-content-center align-items-center': !isSidebarOpen}"
                >
                    <BackButton 
                    :class="{ 'ms-2': !isSidebarOpen }"
                    />
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
                    class="form container-fluid mx-0 px-0 d-flex flex-row"
                >
                    <input
                        type="text"
                        class="form-control"
                        placeholder="Search users..."
                        v-model="searchQuery"
                        list="userSuggestions"
                        @input="selectUser"
                    />
                    <datalist id="userSuggestions">
                        <option
                            v-for="user in pinnedChats"
                            :key="user.id"
                            :value="user.name"
                            :data-id="user.id"
                        />
                    </datalist>
                    <button class="btn btn-success" type="submit">
                        <i class="bi bi-search"></i>
                    </button>
                </form>
            </div>

            <small v-if="isSidebarOpen" class="text-muted"> CHATS</small>
            <div v-if="pinnedChats.length === 0" class="mt-2 text-muted">
                Start chatting by searching people.
            </div>
            
           
           <PinnedChats 
           :pinned="pinnedChats" 
           :active="getActiveMessage"
           :hasMessages="hasMessages"
            />
            <img
                v-if="pinnedChats.length === 0"
                src="/images/empty-chat.png"
                alt="No pinned chats"
                class="img-fluid mt-4"
                style="opacity: 0.5"
           />
        </div>


        <main class="right" :class="{ 'sidebar-open': isSidebarOpen }">
            <div class="d-flex flex-row align-items-center gap-2 d-md-none ps-2 pt-2">
                 <div
                    class=" pointer text-dark fw-bolder fs-3"
                    @click="toggleSidebar"
                >
                <i class="bi bi-list"></i>
            </div>
                <div>
                    <p class=" message-text">Messages</p>
                </div>
            </div>
            <slot />
        </main>
    </div>
</template>

<style scoped>
.main-container {
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    position: relative;
}
.sidebar {
    background-color: #fff;
    transition: all 0.3s ease;
    overflow-y: hidden;
    height: 100vh;
    padding: 20px;
    width: 350px;
    z-index: 1000;
    position: relative;
    /* border-radius: 0 30px 30px 0; */
}
.sidebar.closed {
    width: 70px;
    padding: 10px 0;
    display: flex;
    align-items: center;
    flex-direction: column;
}
.right {
    width: calc(100% - 280px);
    transition: width 0.3s ease;
    overflow-y: auto;
    height: 100%;
}
.sidebar.closed ~ .right {
    width: calc(100% - 70px);
}
@media screen and (max-width: 768px) {
    .sidebar {
        position: fixed;
        top: 0;
        left: -100%;
        width: 250px;
        height: 100%;
        padding: 20px;
        border-radius: 0;
    }
    .sidebar.open {
        left: 0;
    }
    .sidebar.closed {
        left: -100%;
    }
    .right {
        width: 100% !important;
    }
    .sidebar.open ~ .right {
        filter: brightness(0.6);
    }
}

.pointer {
    cursor: pointer;
}
.pinned-chat-action {
    display: none;
}
.action2 {
    display: none;
    position: absolute;
    right: -15%;
    width: 150px;
    height: 150px;
    background: #f5f5f5;
    margin-top: 3rem;
}
.message-text{
    position: relative;
    transform: translateY(20%);
    font-size: 1.4rem;
}
</style>
