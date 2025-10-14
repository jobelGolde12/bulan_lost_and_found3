<script setup>
import AdminSettingsLayout from "@/Layouts/settings/AdminSettingsLayout.vue";
import { Head, usePage, Link } from "@inertiajs/vue3";
import { defineProps, ref, watch } from "vue";
import MyPermission from "@/Components/MyPermission.vue";

const user = usePage().props.auth.user;
const props = defineProps({
  userInfo: {
    type: Object,
    default: () => ({}),
  },
  permission: {
    type: Object,
    default: () => ({}),
  },
});

let getUserInfo = ref([]);
watch(
  () => props.userInfo,
  (newItem) => {
    getUserInfo.value = newItem;
  },
  { immediate: true }
);
</script>

<template>
  <Head title="My Profile" />
  <AdminSettingsLayout>
    <div class="main-container1">
      <!-- Profile Header -->
      <div
        class="container-fluid d-flex flex-column justify-content-center align-items-center pt-5 gap-2"
      >
        <div class="profile-pic shadow-sm">
          <img
            :src="
              getUserInfo?.profile_pic
                ? `/storage/${getUserInfo.profile_pic}`
                : `../../../images/profile.jpeg`
            "
            alt="Profile pic"
          />
        </div>

        <div>
          <div class="name fs-2 text-center mb-0">{{ user.name }}</div>
          <div class="bio text-muted text-center">
            {{ getUserInfo.bio || "" }}
          </div>
        </div>
      </div>

      <!-- Contact Info -->
      <div class="container mt-3">
        <div class="name text-start text-dark fw-light">
          <span class="fw-semibold me-2"><i class="bi bi-envelope"></i></span>
          {{ user.email ?? "N/A" }}
        </div>

        <div class="name text-start text-dark fw-light">
          <span class="fw-semibold me-2"><i class="bi bi-telephone"></i></span>
          {{ getUserInfo?.contact ?? "No phone provided." }}
        </div>
      </div>

      <!-- Settings Actions -->
      <div class="container mt-4">
        <h5 class="fw-semibold mb-3">Profile Settings</h5>
        <div class="settings-links">
          <Link
            :href="route('profile.edit')"
            class="settings-btn edit text-dark"
          >
            <i class="bi bi-pencil-square"></i>
            <span>Edit Profile</span>
          </Link>

                  <Link
          :href="route('settings.notifications')"
          class=" text-dark settings-btn "
        >
          <i class="bi bi-bell "></i>
          <span>Notifications</span>
        </Link>


          <Link
            :href="route('viewLater.view')"
            class="settings-btn saved text-dark"
          >
            <i class="bi bi-bookmark"></i>
            <span>Saved Reports</span>
          </Link>

          <!-- Permissions -->
          <MyPermission :permission="props.permission" class="settings-btn"/>

           <Link
            :href="route('logout')"
            method="POST"
            class="settings-btn logout text-danger"
          >
            <i class="bi bi-box-arrow-right"></i>
            <span>Logout</span>
          </Link>
        </div>
      </div>

      <!-- Extra space at the bottom -->
      <div class="container space mt-5"></div>
    </div>
  </AdminSettingsLayout>
</template>

<style lang="css" scoped>
.main-container1 {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow-x: hidden;
  overflow-y: scroll;
  padding: 0 2rem;
}
.profile-pic {
  position: relative;
  width: 180px;
  height: 180px;
  border-radius: 50%;
  left: 0%;
  overflow: hidden;
}
.profile-pic img {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: inherit;
  transition: 0.5s;
  object-fit: cover;
}
.profile-pic img:hover {
  transform: scale(1.1);
  filter: brightness(0.8);
}
.space {
  min-height: 150px;
}

/* Modern Action Buttons */
.settings-links {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.settings-btn {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.9rem 1.2rem;
  border-radius: 12px;
  text-decoration: none;
  font-weight: 500;
  font-size: 1rem;
  transition: all 0.3s ease;
}

/* .settings-btn.edit {
  background: linear-gradient(135deg, #4e73df, #224abe);
}
.settings-btn.logout {
  background: linear-gradient(135deg, #e74a3b, #c0392b);
}
.settings-btn.saved {
  background: linear-gradient(135deg, #1cc88a, #0f9d58);
} */

.settings-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

.settings-btn i {
  font-size: 1.2rem;
}
</style>
