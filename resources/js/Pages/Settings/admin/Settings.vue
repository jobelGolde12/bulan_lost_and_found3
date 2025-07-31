<script setup>
import AdminSettingsLayout from '@/Layouts/settings/AdminSettingsLayout.vue';
import { Head, Link } from '@inertiajs/vue3';

const userSettings = [
  {
    name: "Profile",
    description: "View and update your personal information.",
    link: route('profile'),
  },
  {
    name: "Change Password",
    description: "Update your account password.",
    link: route('profile'),
  },
  {
    name: "View History",
    description: "See a history of your reports.",
    link: route('profile'),
  },
  {
    name: "Trash",
    description: "View and manage deleted reports.",
    link: route('profile'),
  },
  {
    name: "Logout",
    description: "Log out of your account.",
    link: route('logout'),
  },
];
</script>

<template>
  <Head title="Settings" />
  <AdminSettingsLayout>
    <div class="admin-settings-container">
      <h1 class="text-3xl font-bold mb-8 text-gray-800">Admin Settings</h1>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
        <div
          v-for="setting in userSettings"
          :key="setting.name"
          class="card group"
        >
          <h2 class="text-xl font-semibold text-gray-700 mb-2 group-hover:text-blue-500 transition">{{ setting.name }}</h2>
          <p class="text-gray-500 mb-4">{{ setting.description }}</p>
          <Link
            :href="setting.link"
            class="inline-block px-5 py-2 bg-blue-600 text-white rounded-lg shadow-md hover:bg-blue-700 transition"
          >
            Go to {{ setting.name }}
          </Link>
        </div>
      </div>
    </div>
  </AdminSettingsLayout>
</template>

<style scoped>
.admin-settings-container {
  padding: 2rem;
  width: 100%;
  min-height: 100vh;
  background-color: #f9fafb;
}
.card {
  background-color: #ffffff;
  border-radius: 0.75rem;
  padding: 1.5rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease-in-out;
}
.card:hover {
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
  transform: translateY(-3px);
}
</style>