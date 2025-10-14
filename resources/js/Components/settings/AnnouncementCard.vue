<script setup>
import { usePage } from '@inertiajs/vue3';
import { defineProps, ref, watch, defineModel } from 'vue';

const props = defineProps({
    announcement: {
        type: Object,
        required: true,
    },
})
const getAnnouncement = ref({});
let selectedAnnouncementId = defineModel('selected')

// Add reactive variables for content expansion
const isContentExpanded = ref(false);
const contentLimit = ref(150); // Character limit before truncation

const page = usePage();
const auth = page.props.auth;
watch(
    () => props.announcement,
    (ann) => {
        getAnnouncement.value = ann;
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

// Toggle content expansion
const toggleContent = () => {
  isContentExpanded.value = !isContentExpanded.value;
};

// Check if content exceeds limit
const shouldTruncate = () => {
  return getAnnouncement.value.content && getAnnouncement.value.content.length > contentLimit.value;
};

// Get truncated content
const getTruncatedContent = () => {
  if (!getAnnouncement.value.content) return '';
  
  if (isContentExpanded.value || !shouldTruncate()) {
    return getAnnouncement.value.content;
  }
  
  // Find the last space within the limit to avoid cutting words
  const truncated = getAnnouncement.value.content.substring(0, contentLimit.value);
  const lastSpaceIndex = truncated.lastIndexOf(' ');
  
  if (lastSpaceIndex > 0) {
    return truncated.substring(0, lastSpaceIndex) + '...';
  }
  
  return truncated + '...';
};
</script>

<template>
  <div class="announcement-card" style="height: 430px;">
    <div class="card-wrapper">
      <div class="card-header">
        <h2 class="title">{{ getAnnouncement.title }}</h2>
        <button
          class="delete-btn"
          @click="openDeleteModal(getAnnouncement.id)"
          data-bs-toggle="modal"
          data-bs-target="#exampleModal"
          aria-label="Delete announcement"
          v-if="auth.user.role === 'admin'"
        >
          <i class="bi bi-trash"></i>
        </button>
      </div>

      <p class="date">{{ formatDate(getAnnouncement.created_at) }}</p>
      
      <!-- Updated content section with truncation -->
      <div class="content-container">
        <p class="content" :class="{ 'expanded': isContentExpanded }">
          {{ getTruncatedContent() }}
        </p>
        
        <!-- See More/Less button -->
        <button 
          v-if="shouldTruncate()" 
          @click="toggleContent" 
          class="see-more-btn"
          :aria-expanded="isContentExpanded"
          :aria-label="isContentExpanded ? 'Show less content' : 'Show more content'"
        >
          {{ isContentExpanded ? 'See less' : 'See more' }}
        </button>
      </div>

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

.content-container {
  margin: 1rem 0;
}

.content {
  color: #444;
  line-height: 1.6;
  margin-bottom: 0.5rem;
  white-space: pre-line;
}

.see-more-btn {
  background: transparent;
  border: none;
  color: #007bff;
  cursor: pointer;
  font-size: 0.875rem;
  font-weight: 500;
  padding: 0.25rem 0;
  transition: color 0.2s ease;
  text-decoration: none;
}

.see-more-btn:hover {
  color: #0056b3;
  text-decoration: underline;
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