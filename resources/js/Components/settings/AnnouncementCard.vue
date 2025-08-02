<script setup>
import { defineProps, ref, watch } from 'vue';

const props = defineProps({
    announcement: {
        type: Object,
        required: true,
    },
})
const getAnnouncement = ref({});

watch(
    () => props.announcement,
    (ann) => {
        getAnnouncement.value = ann;
        console.log("Announcement data:", getAnnouncement.value);
    }, {
        immediate: true
    }
)
const formatDate = (date, locale = 'en-US', options = {}) => {
  const defaultOptions = { year: 'numeric', month: 'long', day: 'numeric' };
  const finalOptions = { ...defaultOptions, ...options };
  const dateObj = new Date(date);

  if (isNaN(dateObj)) {
    return 'Invalid date';
  }

  return new Intl.DateTimeFormat(locale, finalOptions).format(dateObj);
};

const openDeleteModal = (id) => {
  selectedAnnouncementId.value = id;
};
</script>
<template>
  <div class="announcement-card">
    <div class="card-wrapper">
      <div class="card-header">
        <h2 class="title">{{ getAnnouncement.title }}</h2>
        <button
          class="delete-btn"
          @click="openDeleteModal(getAnnouncement.id)"
          aria-label="Delete announcement"
        >
          <i class="bi bi-trash"></i>
        </button>
      </div>

      <p class="date">{{ formatDate(getAnnouncement.created_at) }}</p>
      <p class="content">{{ getAnnouncement.content }}</p>

      <div class="card-footer">
        <img
          class="profile-pic"
          :src="getAnnouncement?.userProfile?.profile_pic || `/storage/${getAnnouncement?.user_profile?.profile_pic}` || '../../../../images/profile.jpeg'"
          alt="Profile"
        />
        <span class="author">{{ getAnnouncement?.user.name || 'User' }}</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.announcement-card {
  display: flex;
  justify-content: center;
  padding: 1rem;
}

.card-wrapper {
  background: #fff;
  border-radius: 1rem;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  padding: 1.5rem;
  width: 100%;
  max-width: 600px;
  display: flex;
  flex-direction: column;
  transition: box-shadow 0.3s ease;
}

.card-wrapper:hover {
  box-shadow: 0 12px 28px rgba(0, 0, 0, 0.1);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.title {
  font-size: 1.5rem;
  font-weight: 600;
  margin: 0;
  color: #333;
}

.delete-btn {
  background: transparent;
  border: none;
  color: #888;
  font-size: 1.2rem;
  transition: color 0.2s ease;
}

.delete-btn:hover {
  color: #e63946;
}

.date {
  font-size: 0.875rem;
  color: #999;
  margin-top: 0.25rem;
}

.content {
  margin: 1rem 0;
  color: #444;
  line-height: 1.6;
}

.card-footer {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-top: auto;
}

.profile-pic {
  width: 40px;
  height: 40px;
  border-radius: 9999px;
  object-fit: cover;
  border: 2px solid #eee;
}

.author {
  font-weight: 500;
  color: #333;
}
</style>
