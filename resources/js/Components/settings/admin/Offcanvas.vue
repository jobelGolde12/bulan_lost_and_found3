<script setup>
import { ref, computed } from "vue";
import { usePage, Link } from "@inertiajs/vue3";

const page = usePage();
const currentRoute = computed(() => page.url);
const isActiveRoute = (routeName) => {
  const routePath = route(routeName);
  const cleanCurrentRoute = currentRoute.value.split('?')[0]; // Remove query params
  const cleanRoutePath = routePath.split('?')[0];
  
  return cleanCurrentRoute === cleanRoutePath || 
         cleanCurrentRoute.startsWith(cleanRoutePath + '/') ||
         (cleanRoutePath !== '/' && cleanCurrentRoute.includes(cleanRoutePath));
};
</script>

<template>
  <div>

     <!-- Offcanvas for Admin Profile Settings Page -->
      <button class="modern-menu-toggle ms-2" data-bs-toggle="offcanvas" href="#offcanvasExample" role="button" aria-controls="offcanvasExample" aria-label="Toggle navigation menu">
          <div class="hamburger">
            <span class="hamburger-line hamburger-line-1"></span>
            <span class="hamburger-line hamburger-line-2"></span>
            <span class="hamburger-line hamburger-line-3"></span>
          </div>
          <span class="menu-text">Menu</span>
      </button>

      <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
        <div class="offcanvas-header">
          <h5 class="offcanvas-title" id="offcanvasExampleLabel">Settings</h5>
          <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
          <!-- Navigation -->
            <nav class="sidebar__nav">
                <Link
                :href="route('dashboard')"
                class="nav-item"
                :class="{ 
                    'nav-item--active': isActiveRoute('dashboard'),
                }"
                >
                <div class="nav-item__icon">
                    <i class="bi bi-house"></i>
                </div>
                <span class="nav-item__text">Dashboard</span>
                <div class="nav-item__active-indicator"></div>
                </Link>

                <Link
                :href="route('settings.index')"
                class="nav-item"
                :class="{ 
                    'nav-item--active': isActiveRoute('settings.index'),
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
                }"
                >
                <div class="nav-item__icon">
                    <i class="bi bi-shield-check"></i>
                </div>
                <span class="nav-item__text">Privacy</span>
                <div class="nav-item__active-indicator"></div>
                </Link>
            </nav>
        </div>
      </div>

  </div>
</template>



<style scoped>
@import '../../../../css/setttings/admin/layout.css';
@import '../../../../css/setttings/menu.css';

</style>