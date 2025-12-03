<script setup>
import { usePage } from '@inertiajs/vue3';
import { defineProps, ref, watch, defineModel } from 'vue';

const props = defineProps({
  announcement: {
    type: Object,
    required: true,
  },
});

const getAnnouncement = ref({});
let selectedAnnouncementId = defineModel('selected');
const isContentExpanded = ref(false);
const isTitleExpanded = ref(false);
const contentLimit = ref(160);
const titleWordLimit = ref(10);

const page = usePage();
const auth = page.props.auth;

watch(
  () => props.announcement,
  (ann) => {
    getAnnouncement.value = ann;
  },
  { immediate: true }
);

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

const toggleContent = () => {
  isContentExpanded.value = !isContentExpanded.value;
};

const toggleTitle = () => {
  isTitleExpanded.value = !isTitleExpanded.value;
};

const shouldTruncateContent = () => {
  return getAnnouncement.value.content && getAnnouncement.value.content.length > contentLimit.value;
};

const shouldTruncateTitle = () => {
  if (!getAnnouncement.value.title) return false;
  const words = getAnnouncement.value.title.split(/\s+/);
  return words.length > titleWordLimit.value;
};

const getTruncatedContent = () => {
  if (!getAnnouncement.value.content) return '';

  if (isContentExpanded.value || !shouldTruncateContent()) {
    return getAnnouncement.value.content;
  }

  const truncated = getAnnouncement.value.content.substring(0, contentLimit.value);
  const lastSpaceIndex = truncated.lastIndexOf(' ');

  if (lastSpaceIndex > 0) {
    return truncated.substring(0, lastSpaceIndex) + '...';
  }
  return truncated + '...';
};

const getTruncatedTitle = () => {
  if (!getAnnouncement.value.title) return '';

  const words = getAnnouncement.value.title.split(/\s+/);
  
  if (words.length > titleWordLimit.value && !isTitleExpanded.value) {
    return words.slice(0, titleWordLimit.value).join(' ') + '...';
  }
  
  return getAnnouncement.value.title;
};
</script>

<template>
  <div class="announcement-card">
    <div class="card-wrapper">

      <div class="card-header">
        <div class="title-container">
          <h2 class="title" :class="{ 'title-expanded': isTitleExpanded }">
            {{ getTruncatedTitle() }}
          </h2>
          
          <button
            v-if="shouldTruncateTitle()"
            @click="toggleTitle"
            class="title-toggle-btn"
            :aria-label="isTitleExpanded ? 'Show less title' : 'Show more title'"
          >
            {{ isTitleExpanded ? 'See less' : 'See more' }}
          </button>
        </div>

        <button
          class="delete-btn"
          @click="openDeleteModal(getAnnouncement.id)"
          data-bs-toggle="modal"
          data-bs-target="#exampleModal"
          aria-label="Delete announcement"
          v-if="auth.user.role === 'admin'"
        >
          <i class="bi bi-trash3"></i>
        </button>
      </div>

      <p class="date">{{ formatDate(getAnnouncement.created_at) }}</p>

      <div class="content-container">
        <p class="content">
          {{ getTruncatedContent() }}
        </p>

        <button
          v-if="shouldTruncateContent()"
          @click="toggleContent"
          class="see-more-btn"
        >
          {{ isContentExpanded ? 'Show less' : 'Show more' }}
        </button>
      </div>

      <div class="card-footer">
        <img
          class="profile-pic"
          :src="getAnnouncement.user_profile?.profile_pic ? `/storage/${getAnnouncement.user_profile.profile_pic}` : 'https://via.placeholder.com/40'"
          alt="Profile"
        />
        <span class="author">{{ getAnnouncement?.user?.name || 'User' }}</span>
      </div>

    </div>
  </div>
</template>

<style scoped>
.announcement-card {
  width: 100%;
  display: flex;
  justify-content: center;
  padding: 1rem;
}

.card-wrapper {
  background: #fff;
  border-radius: 0.85rem;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  padding: 1.5rem;
  width: 100%;
  max-width: 600px;
  height: 100%;
  max-height: 430px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

/* New media query for small screens */
@media (max-width: 768px) {
  .announcement-card {
    min-width: 70vw;
    box-sizing: border-box; 
    left: 0;
    transform: translateX(-20%);
  }
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 0.5rem;
}

.title-container {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 0.5rem;
  flex: 1;
  min-width: 0; /* Important for text truncation */
}

.title {
  font-size: clamp(1.2rem, 2.5vw, 1.6rem);
  font-weight: 650;
  margin: 0;
  color: #2d2d2d;
  /* Allow wrapping when expanded */
  white-space: normal;
  overflow: visible;
  word-break: break-word;
  line-height: 1.3;
  width: 100%;
}

/* When title is truncated (not expanded) */
.title:not(.title-expanded) {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.title-toggle-btn {
  background: transparent;
  border: none;
  color: #4a6ee0;
  font-weight: 600;
  cursor: pointer;
  padding: 0.25rem 0.5rem;
  font-size: 0.75rem;
  border-radius: 0.25rem;
  transition: all 0.2s ease-in-out;
  white-space: nowrap;
  margin-top: 0.25rem;
}

.title-toggle-btn:hover {
  color: #334ab6;
  background-color: rgba(74, 110, 224, 0.1);
}

.delete-btn {
  background: transparent;
  border: none;
  color: #666;
  font-size: 1.25rem;
  transition: 0.2s ease-in-out;
  flex-shrink: 0;
  margin-top: 0.25rem;
}

.delete-btn:hover {
  color: #d32f2f;
}

.date {
  font-size: 0.85rem;
  color: #999;
  margin-top: 0.25rem;
}

.content-container {
  margin: 1rem 0;
  overflow-y: auto;
  max-height: 210px;
  padding-right: 5px;
}

.content-container::-webkit-scrollbar {
  width: 6px;
}

.content-container::-webkit-scrollbar-thumb {
  background: #c5c5c5;
  border-radius: 10px;
}

.content {
  color: #444;
  font-size: 0.94rem;
  line-height: 1.5;
  white-space: pre-line;
  overflow-wrap: break-word;
  word-break: break-word;
}

.see-more-btn {
  background: transparent;
  border: none;
  color: #4a6ee0;
  font-weight: 600;
  cursor: pointer;
  padding: 0.25rem 0;
  font-size: 0.85rem;
  transition: 0.2s ease-in-out;
  margin-top: 0.5rem;
}

.see-more-btn:hover {
  color: #334ab6;
  text-decoration: underline;
}

.card-footer {
  display: flex;
  align-items: center;
  gap: 0.65rem;
  margin-top: auto;
}

.profile-pic {
  width: 38px;
  height: 38px;
  border-radius: 50%;
  object-fit: cover;
}

.author {
  font-size: 0.95rem;
  font-weight: 600;
  color: #222;
}

/* Responsive adjustments */
@media (max-width: 480px) {
  .card-header {
    flex-direction: column;
    align-items: stretch;
    gap: 0.75rem;
  }
  
  .title-container {
    width: 100%;
  }
  
  .delete-btn {
    align-self: flex-end;
    margin-top: 0;
  }
}
</style>