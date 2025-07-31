<script setup>
import { Link } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import  { defineProps, onMounted } from 'vue';
const props = defineProps({
    getUserCountValue: {
        type: Number,
        default: 0
    }
})
let getValue = ref();
watch(
  () => props.getUserCountValue,
  (newItem) => {
    getValue.value = newItem;
  },
  {immediate: true}
)
</script>

<template>
  <div class="h-auto bg-transparent">
    <Link :href="route('view.users')" class="card bg-transparent text-center rounded-4 border-0 text-decoration-none">
      <div class="card-body d-flex flex-column justify-content-center align-items-center position-relative">
        <h1 class="display-3 fw-bold text-success">{{ getValue || "0" }}</h1>
        <h5 class="card-title fw-bold text-uppercase mb-2 text-dark">User Registrations</h5>
        <p class="card-text text-muted mb-3">Number of registered users.</p>
      </div>
    </Link>
  </div>
</template>

<style lang="css" scoped>
.card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
/* .card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
} */
.card-body {
  padding: 2rem;
  border-radius: 1rem;
  position: relative;
}
.card-title {
  font-size: 1.2rem;
  letter-spacing: 0.05rem;
}
.card-text {
  font-size: 0.95rem;
}
h1 {
  font-size: 4rem;
}

@media screen and (max-width: 768px){
  .card{
    margin-top: 2rem;
    margin-bottom: 2rem;
  }
}

</style>
