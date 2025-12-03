<script setup>
import { ref, onMounted, computed, defineProps } from "vue";
import { usePage, Link } from "@inertiajs/vue3";
import Offcanvas from "@/Components/settings/admin/Offcanvas.vue";
const props = defineProps({
  hasUnread: {
    type: Boolean,
    default: false
  }
});

const page = usePage();
const currentRoute = computed(() => page.url);
const isSidebarOpen = ref(localStorage.getItem("isSidebarOpen") === "true");

// Enhanced route matching with better pattern recognition
const isActiveRoute = (routeName) => {
  const routePath = route(routeName);
  const cleanCurrentRoute = currentRoute.value.split('?')[0]; // Remove query params
  const cleanRoutePath = routePath.split('?')[0];
  
  return cleanCurrentRoute === cleanRoutePath || 
         cleanCurrentRoute.startsWith(cleanRoutePath + '/') ||
         (cleanRoutePath !== '/' && cleanCurrentRoute.includes(cleanRoutePath));
};

const toggleSidebar = () => {
  isSidebarOpen.value = !isSidebarOpen.value;
  localStorage.setItem("isSidebarOpen", isSidebarOpen.value);
};

onMounted(() => {
  isSidebarOpen.value = localStorage.getItem("isSidebarOpen") === "true";
});
</script>

<template>
  <div class="app-container">
    <!-- Sidebar -->
    <aside
      class="sidebar"
      :class="{ 'sidebar--collapsed': !isSidebarOpen }"
    >
      <div class="sidebar__header">
        <h5 v-if="isSidebarOpen" class="sidebar__title">Settings</h5>
        <button 
        class="sidebar__toggle" 
        @click="toggleSidebar"
        :class="{'ms-2': !isSidebarOpen}"
        >
          <i class="bi" :class="isSidebarOpen ? 'bi-chevron-left' : 'bi-chevron-right'"></i>
        </button>
      </div>
      
      <!-- Navigation -->
      <nav class="sidebar__nav">
        <Link
          :href="route('dashboard')"
          class="nav-item"
          :class="{ 
            'nav-item--active': isActiveRoute('dashboard'),
            'nav-item--collapsed': !isSidebarOpen
          }"
        >
          <div class="nav-item__icon">
            <i class="bi bi-house"></i>
          </div>
          <span class="nav-item__text">Dashboard</span>
          <div class="nav-item__active-indicator"></div>
        </Link>

        <Link
          :href="route('settings.trash')"
          class="nav-item"
          :class="{ 
            'nav-item--active': isActiveRoute('settings.index'),
            'nav-item--collapsed': !isSidebarOpen
          }"
        >
          <div class="nav-item__icon">
            <i class="bi bi-trash"></i>
          </div>
          <span class="nav-item__text">Trash</span>
          <div class="nav-item__active-indicator"></div>
        </Link>

        <Link
          :href="route('profile')"
          class="nav-item"
          :class="{ 
            'nav-item--active': isActiveRoute('profile'),
            'nav-item--collapsed': !isSidebarOpen
          }"
        >
          <div class="nav-item__icon">
            <i class="bi bi-person"></i>
          </div>
          <span class="nav-item__text">Profile</span>
          <div class="nav-item__active-indicator"></div>
        </Link>
        
        <Link
          :href="route('settings.privacy')"
          class="nav-item"
          :class="{ 
            'nav-item--active': isActiveRoute('settings.privacy'),
            'nav-item--collapsed': !isSidebarOpen
          }"
        >
          <div class="nav-item__icon">
            <i class="bi bi-shield-check"></i>
          </div>
          <span class="nav-item__text">Privacy</span>
          <div class="nav-item__active-indicator"></div>
        </Link>
      </nav>
    </aside>
    
    <!-- Main Content -->
    <main class="main-content" :class="{ 'main-content--expanded': !isSidebarOpen }">
      <div class="content-wrapper">
        <Offcanvas />
        <slot />
      </div>
    </main>
  </div>
</template>

<style scoped>
@import '../../../css/setttings/admin/layout.css';
</style>