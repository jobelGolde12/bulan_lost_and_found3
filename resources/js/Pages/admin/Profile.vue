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
  hasUnreadNotifications: {
    type: Boolean,
    default: false,
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
    <div class="admin-profile-container">
      <!-- Profile Header -->
      <div class="profile-header admin">
        <div class="profile-avatar-container">
          <div class="profile-avatar">
            <img
              :src="
                getUserInfo?.profile_pic
                  ? `/storage/${getUserInfo.profile_pic}`
                  : `../../../images/profile.jpeg`
              "
              alt="Admin profile picture"
            />
            <div v-if="!getUserInfo?.profile_pic" class="avatar-placeholder">
              {{ user.name.charAt(0).toUpperCase() }}
            </div>
          </div>
          <div class="admin-indicator d-none d-lg-block">
            <i class="bi bi-shield-check "></i>
          </div>
        </div>

        <div class="profile-info">
          <div class="profile-name-container">
            <h1 class="profile-name">{{ user.name }}</h1>
            <div class="badge-container">
              <span class="admin-badge">Administrator</span>
              <span class="status-badge active" >Active</span>
            </div>
          </div>
          <p class="profile-bio">{{ getUserInfo.bio || "No bio added yet." }}</p>
        </div>
      </div>

      <!-- Contact Information -->
      <div class="contact-section">
        <h2 class="section-title">Contact Information</h2>
        <div class="contact-list">
          <div class="contact-item">
            <div class="contact-icon admin">
              <i class="bi bi-envelope"></i>
            </div>
            <div class="contact-details">
              <span class="contact-label">Email Address</span>
              <span class="contact-value">{{ user.email ?? "N/A" }}</span>
            </div>
          </div>
          <div class="contact-item">
            <div class="contact-icon admin">
              <i class="bi bi-telephone"></i>
            </div>
            <div class="contact-details">
              <span class="contact-label">Phone Number</span>
              <span class="contact-value">{{ getUserInfo?.contact ?? "No phone provided" }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Settings Actions -->
      <div class="settings-section">
        <h2 class="section-title">Admin Settings</h2>
        <div class="settings-grid">
          <Link
            :href="route('profile.edit')"
            class="setting-card edit-profile"
          >
            <div class="setting-icon">
              <i class="bi bi-pencil-square"></i>
            </div>
            <div class="setting-content">
              <h3 class="setting-title">Edit Profile</h3>
              <p class="setting-description">Update your personal information</p>
            </div>
            <div class="setting-arrow">
              <i class="bi bi-chevron-right"></i>
            </div>
          </Link>

          <Link
            :href="route('settings.notifications')"
            class="setting-card notifications"
          >
              <span v-if="props.hasUnreadNotifications" class="bg-success has-unread-notifications"></span>
            <div class="setting-icon">
              <i class="bi bi-bell"></i>
            </div>
            <div class="setting-content">
              <h3 class="setting-title">Notifications</h3>
              <p class="setting-description">Manage your notification preferences</p>
            </div>
            <div class="setting-arrow">
              <i class="bi bi-chevron-right"></i>
            </div>
          </Link>

          <Link
            :href="route('viewLater.view')"
            class="setting-card saved-reports"
          >
            <div class="setting-icon">
              <i class="bi bi-bookmark"></i>
            </div>
            <div class="setting-content">
              <h3 class="setting-title">Saved Reports</h3>
              <p class="setting-description">Access your saved content</p>
            </div>
            <div class="setting-arrow">
              <i class="bi bi-chevron-right"></i>
            </div>
          </Link>

          <MyPermission :permission="props.permission" class="setting-card permissions" />

          
          <Link
            :href="route('logout')"
            method="POST"
            class="setting-card logout"
          >
            <div class="setting-icon">
              <i class="bi bi-box-arrow-right"></i>
            </div>
            <div class="setting-content d-flex flex-column justify-content-start align-items-start">
              <h3 class="setting-title">Logout</h3>
              <p class="setting-description">Sign out of your account</p>
            </div>
            <div class="setting-arrow">
              <i class="bi bi-chevron-right"></i>
            </div>
          </Link>
        </div>
      </div>
    </div>
  </AdminSettingsLayout>
</template>

<style scoped>
.admin-profile-container {
  max-width: 900px;
  margin: 0 auto;
  padding: 2rem 1.5rem;
  color: #333;
}

.has-unread-notifications {
  position: absolute; 
  top: 1em;
  right: 1.5rem; 
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

.notifications {
    position: relative;
}
/* Admin Profile Header */
.profile-header.admin {
  background: linear-gradient(135deg, #2d3748 0%, #4a5568 100%);
  border-radius: 20px;
  color: white;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
  padding: 2.5rem;
  margin-bottom: 3rem;
  position: relative;
  overflow: hidden;
}

.profile-header.admin::before {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
  border-radius: 50%;
}

.profile-avatar-container {
  position: relative;
  margin-bottom: 1.5rem;
}

.profile-avatar {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  overflow: hidden;
  border: 4px solid rgba(255, 255, 255, 0.3);
  background: rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
}

.profile-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.avatar-placeholder {
  font-size: 3rem;
  font-weight: 700;
  color: white;
}

.admin-indicator {
  position: absolute;
  bottom: 10px;
  right: 10px;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: linear-gradient(135deg, #48bb78, #38a169);
  border: 3px solid white;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 0.9rem;
}

.profile-info {
  max-width: 500px;
}

.profile-name-container {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 1rem;
}

.profile-name {
  font-size: 2.2rem;
  font-weight: 700;
  margin: 0;
  letter-spacing: -0.5px;
}

.badge-container {
  display: flex;
  gap: 0.75rem;
  flex-wrap: wrap;
}

.admin-badge {
  background: linear-gradient(135deg, #48bb78, #38a169);
  padding: 0.5rem 1.25rem;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
  box-shadow: 0 4px 12px rgba(72, 187, 120, 0.3);
}

.status-badge {
  padding: 0.5rem 1.25rem;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
}

.status-badge.active {
  background: rgba(66, 153, 225, 0.3);
  color: #bee3f8;
}

.profile-bio {
  font-size: 1.1rem;
  line-height: 1.6;
  opacity: 0.9;
  margin: 0;
}

/* Section Styles */
.section-title {
  font-size: 1.5rem;
  font-weight: 700;
  margin-bottom: 1.5rem;
  color: #2d3748;
  position: relative;
  padding-bottom: 0.5rem;
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 50px;
  height: 3px;
  background: linear-gradient(90deg, #2d3748, #4a5568);
  border-radius: 3px;
}

/* Contact Section */
.contact-section {
  margin-bottom: 3rem;
  padding: 2rem;
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
  border: 1px solid #e2e8f0;
}

.contact-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.25rem;
  border-radius: 12px;
  transition: all 0.3s ease;
  background: #f8fafc;
  border: 1px solid #edf2f7;
}

.contact-item:hover {
  background: #edf2f7;
  transform: translateY(-2px);
  border-color: #cbd5e0;
}

.contact-icon.admin {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 50px;
  height: 50px;
  border-radius: 12px;
  background: linear-gradient(135deg, #2d3748, #4a5568);
  color: white;
  font-size: 1.2rem;
}

.contact-details {
  display: flex;
  flex-direction: column;
}

.contact-label {
  font-size: 0.85rem;
  color: #718096;
  margin-bottom: 0.25rem;
  font-weight: 500;
}

.contact-value {
  font-size: 1rem;
  font-weight: 600;
  color: #2d3748;
}

/* Settings Section */
.settings-section {
  margin-bottom: 2rem;
}

.settings-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
}

.setting-card {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1.5rem;
  background: white;
  border-radius: 16px;
  text-decoration: none;
  color: inherit;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: 1px solid #e2e8f0;
}

.setting-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  border-color: #cbd5e0;
}

.setting-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 56px;
  height: 56px;
  border-radius: 14px;
  font-size: 1.4rem;
  flex-shrink: 0;
}

.edit-profile .setting-icon {
  background: linear-gradient(135deg, #48bb78, #38a169);
  color: white;
}

.notifications .setting-icon {
  background: linear-gradient(135deg, #ed8936, #dd6b20);
  color: white;
}

.saved-reports .setting-icon {
  background: linear-gradient(135deg, #4299e1, #3182ce);
  color: white;
}

.permissions .setting-icon {
  background: linear-gradient(135deg, #9f7aea, #805ad5);
  color: white;
}

.admin-action .setting-icon {
  background: linear-gradient(135deg, #2d3748, #4a5568);
  color: white;
}

.logout .setting-icon {
  background: linear-gradient(135deg, #f56565, #e53e3e);
  color: white;
}

.setting-content {
  flex: 1;
}

.setting-title {
  font-size: 1.1rem;
  font-weight: 600;
  margin: 0 0 0.25rem 0;
  color: #2d3748;
}

.setting-description {
  font-size: 0.9rem;
  color: #718096;
  margin: 0;
}

.setting-arrow {
  color: #a0aec0;
  font-size: 1.2rem;
}

/* Admin Specific Sections */
.admin-actions-section {
  grid-column: 1 / -1;
  margin-top: 1rem;
}

.admin-section-title {
  font-size: 1.3rem;
  font-weight: 600;
  margin-bottom: 1rem;
  color: #2d3748;
  padding-left: 0.5rem;
  border-left: 4px solid #2d3748;
}

.admin-actions-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
}
/* Mobile-specific adjustments */
@media (max-width: 576px) {
  .modern-menu-toggle {
    padding: 10px 14px;
    gap: 4px;
  }
  
  .hamburger {
    width: 20px;
    gap: 3px;
  }
  
  .hamburger-line {
    height: 2px;
  }
  
  .menu-text {
    font-size: 0.7rem;
  }
}

/* Animation for when menu opens */
@keyframes menuPulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
  100% {
    transform: scale(1);
  }
}

.modern-menu-toggle[aria-expanded="true"] {
  animation: menuPulse 0.3s ease;
}
/* Responsive Design */
@media (min-width: 768px) {
  .profile-header.admin {
    display: flex;
    align-items: center;
    text-align: left;
    padding: 3rem;
  }
  
  .profile-avatar-container {
    margin-bottom: 0;
    margin-right: 2rem;
  }
  
  .profile-info {
    max-width: none;
  }
  
  .profile-name-container {
    flex-direction: row;
    align-items: center;
    justify-content: flex-start;
  }
  
  .settings-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .admin-actions-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .admin-profile-container {
    padding: 1rem;
  }
  
  .profile-header.admin {
    padding: 1.5rem;
  }
  
  .profile-avatar {
    width: 120px;
    height: 120px;
  }
  
  .profile-name {
    font-size: 1.8rem;
  }
  
  .contact-section,
  .setting-card {
    padding: 1.25rem;
  }
  
  .badge-container {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>