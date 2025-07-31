<script setup>
import { Link } from '@inertiajs/vue3';
import { ref } from 'vue';
import  { defineProps, onMounted } from 'vue';
const props = defineProps({
    pendingRequest: {
        type: [Array, Number],
        default: []
    }
})

const getPedingRequest = ref(null);
onMounted(() => {
    getPedingRequest.value = props.pendingRequest;
})
</script>
<template>
  <div class="h-auto">
    <Link :href="route('dashboard')" class="card text-center shadow-md rounded-4 border-0 text-decoration-none">
      <div class="card-body d-flex flex-column justify-content-center align-items-center bg-gradient bg-light position-relative">
        <h5 class="card-title fw-bold text-uppercase mb-2 text-dark">Pending Requests</h5>
        <p class="card-text text-muted mb-3">Reports that require admin approval or action.</p>
        <h1 class="display-3 fw-bold text-success">{{ getPedingRequest || "0" }}</h1>
      </div>
    </Link>
  </div>
</template>

<style lang="css" scoped>
.card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
}
.card-body {
  padding: 2rem;
  border-radius: 1rem;
  position: relative;
  background: linear-gradient(135deg, #f8f9fa, #e9ecef);
}
.card-title {
  font-size: 1.2rem;
  letter-spacing: 0.05rem;
}
.card-text {
  font-size: 0.95rem;
}
h1 {
  font-size: 3rem;
}



</style>
