
<script setup>
import { usePage } from "@inertiajs/vue3";
import { Link } from "@inertiajs/vue3";
import { ref, onMounted, defineProps, watch } from "vue";
import { usePendingRequestStore } from "@/piniaStore/pendingRequestStore";
import { storeToRefs } from "pinia"
import { computed } from "vue";
import axios from "axios";

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
  <div>
     <div
      class="sidebar w-100 px-0 mt-0"
      style="transform: translateY(-10%)"
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
      </div>

      <div class="list mt-4">
        <Link :href="route('dashboard')" :class="{ active: currentRoute === '/dashboard' }">
          <div class="icon-wrapper">
            <i class="bi bi-house link"></i>
          </div>
          <span>Home</span>
        </Link>

        <Link :href="route('items')" :class="{ active: currentRoute === '/items' }">
          <div>
            <i class="bi bi-journal-text link"></i>
          </div>
          <span>Reports</span>
        </Link>

        <Link :href="route('reportItem')" :class="{ active: currentRoute === '/report-item' }">
          <div class="icon-wrapper">
            <i class="bi bi-pencil-square link"></i>
          </div>
          <span>Post</span>
        </Link>

        <Link
          :href="route('viewPendingRequest')"
          :class="{ active: currentRoute === '/view-pending-request' }"
          class="nav-link"
        >
          <div class="icon-wrapper">
            <i class="bi bi-envelope-paper link"></i>

            <span v-if="hasPendingRequest > 0" class="pending-badge">
              {{ hasPendingRequest }}
            </span>
          </div>
          <span>Requests</span>
        </Link>

        <Link
          :href="route('findMatch.index')"
          class="icon-wrapper"
        >
          <div class="icon-wrapper">
            <i class="bi bi-magic link"></i>
          </div>
          <span>Find Match</span>
        </Link>

        <hr />

        <Link :href="route('trash.index')" :class="{ active: currentRoute === '/trash-trash-item' }">
          <div class="icon-wrapper">
            <i class="bi bi-gear link"></i>
          </div>
          <span>Settings</span>
        </Link>

       <Link :href="route('message.index')" :class="{ active: currentRoute === route('message.index') }">
            <div class="icon-wrapper">
              <i class="bi bi-chat-dots link"></i>

              <span v-if="hasMessages && (hasMessages - 1) != 0" class="has-message">{{ hasMessages - 1 }}</span>
            </div>
            <span>Message</span>
          </Link>

        <Link :href="route('view.users')" :class="{ active: currentRoute === '/view-users' }">
          <div class="icon-wrapper">
            <i class="bi bi-people link"></i>
          </div>
          <span>Users</span>
        </Link>

        
        <Link
          :href="route('settings.announcements')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'active': currentRoute === '/settings/announcements' }"
        >
          <i class="bi bi-megaphone me-2"></i>
          <span>Announcement</span>
        </Link>

      </div>
    </div>
  </div>
</template>

<style>
@import '../../../css/admin/layout.css';
.sidebar {
  position: relative;
  height: 100%;
  background-color: #fff;
  transition: all 0.3s ease;
  overflow: hidden;
  font-size: large;
  border-radius: 0 30px 30px 0;
}
</style>