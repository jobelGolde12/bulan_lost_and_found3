<script setup>
import { defineProps, ref, watch } from 'vue';
import { Link } from '@inertiajs/vue3';

const props = defineProps({
  matchedUsers: {
    type: Array,
    default: () => [],
  },
});
</script>

<template>
  <div class="">
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
</template>

<style scoped>
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
