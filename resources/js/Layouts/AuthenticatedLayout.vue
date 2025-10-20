<script setup>
import { usePage } from "@inertiajs/vue3";
import { Link } from "@inertiajs/vue3";
import { ref, onMounted, defineProps,watch, computed } from "vue";
import LogoutButton from "@/Components/user/LogoutButton.vue";
import LayoutRoutes from "@/Components/user/LayoutRoutes.vue";
const currentRoute = usePage().url;

const props = defineProps({
  isHavePending: {
    type: Boolean,
    default: false,
  },
 announcement: {
  type: Array,
  default: () => [],
 }
});

const hasPendingRequests = ref(false);
const hasAnnouncements = computed(() => props.announcement.length - 1 || 0);

watch(() => props.isHavePending, (newValue) => {
  hasPendingRequests.value = newValue;
});

const user = usePage().props.auth?.user;
const isSidebarOpen = ref(localStorage.getItem('isSidebarOpen') === 'true');

const toggleSidebar = () => {
  isSidebarOpen.value = !isSidebarOpen.value;
  localStorage.setItem('isSidebarOpen', isSidebarOpen.value);
};

onMounted(() => {
  isSidebarOpen.value = localStorage.getItem('isSidebarOpen') === 'true';
});
</script>
<template>
  <div class="main-container bg-light d-flex flex-row justify-content-between align-items-center">
    <div
      class="sidebar d-none d-lg-block"
      :class="{ 'closed': !isSidebarOpen }"
      :style="{
        width: isSidebarOpen ? '250px' : '5%',
        padding: isSidebarOpen ? '20px' : '0'
      }"
    >
      <div class="d-flex flex-row justify-content-between align-items-center">
        <Link
          v-if="isSidebarOpen"
          :href="route('profile')"
          class="pointer user-name text-dark text-decoration-none d-flex flex-column gap-0"
        >
          <span class="mb-0 d-block name">{{ user.name }} </span>
          <span class="text-success text-lighter text-sm d-block user-text">user</span>
        </Link>
        <div
          class="bi bi-list pointer text-dark fw-bolder fs-3"
          @click="toggleSidebar"
          :class="{ 'mt-3 mx-auto': !isSidebarOpen }"
        ></div>
      </div>

      <div class="list mt-4">
        <Link
          :href="route('dashboard')"
          :class="{ active: currentRoute === '/dashboard' }"
        >
          <div :class="{'icon-container' : !isSidebarOpen}">
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

        <hr>
        <!-- =========================== -->
        

        <Link :href="route('settings.index')" :class="{ active: currentRoute === route('settings.index') }">
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-gear link"></i>
          </div>
          <span v-if="isSidebarOpen">Settings</span>
        </Link>

         <Link :href="route('message.index')" :class="{ active: currentRoute === route('settings.index') }">
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-chat-dots link"></i>
          </div>
          <span v-if="isSidebarOpen">Message</span>
        </Link>

       

                <Link
          :href="route('settings.announcements')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-success text-white': currentRoute === '/settings/announcements' }"
        >
          <i class="bi bi-megaphone me-2"></i>
          <span v-if="isSidebarOpen">Announcements</span>

           <span v-if="hasAnnouncements" class="pending-badge">
              {{ hasAnnouncements }}
            </span>
        </Link>

         <Link 
        :href="route('my.pending')" 
        :class="{ active: currentRoute === route('my.pending') }"
        class="btn btn-primary bg-primary text-light" type="button" 
        v-if="props.isHavePending"
        >
          <span class="spinner-grow spinner-grow-sm me-2" role="status" aria-hidden="true"></span>
          <span v-if="isSidebarOpen">Pending Requests</span>
        </Link>
        
      </div>
    </div>
    <!-- Page Content -->
    <main 
    :style="{ width: isSidebarOpen ? '80%' : '95%' }" 
    class="right">
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
          <span class="text-success text-lighter text-sm d-block admin-text">user</span>
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

</style>
