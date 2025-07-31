<script setup>
import UserSettingsLayout from '@/Layouts/UserSettingsLayout.vue';
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
    // link: route('password.change'),
    link: route('profile'),
  },
  {
    name: "View History",
    description: "See a history of your reports.",
    // link: route('history'),
    link: route('profile'),
  },
  {
    name: "Trash",
    description: "View and manage deleted reports.",
    // link: route('trash'),
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
  <UserSettingsLayout>
    <div class="user-settings-container">
      <h1 class="text-2xl font-bold mb-6">User Settings</h1>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
        <div
          v-for="setting in userSettings"
          :key="setting.name"
          class="card bg-white shadow-md rounded-lg p-4 hover:shadow-lg transition"
        >
          <h2 class="text-lg font-semibold mb-2">{{ setting.name }}</h2>
          <p class="text-gray-500 mb-3">{{ setting.description }}</p>
          <Link
            :href="setting.link"
            class="inline-block px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition"
          >
            Go to {{ setting.name }}
          </Link>

        </div>
      </div>
    </div>


  </UserSettingsLayout>
</template>

<style scoped>
.user-settings-container {
  padding: 1.5rem;
}
.card {
  background-color: #ffffff;
  border-radius: 0.5rem;
  padding: 1.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: box-shadow 0.3s ease-in-out;
}
.card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
</style>
