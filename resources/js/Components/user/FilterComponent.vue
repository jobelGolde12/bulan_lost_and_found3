<template>
  <div class="container-fluid mt-3 d-flex flex-row justify-content-between align-items-center">
   <div class="d-flex gap-2">
     <div>
      <select
        name="filter"
        id="filter"
        class="form-control bg-light mt-2 fixed-width"
        v-model="selectedFilter"
        @change="emitFilter"
      >
        <option disabled value="">Status</option>
        <option value="all">All</option>
        <option value="Lost">Lost</option>
        <option value="Found">Found</option>
      </select>
    </div>

    <!-- Sort by date -->
    <!-- <div class="ms-2">
      <select
        name="dateSort"
        id="dateSort"
        class="form-control bg-light mt-2 date-select"
        v-model="dateValue"
        @change="sortDateFunc"
      >
        <option disabled value=""><span class="d-none d-lg-inline">Sort by </span>date</option>
        <option value="date_asc">Ascending</option>
        <option value="date_desc">Descending</option>
      </select>
    </div> -->
   </div>


    <div class="change-text d-none d-lg-block">
      <p class="text-dark">
        All <span v-if="selectedFilter !== 'all'">{{ selectedFilter }}</span> items
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps } from 'vue'
import FindMatchButton from '../admin/dashboard/FindMatchButton.vue'

const props = defineProps({
  role: {
    type: String,
    default: ''
  }
})
const selectedFilter = ref('')
const dateValue = ref('')

const emit = defineEmits(['filterSelected'])
const emitFilter = () => {
  emit('filterSelected', selectedFilter.value)
}



const sortDateFunc = () => {
}
</script>

<style scoped>
.fixed-width {
  width: 10%;
  min-width: 100px; 
  max-width: 200px; 
}
.change-text {
  width: 130px;
  right: 20%;
}
.date-select {
  min-width: 150px;
}
</style>
