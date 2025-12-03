<script setup>
import { computed, watch, ref } from "vue";
import { Link, router } from "@inertiajs/vue3";
import axios from "axios";

const props = defineProps({
  items: {
    type: Array,
    default: () => [],
  },
});

const itemContainer = ref([]);
const loadingIds = ref([]); // Track which items are being posted

// Watch for prop updates
watch(
  () => props.items,
  (newItems) => {
    itemContainer.value = newItems;
  },
  { immediate: true }
);

// Methods
const viewLaterFunc = async (id) => {
  if (loadingIds.value.includes(id)) return; // Prevent spam clicks
  loadingIds.value.push(id);

  const item = itemContainer.value.find((i) => i.id === id);
  const isBookmarked = item.view_later?.some((v) => v.item_id === id);

  try {
    // Use axios for faster interaction (no full Inertia reload)
    await axios.post(`viewLater/add-view-later/${id}`);

    // Optimistically update UI
    if (isBookmarked) {
      item.view_later = [];
    } else {
      item.view_later = [{ item_id: id }];
    }
  } catch (error) {
    console.error("Failed to update view later:", error);
  } finally {
    loadingIds.value = loadingIds.value.filter((i) => i !== id);
  }
};

// Format date
const formatDate = (dateString) => {
  if (!dateString) return "";
  const options = { year: "numeric", month: "long", day: "numeric" };
  return new Date(dateString).toLocaleDateString(undefined, options);
};

// Truncate description text
const truncateText = (text, maxLength = 20) => {
  if (!text) return "";
  return text.length > maxLength ? `${text.slice(0, maxLength)}...` : text;
};
</script>

<template>
  <div class="card-grid">
    <!-- Empty State -->
    <div v-if="itemContainer.length === 0" class="empty-state">
      <i class="bi bi-inbox empty-state__icon"></i>
      <p class="empty-state__text">No items found</p>
    </div>

    <!-- Card Grid -->
    <div v-else class="card-grid__container">
      <article
        v-for="data in itemContainer"
        :key="data.id"
        class="item-card"
      >
        <!-- Image Section -->
        <Link
          :href="route('viewItemInfo', { item: data.id })"
          class="item-card__image-link"
        >
          <div class="item-card__image-container">
            <img
              v-if="data.image_url"
              :src="data.image_url"
              :alt="`Image of ${data.title}`"
              class="item-card__image"
              loading="lazy"
            />
            <div class="item-card__image-overlay">
              <time class="item-card__date">
                {{ formatDate(data?.created_at) }}
              </time>
            </div>
          </div>
        </Link>

        <!-- Content Section -->
        <div class="item-card__content">
          <div class="item-card__details">
            <h3 class="item-card__title">
              {{ data.title || "Untitled" }}
            </h3>
            <p 
              class="item-card__description"
              :title="data.description"
            >
              {{ truncateText(data.description, 25) }}
            </p>
            <span class="item-card__category">
              {{ data.category || "Uncategorized" }}
            </span>
          </div>

          <!-- Footer -->
          <div class="item-card__footer">
            <Link
              :href="data?.user ? route('view.userAsUser', { id: data.user.id }) : '#'"
              class="user-info"
              :class="{ 'user-info--disabled': !data?.user }"
            >
              <div class="user-info__avatar">
                <img
                  :src="data.user?.user_info?.profile_pic 
                    ? `/storage/${data.user.user_info.profile_pic}` 
                    : '/images/profile.jpeg'"
                  :alt="`Profile of ${data.user?.name}`"
                  class="user-info__image"
                />
              </div>
              <span class="user-info__name">
                {{ data.user?.name || "Unknown User" }}
              </span>
            </Link>

            <!-- Actions -->
            <button
              class="item-card__action"
              :disabled="loadingIds.includes(data.id)"
              :class="{
                'item-card__action--active': data.view_later?.some(v => v.item_id === data.id)
              }"
              @click="viewLaterFunc(data.id)"
            >
              <!-- Loading spinner -->
              <i
                v-if="loadingIds.includes(data.id)"
                class="bi bi-arrow-repeat animate-spin text-gray-500"
              ></i>

              <!-- Bookmark icon -->
              <i
                v-else
                class="bi"
                :class="data.view_later?.some(v => v.item_id === data.id) 
                  ? 'bi-bookmark-fill' 
                  : 'bi-bookmark'"
              ></i>
            </button>
          </div>
        </div>
      </article>
    </div>

    <div class="bottom-spacer"></div>
  </div>
