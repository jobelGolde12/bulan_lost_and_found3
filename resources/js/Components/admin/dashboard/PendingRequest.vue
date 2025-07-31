<template>
    <Link :href="route('viewPendingRequest')" class="text-decoration-none" title="View pending request">
      <div class="card p-3 mb-4 rounded d-flex flex-row align-items-center hover-shadow" style="cursor: pointer;">
        <div class="icon-container me-3 rounded-circle" style="width: 48px; height: 48px; background-color: #FFEEDB;">
          <i class="bi bi-hourglass-split fs-4 text-dark"></i>
        </div>
        <div class="d-none d-md-none d-lg-block">
          <div class="fw-bold fs-4 text-success">{{ getCount }}</div>
          <div class="text-muted text ">Pending request</div>
        </div>
        <!-- Kapag sa small screen  -->
         <div class="d-block d-md-   d-lg-none get-count-sm-screen bg-success d-flex flex-row justify-content-center align-items-center">
          {{ getCount }}
         </div>
      </div>
    </Link>
  </template>
  
  <script setup>
  import { Link } from '@inertiajs/vue3'
  import { defineProps, ref, watch } from 'vue';
  const props = defineProps({
    count: {
      type: Number,
      default: 0
    }
  })

  let getCount = ref();
  watch(
    () => props.count,
    (newItem) => {
      getCount.value = newItem
    },
    {immediate: true}
  )
  </script>
  
  <style scoped>
  .card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    box-shadow: 0 .125rem .25rem rgba(0, 0, 0, .075);
    margin-top: 2rem;
    z-index: 1;
  }
  .hover-shadow:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
  }
  .text{
    font-size: .9rem;
  }
  .icon-container{
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
  }
  .get-count-sm-screen{
    border-radius: 50%;
    z-index: 5;
    width: 30px;
    height: 30px;
    color: #fff;
    transform: translateY(-40%);
  }
  @media screen and (max-width: 768px){
  .card{
    padding: 0;
    border: 0;  
    background: transparent;
    box-shadow: none;
  }
  .hover-shadow:hover {
    transform: translateY(0);
    box-shadow: none;
  }
   .icon-container{
    transform: translateX(60%);
  }
}
  </style>
  