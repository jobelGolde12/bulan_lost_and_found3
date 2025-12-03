<script setup>
import { defineProps, onMounted, ref, watch } from 'vue';
import { Link } from '@inertiajs/vue3';

const props = defineProps({
  id: {
    type: Number,
    default: 0,
  },
  name: {
    type: String,
    default: '',
  },
  profile: {
    type: String,
    default: ''
  }
});


let getName = ref(''); 
let profilePic = ref(''); 
let userId = ref(0);
watch(
    () => props.id,
    (newId) => {
      userId.value = newId;
    },
    { immediate: true }
)
watch(
    () => props.name,
    (data) => {
      getName.value = data;
    },
    { immediate: true }
)
watch(
    () => props.profile,
    (data) => {
      profilePic.value = data;
    },
    { immediate: true }
)
</script>

<template>
  <div>
    <Link
      :href="route('viewUserAsAdmin', { id: userId })"
      class="text-decoration-none d-flex align-items-center justify-content-start gap-2 w-50 mt-3"
    >
      <img
        :src="profilePic == null ? '../../../../images/profile.jpeg' : `/storage/${profilePic}`"
        alt="User"
        class="profile-pic rounded-full"
      />

      <span class="text-sm font-medium text-gray-700">{{ getName || 'username' }}</span>
    </Link>
  </div>
</template>

<style lang="css" scoped>
.profile-pic {
  width: 35px;
  height: 35px;
  object-fit: cover;
  border-radius: 50%; 
}
</style>
