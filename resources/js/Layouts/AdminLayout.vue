<script setup>
import { usePage } from "@inertiajs/vue3";
import { Link } from "@inertiajs/vue3";
import { ref, onMounted, defineProps, watch } from "vue";
import { usePendingRequestStore } from "@/piniaStore/pendingRequestStore";
import { storeToRefs } from "pinia"
import { computed } from "vue";
import axios from "axios";
import LayoutRoutes from "@/Components/admin/LayoutRoutes.vue";

const currentRoute = usePage().url;
const user = usePage().props.auth?.user;
const isSidebarOpen = ref(localStorage.getItem('isSidebarOpen') === 'true');
const { count } = storeToRefs(usePendingRequestStore());
const hasPendingRequest = computed(() => count.value || 0);
let hasMessages = ref(false);

const toggleSidebar = () => {
  isSidebarOpen.value = !isSidebarOpen.value;
  localStorage.setItem('isSidebarOpen', isSidebarOpen.value);
};

onMounted(() => {
  isSidebarOpen.value = localStorage.getItem('isSidebarOpen') === 'true';
});

const checkIfHasMessage = async () => {
  try{
    const response = await axios.get('/message/has')
    hasMessages.value = response.data;
    console.log("has message: ", hasMessages.value)
  }catch(e){
    console.log("An error while checking if has message", e);  
  }
}
onMounted(() => {
  checkIfHasMessage();
})
</script>

<template>
  <div class="main-container bg-light d-flex flex-row justify-content-between align-items-center">
    <!-- Sidebar -->
    <div
      class="sidebar d-none d-lg-block"
      :class="{ closed: !isSidebarOpen, open: isSidebarOpen }"
      :style="{
        minWidth: isSidebarOpen ? '250px' : '5%',
        padding: isSidebarOpen ? '20px' : '0'
      }"
    >
      <div class="d-flex flex-row justify-content-between align-items-center">
        <Link
          v-if="isSidebarOpen"
          :href="route('profile')"
          class="pointer user-name text-dark text-decoration-none d-flex flex-column gap-0"
        >
          <span class="mb-0 d-block name">{{ user.name }}</span>
          <span class="text-success text-lighter text-sm d-block admin-text">admin</span>
        </Link>
        <div
          class="bi bi-list pointer text-dark fw-bolder fs-3"
          @click="toggleSidebar"
          :class="{ 'mt-3 mx-auto': !isSidebarOpen }"
        ></div>
      </div>

      <div class="list mt-4">
        <Link :href="route('dashboard')" :class="{ active: currentRoute === '/dashboard' }">
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-house link"></i>
          </div>
          <span v-if="isSidebarOpen">Home</span>
        </Link>

        <Link :href="route('items')" :class="{ active: currentRoute === '/items' }">
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-journal-text link"></i>
          </div>
          <span v-if="isSidebarOpen">Reports</span>
        </Link>

        <Link :href="route('reportItem')" :class="{ active: currentRoute === '/report-item' }">
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-pencil-square link"></i>
          </div>
          <span v-if="isSidebarOpen">Post</span>
        </Link>

        <Link
          :href="route('viewPendingRequest')"
          :class="{ active: currentRoute === '/view-pending-request' }"
          class="nav-link"
        >
          <div :class="{ 'icon-container': !isSidebarOpen }" class="icon-wrapper">
            <i class="bi bi-envelope-paper link"></i>

            <span v-if="hasPendingRequest > 0" class="pending-badge">
              {{ hasPendingRequest }}
            </span>
          </div>
          <span v-if="isSidebarOpen">Requests</span>
        </Link>

        <Link
          :href="route('findMatch.index')"
          :class="{ active: currentRoute === '/find-match' }"
          class="nav-link"
        >
          <div :class="{ 'icon-container': !isSidebarOpen }" class="icon-wrapper">
            <i class="bi bi-magic link"></i>
          </div>
          <span v-if="isSidebarOpen">Find Match</span>
        </Link>

        <hr />

        <Link :href="route('trash.index')" :class="{ active: currentRoute === '/trash-trash-item' }">
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-gear link"></i>
          </div>
          <span v-if="isSidebarOpen">Settings</span>
        </Link>

       <Link :href="route('message.index')" :class="{ active: currentRoute === route('message.index') }">
            <div :class="{ 'icon-container': !isSidebarOpen }" class="icon-wrapper">
              <i class="bi bi-chat-dots link"></i>

              <span v-if="hasMessages && (hasMessages - 1) != 0" class="has-message">{{ hasMessages - 1 }}</span>
            </div>
            <span v-if="isSidebarOpen">Message</span>
          </Link>

        <Link :href="route('view.users')" :class="{ active: currentRoute === '/view-users' }">
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-people link"></i>
          </div>
          <span v-if="isSidebarOpen">Users</span>
        </Link>

        
        <Link
          :href="route('settings.announcements')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'active': currentRoute === '/settings/announcements' }"
        >
          <i class="bi bi-megaphone me-2"></i>
          <span v-if="isSidebarOpen">Announcement</span>
        </Link>

      </div>
    </div>

    <!-- Main Content -->
    <main class="right"
    :style="{ width: isSidebarOpen ? '80%' : '100%' }" 
    :class="{ 'sidebar-open': isSidebarOpen }">
      <div class="container-fluid d-flex justify-content-between align-items-center mt-3 d-block d-lg-none">
        <div>
          <i class="bi bi-list fs-1" data-bs-toggle="offcanvas" data-bs-target="#openSidebar" aria-controls="openSidebar"></i>
        </div>

        <div>
          <img src="../../images/lost_and_found_logo.png" alt="" class="profile">
        </div>
      </div>
      <slot />
    </main>





<div class="offcanvas offcanvas-start" tabindex="-1" id="openSidebar" aria-labelledby="openSidebarLabel">
  <div class="offcanvas-header">
        <Link
          :href="route('profile')"
          class="pointer user-name text-dark text-decoration-none d-flex flex-column gap-0"
        >
          <span class="mb-0 d-block name">{{ user.name }}</span>
          <span class="text-success text-lighter text-sm d-block admin-text">admin</span>
        </Link>

    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    <div>
      <LayoutRoutes />
    </div>
  </div>
</div>

  </div>
</template>

<style scoped>
@import '../../css/global.css';
@import '../../css/admin/layout.css';
</style>
