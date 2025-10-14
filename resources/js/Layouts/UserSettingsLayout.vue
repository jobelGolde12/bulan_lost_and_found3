<script setup>
import { ref, onMounted } from "vue";
import { usePage } from "@inertiajs/vue3";
import { Link } from "@inertiajs/vue3";
import LogoutButton from "@/Components/user/LogoutButton.vue";
const currentRoute = usePage().url; // Get the current route for active link styling
const isSidebarOpen = ref(localStorage.getItem("isSidebarOpen") === "true");

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
        <button class=" p-1" @click="toggleSidebar">
          <i class="bi bi-list fs-3"></i>
        </button>
      </div>
      
      <!-- Sidebar Links -->
      <nav class="nav d-flex flex-column gap-2">
        <Link
          :href="route('dashboard')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-primary text-white': currentRoute === route('dashboard') }"
        >
          <i class="bi bi-house me-2"></i>
          <span v-if="isSidebarOpen">Home</span>
        </Link>

          <Link
          :href="route('profile')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-success text-white': currentRoute.includes('profile') }"
        >
          <div :class="{'icon-container' : !isSidebarOpen}">
            <i class="bi bi-person link me-2"></i>
          </div>
          <span v-if="isSidebarOpen">Profile</span>
        </Link>
        
        <Link
          :href="route('settings.privacy')"
          class="nav-link d-flex align-items-center p-2 rounded text-decoration-none text-dark"
          :class="{ 'bg-primary text-white': currentRoute === route('settings.privacy') }"
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
.main-container{
    width: 100vw;
    height: 100vh;
    overflow: hidden;
}
.sidebar{
  min-width: 250px;
}
</style>