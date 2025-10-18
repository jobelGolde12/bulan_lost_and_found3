<script setup>
import { ref, onMounted, computed, defineProps } from "vue";
import { usePage, Link } from "@inertiajs/vue3";
import LogoutButton from "@/Components/user/LogoutButton.vue";
import Offcanvas from "@/Components/settings/user/Offcanvas.vue";
const props = defineProps({
  hasUnread: {
    type: Boolean,
    default: false
  }
});

console.log("Has Unread Notifications:", props.hasUnread);

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
          :href="route('profile')"
          class="nav-item"
          :class="{ 
            'nav-item--active': isActiveRoute('profile'),
            'nav-item--collapsed': !isSidebarOpen
          }"
        >
          <div class="nav-item__icon">
            <i class="bi bi-person"></i>
            <span v-if="props.hasUnread" class="notification-badge bg-success "></span>
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
        <Offcanvas :hasUnread="props.hasUnread"/>
        <slot />
      </div>
    </main>
  </div>
</template>

<style scoped>
.app-container {
  display: flex;
  width: 100vw;
  height: 100vh;
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  overflow: hidden;
}

/* Sidebar Styles */
.sidebar {
  width: 280px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border-right: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 
    0 8px 32px rgba(0, 0, 0, 0.1),
    inset 1px 0 0 rgba(255, 255, 255, 0.5);
  display: flex;
  flex-direction: column;
  padding: 1.5rem;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  z-index: 10;
}

.sidebar--collapsed {
  width: 80px;
  padding: 1rem 0.75rem;
}

.sidebar__header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.sidebar__title {
  font-weight: 700;
  font-size: 1.25rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  margin: 0;
}

.sidebar__toggle {
  background: rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 12px;
  padding: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.sidebar__toggle:hover {
  background: rgba(255, 255, 255, 1);
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.sidebar__toggle--rotated {
  transform: rotate(180deg);
}

/* Navigation Styles */
.sidebar__nav {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  flex: 1;
}

.nav-item {
  display: flex;
  align-items: center;
  padding: 0.875rem 1rem;
  border-radius: 16px;
  text-decoration: none;
  color: #64748b;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
  background: transparent;
  border: 1px solid transparent;
  cursor: pointer;
}

.nav-item:hover {
  background: rgba(255, 255, 255, 0.8);
  color: #334155;
  transform: translateY(-1px);
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}

.nav-item--active {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-color: rgba(255, 255, 255, 0.2);
  box-shadow: 
    0 8px 24px rgba(102, 126, 234, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
}

.nav-item--active:hover {
  background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
  transform: translateY(-1px);
  box-shadow: 
    0 12px 28px rgba(102, 126, 234, 0.4),
    inset 0 1px 0 rgba(255, 255, 255, 0.2);
}

.nav-item--collapsed {
  justify-content: center;
  padding: 0.875rem;
}

.nav-item--logout {
  margin-top: auto;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
  padding-top: 1rem;
}

.nav-item__icon {
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.3s ease;
  position: relative;
}

.nav-item:hover .nav-item__icon {
  transform: scale(1.1);
}

.nav-item--active .nav-item__icon {
  transform: scale(1.1);
}

.nav-item__text {
  font-weight: 500;
  margin-left: 0.75rem;
  transition: all 0.3s ease;
  white-space: nowrap;
}

.sidebar--collapsed .nav-item__text {
  opacity: 0;
  width: 0;
  margin-left: 0;
}

.nav-item__active-indicator {
  position: absolute;
  right: 1rem;
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.8);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.nav-item--active .nav-item__active-indicator {
  opacity: 1;
}

.sidebar--collapsed .nav-item__active-indicator {
  right: 0.5rem;
}

/* Notification Badge */
.notification-badge {
position: absolute; /* Use absolute positioning */
  top: -0.5em; /* Adjust as needed */
  right: -.5em; /* Adjust as needed */
  width: 1.2em; /* Adjust as needed */
  height: 1.1em; /* Adjust as needed */
  color: white;
  border-radius: 50%;
  border: 2px solid white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.7em; /* Adjust as needed */
  font-weight: bold;
}

@keyframes pulse {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  50% {
    transform: scale(1.2);
    opacity: 0.7;
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

/* Sidebar Footer */
.sidebar__footer {
  margin-top: auto;
  padding-top: 1rem;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
}

/* Main Content Styles */
.main-content {
  flex: 1;
  padding: 2rem;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow-y: auto;
}

.main-content--expanded {
  margin-left: 0;
}

.content-wrapper {
  max-width: 1200px;
  margin: 0 auto;
}

/* Smooth transitions for all interactive elements */
* {
  transition: color 0.3s ease, background-color 0.3s ease, border-color 0.3s ease;
}

/* Custom scrollbar for modern look */
.main-content::-webkit-scrollbar {
  width: 6px;
}

.main-content::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.05);
  border-radius: 3px;
}

.main-content::-webkit-scrollbar-thumb {
  background: rgba(0, 0, 0, 0.2);
  border-radius: 3px;
}

.main-content::-webkit-scrollbar-thumb:hover {
  background: rgba(0, 0, 0, 0.3);
}
.button-container{
    position: relative;
    bottom: -10rem;
}
.has-unread-notifications {
  position: absolute; 
  top: 1em;
  right: 1em; 
  width: 1.5em; 
  height: 1.5em; 
  background-color: #e53e3e;
  color: white;
  border-radius: 50%;
  border: 2px solid white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.7em;
  font-weight: bold;
}
/* Mobile responsiveness */
@media (max-width: 768px) {
  .sidebar {
    position: fixed;
    height: 100vh;
    z-index: 1000;
    transform: translateX(0);
  }
  
  .sidebar--collapsed {
    transform: translateX(-100%);
  }
  
  .main-content {
    padding: 1rem;
    width: 100%;
  }
  
  .main-content--expanded {
    margin-left: 0;
  }
}
</style>