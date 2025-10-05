<script setup>
import { usePage, router } from "@inertiajs/vue3";
import { Link } from "@inertiajs/vue3";
import { ref, onMounted, defineProps } from "vue";
import PopupLogin from "@/Components/guest/PopupLogin.vue";
import LoginButton from "@/Components/guest/LoginButton.vue";

const currentRoute = usePage().url;

const props = defineProps({
  isHavePending: {
    type: Boolean,
    default: false,
  },
});

const showModal = ref(false);
const user = usePage().props.auth?.user;
const isSidebarOpen = ref(localStorage.getItem("isSidebarOpen") === "true");

const toggleSidebar = () => {
  isSidebarOpen.value = !isSidebarOpen.value;
  localStorage.setItem("isSidebarOpen", isSidebarOpen.value);
};

onMounted(() => {
  isSidebarOpen.value = localStorage.getItem("isSidebarOpen") === "true";
});

// Open modal manually
const openLoginModal = () => {
  showModal.value = true;
};
</script>

<template>
  <div
    class="main-container bg-light d-flex flex-row justify-content-between align-items-center"
  >
    <!-- Sidebar -->
    <div
      class="sidebar"
      :class="{ closed: !isSidebarOpen }"
      :style="{
        width: isSidebarOpen ? '250px' : '5%',
        padding: isSidebarOpen ? '20px' : '0'
      }"
    >
      <div class="d-flex flex-row justify-content-between align-items-center">
        <div class="mb-0 d-block name fs-5" v-if="isSidebarOpen">Guest</div>
        <div
          class="bi bi-list pointer text-dark fw-bolder fs-3"
          @click="toggleSidebar"
          :class="{ 'mt-3': !isSidebarOpen }"
        ></div>
      </div>

      <div class="list mt-4">
        <Link
          :href="route('guest.dashboard')"
          :class="{ active: currentRoute === '/guest-dashboard' }"
        >
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-journal-text link"></i>
          </div>
          <span v-if="isSidebarOpen">Reports</span>
        </Link>

        <a href="#" @click="openLoginModal" class="pointer">
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-pencil-square link"></i>
          </div>
          <span v-if="isSidebarOpen">Post</span>
        </a>

        <hr />

        <a
          href="#"
           @click="openLoginModal" 
           class="pointer"
        >
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-person link"></i>
          </div>
          <span v-if="isSidebarOpen">Profile</span>
        </a>

        <a
          href="#"
          @click="openLoginModal" 
           class="pointer"
        >
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-gear link"></i>
          </div>
          <span v-if="isSidebarOpen">Settings</span>
        </a>

        <a
          href="#"
          @click="openLoginModal" 
           class="pointer"
        >
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-chat-dots link"></i>
          </div>
          <span v-if="isSidebarOpen">Message</span>
        </a>

        <Link
          :href="route('my.pending')"
          :class="{ active: currentRoute === route('my.pending') }"
          class="btn btn-primary bg-primary text-light"
          type="button"
          v-if="props.isHavePending"
        >
          <span
            class="spinner-grow spinner-grow-sm me-2"
            role="status"
            aria-hidden="true"
          ></span>
          <span v-if="isSidebarOpen">Pending Requests</span>
        </Link>
      </div>

      <LoginButton />
    </div>

    <!-- Page Content -->
    <main :style="{ width: isSidebarOpen ? '80%' : '95%' }" class="right">
      <slot />
    </main>

    <PopupLogin v-if="showModal" @close="showModal = false" />
  </div>
</template>

<style scoped>
@import "../../css/global.css";
@import "../../css/guessLayout.css";
.pointer {
  cursor: pointer;
}
</style>
