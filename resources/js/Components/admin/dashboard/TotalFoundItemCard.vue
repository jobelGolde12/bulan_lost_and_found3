<script setup>
import { Link } from '@inertiajs/vue3';
import { ref } from 'vue';
import  { defineProps, onMounted } from 'vue';
const props = defineProps({
    foundItems: {
        type: [Array, Number],
        default: []
    }
})

const getLostItems = ref(null);
onMounted(() => {
    getLostItems.value = props.foundItems;
})
</script>

<template>
  <div class="main-container1">
    <div :href="route('dashboard')" class="card text-center shadow-md rounded-4 border-0 text-decoration-none">
      <div class="card-body d-flex flex-column justify-content-center align-items-center bg-gradient bg-light position-relative">
        <h5 class="card-title fw-bold text-uppercase mb-2 text-dark">Total Found Items</h5>
        <p class="card-text text-muted mb-3 d-none d-lg-block">Count of found items reported.</p>
        <h1 class="display-3 fw-bold text-success">{{ getLostItems || "0" }}</h1>
        <div class="position-absolute bottom-0 end-0 m-3">
          <i class="icon bi bi-check-circle text-secondary" style="font-size: 2rem"></i>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="css" scoped>
.main-container2{
  max-height: 5%;
}
.card {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
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
