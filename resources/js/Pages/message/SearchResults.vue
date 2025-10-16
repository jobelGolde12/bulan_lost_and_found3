
<script setup>
import MessageLayout from '@/Layouts/MessageLayout.vue';
import {defineProps, ref, watch} from 'vue';
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
  <MessageLayout :getPinned="getPinned">
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">
        Search Results
      </h2>
    </template>
    <div class="py-12">
      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
          <div class="p-6 bg-white border-b border-gray-200">
            <h3 class="text-lg font-medium text-gray-900 mb-4">
              Search Results
            </h3>
            <div v-if="props.matchedUsers.length">
              <ul class="ps-0">
                <li v-for="user in props.matchedUsers" :key="user.id" class="mb-2">
                  <Link 
                  :href="route('message.viewChat', {id: user?.id})" 
                  class="text-dark d-flex flex-row align-items-center text-decoration-none list py-2 px-2 rounded">
                  <div>
                  <img
                      :src="user?.user_info?.profile_pic
                        ? `/storage/${user.user_info.profile_pic}`
                        : '/images/profile.jpeg'"
                      alt="Profile pic"
                      class="profile me-3"
                    />
                  </div>
                    {{ user.name }}
                  </Link>
                </li>
              </ul>
            </div>
            <div v-else>
              <p>No users found.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </MessageLayout>
</template>


<style scoped>
.profile{
  width: 40px;
  height: 40px;
  border-radius: 50%;
}
.list:hover{
  background-color: #e3e8ec;
}
</style>