<script setup>
import { ref, watch } from 'vue'
import { useFilterChart } from '@/piniaStore/FilterChart'

const chartFilter = useFilterChart()

const selectedFilter = ref(chartFilter.filterType)

watch(selectedFilter, (newVal) => {
  chartFilter.setFilter(newVal)
})
</script>

<template>
  <div>
    <select
      name="filter"
      id="filter"
      class="form-control bg-light mt-2 fixed-width"
      v-model="selectedFilter"
    >
      <option disabled value="">Filter</option>
      <option value="month" class="bg-success text-light">Month</option>
      <option value="year">Year</option>
    </select>
  </div>
</template>

<style scoped>
.fixed-width {
  width: 10%;
  min-width: 100px; 
  max-width: 200px; 
}
</style>
