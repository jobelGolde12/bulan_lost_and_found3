
<script setup>
import {defineProps} from 'vue';

const props = defineProps({
  created_by: Object,
  getProfile: String,
  data: Object,
  title: String,
    description: String
});
const created_by = props.created_by || {};
const getProfile = props.getProfile || '';
const title = props.title || '';
const description = props.description || '';
</script>

<template>
  <div>
        <div class="container-fluid d-column flex-row align-items-center px-0">
           <div class="mb-2">
            <Link :href="route('view.userAsUser', {id: created_by.id})" class="text-decoration-none d-flex align-items-center gap-2">
            <img
              :src="getProfile == 'NA' ? '../../images/profile.jpeg' : `/storage/${getProfile}`"
              alt="User"
              class="profile-pic rounded-full"
            />

            <span class="text-sm font-medium text-gray-700">{{ created_by.name }}</span>
          </Link>
           </div>

        <div class="flex justify-between items-center mb-4 header">
          <div class="d-flex flex-column ">
            <h2 class="text-xl font-semibold mb-0 d-block">{{ title || "Unnamed Item" }}</h2>
            <p class="description">{{ description || 'No description'}}</p>
          </div>
 
        </div>

        </div>
  </div>
</template>

<style scoped>
.profile-pic{
  min-width: 35px;
  max-width: 40px;
  height: 40px;
}
</style>