</template>


<style scoped>
.card-grid {
  width: 70vw !important;
  height: auto;
  padding: 1rem 0;
  padding-bottom: 10rem;
}

/* Grid Container */
.card-grid__container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.5rem;
  padding: 0 1rem;
  max-width: 1200px;
  margin: 0 auto;
}

/* Empty State */
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 4rem 2rem;
  text-align: center;
  color: #6c757d;
}

.empty-state__icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  opacity: 0.5;
}

.empty-state__text {
  font-size: 1.125rem;
  margin: 0;
  color: #6c757d;
}

/* Item Card */
.item-card {
  background: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  transition: all 0.3s ease;
  border: 1px solid #f0f0f0;
  box-shadow: 0 .125rem .25rem rgba(0, 0, 0, .075); /* same as Bootstrap shadow-sm */
}

/* Image Section */
.item-card__image-link {
  text-decoration: none;
  display: block;
}

.item-card__image-container {
  position: relative;
  width: 100%;
  height: 200px;
  overflow: hidden;
  background: #f8f9fa;
}

.item-card__image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.item-card__image-container:hover .item-card__image {
  transform: scale(1.05);
}

.item-card__image-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to bottom,
    transparent 0%,
    transparent 60%,
    rgba(0, 0, 0, 0.4) 100%
  );
  opacity: 0;
  transition: opacity 0.3s ease;
  display: flex;
  align-items: flex-end;
  justify-content: flex-end;
  padding: 0.75rem;
}

.item-card__image-container:hover .item-card__image-overlay {
  opacity: 1;
}

.item-card__date {
  color: #ffffff;
  font-size: 0.75rem;
  background: rgba(0, 0, 0, 0.7);
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  backdrop-filter: blur(4px);
}

/* Content Section */
.item-card__content {
  padding: 1.25rem;
}

.item-card__details {
  margin-bottom: 1.25rem;
}

.item-card__title {
  font-size: 1.125rem;
  font-weight: 700;
  color: #2d3748;
  margin: 0 0 0.5rem 0;
  line-height: 1.4;
}

.item-card__description {
  color: #718096;
  font-size: 0.875rem;
  margin: 0 0 0.75rem 0;
  line-height: 1.5;
}

.item-card__category {
  display: inline-block;
  color: #38a169;
  font-size: 0.75rem;
  font-weight: 600;
  padding: 0.25rem 0.75rem;
  background: #f0fff4;
  border-radius: 12px;
  border: 1px solid #c6f6d5;
}

/* Footer */
.item-card__footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
}

/* User Info */
.user-info {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  text-decoration: none;
  flex: 1;
  min-width: 0;
  transition: opacity 0.2s ease;
}

.user-info--disabled {
  opacity: 0.6;
  pointer-events: none;
}

.user-info__avatar {
  flex-shrink: 0;
}

.user-info__image {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #e2e8f0;
}

.user-info__name {
  font-size: 0.875rem;
  font-weight: 500;
  color: #4a5568;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.user-info:not(.user-info--disabled):hover .user-info__name {
  color: #2d3748;
}

/* Actions */
.item-card__action {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border: none;
  border-radius: 8px;
  background: #f7fafc;
  color: #a0aec0;
  cursor: pointer;
  transition: all 0.2s ease;
  flex-shrink: 0;
}

.item-card__action:hover {
  background: #edf2f7;
  color: #4a5568;
}

.item-card__action--active {
  color: #4299e1;
  background: #ebf8ff;
}

.item-card__action--active:hover {
  color: #3182ce;
  background: #e1f0ff;
}

/* Bottom Spacer */
.bottom-spacer {
  height: 2rem;
}

/* Spinner */
.animate-spin {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* Responsive Design */
@media (max-width: 992px) {
  .card-grid__container {
    grid-template-columns: 1fr;
    width: 90%;
  }
}

@media (max-width: 768px) {
  .card-grid__container {
    grid-template-columns: 1fr;
    gap: 1rem;
    padding: 0 0.75rem;
  }
  .item-card{
    min-width: 400px;
    transform: translateX(-6%);
  }
  .item-card__content {
    padding: 1rem;
  }
}

@media (max-width: 480px) {
  .card-grid {
    padding: 0.5rem 0;
  }

  .item-card__image-container {
    height: 180px;
  }

  .item-card__footer {
    gap: 0.75rem;
  }
}

</style>