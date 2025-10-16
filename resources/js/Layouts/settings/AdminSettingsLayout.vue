<script setup>
import { ref, onMounted, computed, defineProps } from "vue";
import { usePage, Link } from "@inertiajs/vue3";

const props = defineProps({
  hasUnread: {
    type: Boolean,
    default: false
  }
});

const page = usePage();
const currentRoute = computed(() => page.url); // reactive route tracking
const isSidebarOpen = ref(localStorage.getItem("isSidebarOpen") === "true");

// Helper function to check if current route matches
const isActiveRoute = (routeName) => {
  const routePath = route(routeName);
  return currentRoute.value === routePath || currentRoute.value.startsWith(routePath + '/');
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
  <div class="d-flex vh-100 bg-light main-container">
    <aside
      class="bg-white shadow-sm transition-all d-flex flex-column sidebar"
      :class="isSidebarOpen ? 'p-4' : 'p-2'"
      :style="{ 'min-width': isSidebarOpen ? '250px' : '70px' }"
    >
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 v-if="isSidebarOpen" class="mb-0 text-dark">Settings</h5>
        <button class="p-1" @click="toggleSidebar">
          <i class="bi bi-list fs-3"></i>
        </button>
      </div>
      
      <!-- Sidebar Links -->
      <nav class="nav d-flex flex-column gap-2">
        <Link
          :href="route('dashboard')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-primary text-white': isActiveRoute('dashboard') }"
        >
          <i class="bi bi-house me-2"></i>
          <span v-if="isSidebarOpen">Home</span>
        </Link>

        <Link
          :href="route('settings.index')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-primary text-white': isActiveRoute('settings.index') }"
        >
          <i class="bi bi-trash me-2"></i>
          <span v-if="isSidebarOpen">Trash</span>
        </Link>
      

        <Link
          :href="route('profile')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-success text-white': isActiveRoute('profile') }"
        >
          <div :class="{ 'icon-container': !isSidebarOpen }">
            <i class="bi bi-person link pe-2"></i>
          </div>
          <span v-if="isSidebarOpen">Profile</span>
        </Link>
        
        <Link
          :href="route('settings.privacy')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-primary text-white': isActiveRoute('settings.privacy') }"
        >
          <i class="bi bi-shield-check me-2"></i>
          <span v-if="isSidebarOpen">Privacy</span>
        </Link>
      </nav>
    </aside>
    
    <!-- Main Content -->
    <main class="flex-grow-1 p-4">
      <slot />
    </main>
  </div>
</template>

<style scoped>
.sidebar{
  min-width: 250px;
}
.main-container {
  width: 100vw;
  height: 100vh;
  overflow: hidden;
}
</style>