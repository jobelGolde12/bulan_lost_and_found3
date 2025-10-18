<script setup>
import UserSettingsLayout from "@/Layouts/UserSettingsLayout.vue";
import { Head, usePage, Link } from "@inertiajs/vue3";
import { defineProps, onMounted, ref } from "vue";
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

const getUserInfo = ref({});

onMounted(() => {
  getUserInfo.value = props.userInfo;
});
</script>

<template>
  <Head title="My Profile" />
  <UserSettingsLayout>
    <div class="profile-container">
      <!-- Profile Header -->
      <div class="profile-header">
        <div class="profile-avatar-container">
          <div class="profile-avatar">
            <img
              v-if="getUserInfo?.profile_pic"
              :src="`/storage/${getUserInfo.profile_pic}` || '../../../../images/profile.jpeg'"
              alt="Profile picture"
            />
            <div v-else class="avatar-placeholder">
              {{ user.name.charAt(0).toUpperCase() }}
            </div>
          </div>
          <div class="online-indicator"></div>
        </div>

        <div class="profile-info">
          <div class="profile-name-container">
            <h1 class="profile-name">{{ user.name }}</h1>
            <span class="user-badge">User</span>
          </div>
          <p class="profile-bio">{{ getUserInfo?.bio || 'No bio added yet.' }}</p>
        </div>
      </div>

      <!-- Contact Information -->
      <div class="contact-section">
        <h2 class="section-title">Contact Information</h2>
        <div class="contact-list">
          <div class="contact-item">
            <div class="contact-icon">
              <i class="bi bi-envelope"></i>
            </div>
            <div class="contact-details">
              <span class="contact-label">Email</span>
              <span class="contact-value">{{ user.email ?? 'N/A' }}</span>
            </div>
          </div>
          <div class="contact-item">
            <div class="contact-icon">
              <i class="bi bi-telephone"></i>
            </div>
            <div class="contact-details">
              <span class="contact-label">Phone</span>
              <span class="contact-value">{{ getUserInfo?.contact || 'No phone provided' }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Settings Actions -->
      <div class="settings-section">
        <h2 class="section-title">Profile Settings</h2>
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
            <div class="setting-icon">
              <i class="bi bi-bell"></i>
            </div>
            <div class="setting-content">
              <span v-if="props.hasUnreadNotifications" class="bg-success has-unread-notifications"></span>
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
            <div class="setting-content">
              <h3 class="setting-title">Logout</h3>
              <p class="setting-description">Sign out of your account</p>
            </div>
            <div class="setting-arrow">
              <i class="bi bi-chevron-right"></i>
            </div>
          </Link>

          <Link
            :href="route('deleteAccount')"
            class="setting-card delete-account"
          >
            <div class="setting-icon">
              <i class="bi bi-trash"></i>
            </div>
            <div class="setting-content">
              <h3 class="setting-title">Delete Account</h3>
              <p class="setting-description">Permanently delete your account</p>
            </div>
            <div class="setting-arrow">
              <i class="bi bi-chevron-right"></i>
            </div>
          </Link>
        </div>
      </div>
    </div>
  </UserSettingsLayout>
</template>

<style scoped>
.profile-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem 1.5rem;
  color: #333;
}

/* Profile Header */
.profile-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  margin-bottom: 3rem;
  padding: 2rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 20px;
  color: white;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.profile-avatar-container {
  position: relative;
  margin-bottom: 1.5rem;
}

.profile-avatar {
  width: 140px;
  height: 140px;
  border-radius: 50%;
  overflow: hidden;
  border: 4px solid rgba(255, 255, 255, 0.3);
  background: rgba(255, 255, 255, 0.2);
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
  font-size: 3.5rem;
  font-weight: 700;
  color: white;
}

.online-indicator {
  position: absolute;
  bottom: 10px;
  right: 10px;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: #4ade80;
  border: 3px solid white;
}

.profile-info {
  max-width: 500px;
}

.profile-name-container {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  margin-bottom: 1rem;
  flex-wrap: wrap;
}

.profile-name {
  font-size: 2.2rem;
  font-weight: 700;
  margin: 0;
  letter-spacing: -0.5px;
}

.user-badge {
  background: rgba(255, 255, 255, 0.2);
  padding: 0.4rem 1rem;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
  backdrop-filter: blur(10px);
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
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 3px;
}

/* Contact Section */
.contact-section {
  margin-bottom: 3rem;
  padding: 2rem;
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
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
  padding: 1rem;
  border-radius: 12px;
  transition: all 0.3s ease;
  background: #f8fafc;
}

.contact-item:hover {
  background: #edf2f7;
  transform: translateY(-2px);
}

.contact-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  border-radius: 12px;
  background: linear-gradient(135deg, #667eea, #764ba2);
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
}

.contact-value {
  font-size: 1rem;
  font-weight: 500;
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

.logout .setting-icon {
  background: linear-gradient(135deg, #f56565, #e53e3e);
  color: white;
}

.delete-account .setting-icon {
  background: linear-gradient(135deg, #a0aec0, #718096);
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

.notifications {
    position: relative;
}
/* Responsive Design */
@media (min-width: 768px) {
  .profile-header {
    flex-direction: row;
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
    justify-content: flex-start;
  }
  
  .settings-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .profile-container {
    padding: 1rem;
  }
  
  .profile-header {
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
}
</style>