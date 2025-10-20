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
  <div>
      <div
      class="sidebar w-100 px-0  px-0"
      style="transform: translateY(-5%);"
    >

       <div class="list mt-4">
        <Link
          :href="route('dashboard')"
          :class="{ active: currentRoute === '/dashboard' }"
        >
          <div class="icon-wrapper">
            <i class="bi bi-journal-text link"></i>
          </div>
          <span>Reports</span>
        </Link>

        <Link :href="route('reportItem')" :class="{ active: currentRoute === '/report-item' }">
          <div class="icon-wrapper">
            <i class="bi bi-pencil-square link"></i>
          </div>
          <span >Post</span>
        </Link>

        <hr>
        <!-- =========================== -->
        

        <Link :href="route('settings.index')" :class="{ active: currentRoute === route('settings.index') }">
          <div class="icon-wrapper">
            <i class="bi bi-gear link"></i>
          </div>
          <span>Settings</span>
        </Link>

         <Link :href="route('message.index')" :class="{ active: currentRoute === route('settings.index') }">
          <div class="icon-wrapper">
            <i class="bi bi-chat-dots link"></i>
          </div>
          <span >Message</span>
        </Link>

       

                <Link
          :href="route('settings.announcements')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-success text-white': currentRoute === '/settings/announcements' }"
        >
          <i class="bi bi-megaphone me-2"></i>
          <span >Announcements</span>

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
          <span >Pending Requests</span>
        </Link>
        
      </div>
    </div>
  </div>
</template>



<style>
@import '../../../css/user/layout.css';
</style>