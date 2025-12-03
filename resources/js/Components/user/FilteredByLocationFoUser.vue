<template>
  <div class="container-fluid mt-3 d-flex flex-row justify-content-between align-items-center">
    <div class="d-flex gap-2">
      <div class="auto-width-select-wrapper">
        <!-- Hidden span used for dynamic width calculation -->
        <span ref="textSizer" class="text-sizer">{{ displayText }}</span>

        <select
          name="filter"
          id="filter"
          class="form-control bg-light mt-2 auto-width-select"
          v-model="selectedFilter"
          @change="filter(selectedFilter)"
          :style="{ width: computedWidth + 'px' }"
        >
          <option disabled value="">
            {{ currentLocation || "Location" }}
          </option>
          <option 
            v-for="loca in props.locations" 
            :key="loca.id"
            :value="loca.id"
          >
            {{ loca.name }}
          </option>
        </select>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, computed, defineProps, onMounted, nextTick } from 'vue'
import { router } from '@inertiajs/vue3'

const props = defineProps({
  locations: {
    type: Array,
    default: () => []
  },
  currentLocation: {
    type: String
  }
})
const selectedFilter = ref('')
const textSizer = ref(null)
const computedWidth = ref(150)

const displayText = computed(() => {
  const selected = props.locations.find(l => l.id === selectedFilter.value)
  return selected?.name || props.currentLocation || 'Location'
})

const updateWidth = async () => {
  await nextTick()
  if (textSizer.value) {
    computedWidth.value = textSizer.value.offsetWidth + 40 // padding + arrow space
  }
}

watch(displayText, updateWidth)
onMounted(updateWidth)

const filter = (id) => {
  if (id) {
    router.get(route('filterByLocationFoUser', { id }))
  }
}
</script>

<style scoped>
.auto-width-select-wrapper {
  position: relative;
  display: inline-block;
}

.text-sizer {
  visibility: hidden;
  white-space: nowrap;
  position: absolute;
  top: 0;
  left: 0;
  font-size: 16px;
  font-family: inherit;
  font-weight: normal;
}

.auto-width-select {
  min-width: 100px;
  transition: width 0.2s ease;
}
</style>
