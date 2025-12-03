<script setup>
import { defineProps, ref, watch } from 'vue';
import { Link } from '@inertiajs/vue3';

const props = defineProps({
  matchedUsers: {
    type: Array,
    default: () => [],
  },
  pinned: {
    type: Array,
    default: () => []
  },
});

let getPinned = ref([]);

watch(
  () => props.pinned,
  (data) => {
    getPinned.value = data;
  },
  { immediate: true }
);
</script>

<template>
  <div class="modal-overlay">
    <div class="modal-content">

      <!-- ✅ Back Link -->
      <Link :href="route('message.index')" class="back-link">
        ← Back
      </Link>

      <h2 class="modal-title">Search Results</h2>

      <div v-if="props.matchedUsers.length" class="results-wrapper">
        <ul class="ps-0">
          <li
            v-for="user in props.matchedUsers"
            :key="user.id"
            class="mb-3"
          >
            <Link
              :href="route('message.viewChat', { id: user?.id })"
              class="text-dark d-flex flex-row align-items-center text-decoration-none list py-2 px-2 rounded"
            >
              <img
              :src="user?.user_info?.profile_pic
                ? `/storage/${user.user_info.profile_pic}`
                : '/images/profile.jpeg'"
              class="profile me-3"
              alt="Profile pic"
            />
              {{ user.name }}
            </Link>
          </li>
        </ul>
      </div>

      <div v-else class="no-results">
        <p>No users found.</p>
      </div>

    </div>
  </div>
</template>

<style scoped>
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(255, 255, 255, 0.98);
  display: flex;
  justify-content: center;
  align-items: flex-start;
  overflow-y: auto;
  z-index: 9999;
}

.modal-content {
  width: 100%;
  max-width: 100%;
  padding: 2rem;
}

.back-link {
  display: inline-block;
  margin-bottom: 1rem;
  font-weight: 600;
  color: #2563eb;
  text-decoration: none;
}

.back-link:hover {
  text-decoration: underline;
}

.modal-title {
  font-size: 1.5rem;
  font-weight: bold;
  margin-bottom: 1rem;
}

.profile {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.list:hover {
  background-color: #e3e8ec;
}

.no-results {
  margin-top: 1rem;
}
</style>
