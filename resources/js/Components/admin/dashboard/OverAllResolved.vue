<script setup>
import { defineProps } from 'vue';

const props = defineProps({
  overallResolved: {
    type: Number,
    default: 0
  }
});
</script>


<template>
  <div class="container-fluid text-center bg-primary text-light p-0 rounded mb-3 py-1">
    <h1>{{ props.overallResolved }}</h1>
    <h4>Overall Resolved Cases</h4>
  </div>
</template>




