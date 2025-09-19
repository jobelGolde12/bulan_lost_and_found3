<script setup>
import { Link } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import { defineProps } from 'vue';

const props = defineProps({
  getUserCountValue: {
    type: Number,
    default: 0
  }
});

let getValue = ref();
watch(
  () => props.getUserCountValue,
  (newItem) => {
    getValue.value = newItem;
  },
  { immediate: true }
);
</script>

<template>
  <div class=" bg-transparent" 
  style="width: 400px; height: 100%;"
  >
    <Link
      :href="route('view.users')"
      class="card modern-card text-center rounded-4 text-decoration-none"
    >
      <div
        class="card-body d-flex flex-column justify-content-center align-items-center position-relative"
      >
        <div class="icon-wrapper mb-3">
          <i class="bi bi-people-fill icon"></i>
        </div>
        <h1 class="display-3 fw-bold text-primary">{{ getValue || "0" }}</h1>
        <h5 class="card-title fw-bold text-uppercase mb-2">
          <span v-if="getValue > 1">User's</span>
          <span v-else> User</span>
        </h5>
        <p class="card-text">Number of registered users.</p>
      </div>
    </Link>
  </div>
</template>

<style lang="css" scoped>
.modern-card {
  background: #ffffff;
  border: none;
  border-radius: 1.5rem;
  padding: 1.5rem;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}
.modern-card:hover {
  transform: translateY(-8px) scale(1.02);
  box-shadow: 0 12px 28px rgba(0, 0, 0, 0.15);
}
.card-body {
  padding: 2rem;
  border-radius: 1.5rem;
}
.icon-wrapper {
  background: linear-gradient(135deg, #007bff, #00c6ff);
  border-radius: 50%;
  padding: 1rem 1.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.4s ease;
}
.modern-card:hover .icon-wrapper {
  transform: rotate(15deg) scale(1.1);
}
.icon {
  color: #fff;
  font-size: 2rem;
}
.card-title {
  font-size: 1.2rem;
  letter-spacing: 0.06rem;
  color: #333;
}
.card-text {
  font-size: 0.95rem;
  color: #666;
}
h1 {
  font-size: 3.5rem;
}

@media screen and (max-width: 768px) {
  .modern-card {
    margin-top: 2rem;
    margin-bottom: 2rem;
  }
}
</style>
