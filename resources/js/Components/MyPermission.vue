<script setup>
import { ref } from 'vue';
import { router } from '@inertiajs/vue3';
import { defineProps } from 'vue';

const props = defineProps({
    permission: {
        type: Object,
        default: () => ({})
    }
})
const expanded = ref(false);

const toggleExpand = () => {
  expanded.value = !expanded.value;
};

const togglePhonePermission = () => {
  router.put(route('myPermission.togglePhonePermission'), {}, {
    onSuccess: () => {
      alert('Phone view permission updated!');
      window.location.reload();
    }
  });
};

const toggleEmailPermission = () => {
  router.put(route('myPermission.toggleEmailPermission'), {}, {
    onSuccess: () => {
      alert('Email view permission updated!')
      window.location.reload();
    }
  });
};
</script>

<template>
  <div class=" mb-3 d-flex flex-column" style="cursor: pointer;" @click="toggleExpand">
    <div class="d-flex justify-content-start w-100">
      <i class="bi bi-shield-lock me-2"></i>
      <span class="">My permission</span>
    </div>
    <transition name="fade">
      <div v-if="expanded" class="mt-3">
        <button class="btn btn-outline-secondary mb-2 w-100" @click.stop="togglePhonePermission">
          <span v-if="props.permission == null || props.permission?.isPhoneAllow == true">Disallow phone view</span>
          <span v-else>Allow phone view</span>
        </button>
        <button class="btn btn-outline-secondary w-100" @click.stop="toggleEmailPermission">
          <span v-if="props.permission == null || props.permission?.isEmailAllow == true">Disallow email view</span>
          <span v-else>Allow email view</span>
        </button>
      </div>
    </transition>
  </div>
</template>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: all 0.3s ease;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
  max-height: 0;
}
</style>
