<script setup>
import { usePage } from "@inertiajs/vue3";
import { Link } from "@inertiajs/vue3";
import { ref, onMounted, defineProps,watch } from "vue";
import LogoutButton from "@/Components/user/LogoutButton.vue";
const currentRoute = usePage().url;

const props = defineProps({
  isHavePending: {
    type: Boolean,
    default: false,
  },
});

const hasPendingRequests = ref(false);

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
      class="sidebar"
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
          :class="{ 'mt-3': !isSidebarOpen }"
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
        :href="route('my.pending')" 
        :class="{ active: currentRoute === route('my.pending') }"
        class="btn btn-primary bg-primary text-light" type="button" 
        v-if="props.isHavePending"
        >
          <span class="spinner-grow spinner-grow-sm me-2" role="status" aria-hidden="true"></span>
          <span v-if="isSidebarOpen">Pending Requests</span>
        </Link>

                <Link
          :href="route('settings.announcements')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-success text-white': currentRoute === '/settings/announcements' }"
        >
          <i class="bi bi-megaphone me-2"></i>
          <span v-if="isSidebarOpen">Announcements</span>
        </Link>
        
      </div>
    </div>
    <!-- Page Content -->
    <main 
    :style="{ width: isSidebarOpen ? '80%' : '95%' }" 
    class="right">
      <slot />
    </main>
  </div>
</template>

<style scoped>
@import '../../css/global.css';

.main-container {
  position: absolute;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
}

/* Sidebar Defaults */
.sidebar {
  position: relative;
  top: 0;
  height: 100vh;
  background-color: #fff;
  transition: all 0.3s ease;
  overflow: hidden;
  font-size: large;
  border-radius: 0 30px 30px 0;
  padding: 20px;
  width: 250px;
}

.sidebar.closed {
  width: 5%;
  padding: 0;
  display: flex;
  align-items: center;
  flex-direction: column;
}

.sidebar .list a {
  display: flex;
  align-items: center;
  color: #343a40;
  padding: 10px;
  margin-bottom: 3px;
  text-decoration: none;
  border-radius: 5px;
  transition: 0.2s;
  background: transparent;
  text-align: left;
}

.sidebar .list a .icon-container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.sidebar .list a i {
  margin-right: 10px;
}

.sidebar.closed .list a {
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.sidebar.closed .list a i {
  margin-right: 0;
}

.sidebar .list a span {
  white-space: nowrap;
}

.sidebar .list a.active {
  background: rgba(170, 167, 167, 0.3);
}

.sidebar .list a:not(.active):hover {
  background: rgba(129, 125, 125, 0.1);
}

.admin-text {
  transform: translateY(-20%);
}
.name {
  transform: translateY(20%);
}

/* Right Panel */
.right {
  position: relative;
  height: 100%;
  transition: all 0.3s ease;
  width: calc(100% - 250px);
}

.sidebar.closed ~ .right {
  width: calc(100% - 5%);
}


/* Mobile View */
@media screen and (max-width: 800px) {
  .sidebar {
    width: 250px;
  }

  .sidebar.closed {
    width: 10% !important;
  }

  .right {
    width: 90% !important;
  }

  .sidebar.closed ~ .right {
    width: 90% !important;
  }

  .sidebar.open ~ .right {
    width: calc(100% - 250px) !important;
  }
}
</style>
