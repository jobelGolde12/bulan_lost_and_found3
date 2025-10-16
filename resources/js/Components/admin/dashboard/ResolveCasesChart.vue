<script setup>
import { ref, defineProps, watch, computed } from 'vue';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart } from 'echarts/charts';
import { GridComponent, TooltipComponent, LegendComponent } from 'echarts/components';
import VChart from 'vue-echarts';
import FilterResolveCases from './FilterResolveCases.vue';

use([CanvasRenderer, BarChart, GridComponent, TooltipComponent, LegendComponent]);

// --- Props ---
const props = defineProps({
  data: { type: Array, default: () => [] },
  lost: { type: Array, default: () => [] },
  found: { type: Array, default: () => [] },
});
// --- Refs ---
let lostData = ref([]);
let foundData = ref([]);
let resolvedData = ref([]);
const selectedYear = ref(new Date().getFullYear()); // Default to current year

// --- Computed: Generate years for dropdown (5 years from now) ---
const yearOptions = computed(() => {
  const currentYear = new Date().getFullYear();
  const years = [];
  for (let i = 0; i < 5; i++) {
    years.push(currentYear - i);
  }
  return years;
});

// --- Helper: count cases by month using date_lost and date_found for specific year ---
const getMonthlyCounts = (data, dateField) => {
  const monthlyCounts = Array(12).fill(0);
  data.forEach((item) => {
    if (item[dateField]) {
      const date = new Date(item[dateField]);
      const month = date.getMonth();
      const year = date.getFullYear();
      
      // Only count if it matches the selected year
      if (year === selectedYear.value) {
        monthlyCounts[month] += item.total || 1;
      }
    }
  });
  return monthlyCounts;
};

// --- Chart Config ---
const chartOptions = ref({
  tooltip: {
    trigger: 'item',
    formatter: (params) => {
      return `
        <div style="text-align:left;">
          <strong>${params.seriesName}</strong><br/>
          Month: ${params.name}<br/>
          Count: ${params.value}<br/>
          Year: ${selectedYear.value}
        </div>
      `;
    }
  },
  legend: { data: ['Lost Cases', 'Found Cases', 'Resolved Cases'] },
  xAxis: {
    type: 'category',
    data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    axisTick: { alignWithLabel: true }
  },
  yAxis: { type: 'value' },
  series: []
});

// --- Update Chart Function ---
const updateChart = () => {
  // Use props.lost with date_lost and props.found with date_found for selected year
  const lostCounts = getMonthlyCounts(props.lost, 'date_lost');
  const foundCounts = getMonthlyCounts(props.found, 'date_found');
  const resolvedCounts = getMonthlyCounts(resolvedData.value, 'reported_at');

  chartOptions.value.series = [
    {
      name: 'Lost Cases',
      type: 'bar',
      data: lostCounts,
      itemStyle: { color: '#FF4C4C' },
      emphasis: { focus: 'series' }
    },
    {
      name: 'Found Cases',
      type: 'bar',
      data: foundCounts,
      itemStyle: { color: '#28A745' },
      emphasis: { focus: 'series' }
    },
    {
      name: 'Resolved Cases',
      type: 'bar',
      data: resolvedCounts,
      itemStyle: { color: '#007BFF' },
      emphasis: { focus: 'series' }
    }
  ];
};

// --- Handle Year Change ---
const handleYearChange = (year) => {
  selectedYear.value = year;
  updateChart();
};

// --- Watch Props (filter by status) ---
watch(
  () => props.data,
  (newData) => {
    if (!Array.isArray(newData)) return;

    // Group by status for resolved cases only
    lostData.value = newData.filter((item) => item.status?.toLowerCase() === 'lost');
    foundData.value = newData.filter((item) => item.status?.toLowerCase() === 'found');
    resolvedData.value = newData.filter((item) =>
      item.status?.toLowerCase() === 'claimed' || item.status?.toLowerCase() === 'resolved'
    );

    updateChart();
  },
  { immediate: true, deep: true }
);

// Also watch lost and found props directly
watch(
  () => [props.lost, props.found],
  () => {
    updateChart();
  },
  { immediate: true, deep: true }
);

// Watch selected year changes
watch(
  () => selectedYear.value,
  () => {
    updateChart();
  }
);

// --- Check if there's any data ---
const hasAnyData = () => {
  const lostCounts = getMonthlyCounts(props.lost, 'date_lost');
  const foundCounts = getMonthlyCounts(props.found, 'date_found');
  const resolvedCounts = getMonthlyCounts(resolvedData.value, 'reported_at');
  
  const allCounts = [
    ...lostCounts,
    ...foundCounts,
    ...resolvedCounts
  ];
  return allCounts.some((count) => count > 0);
};
</script>

<template>
  <div>
    <div class="container-fluid d-flex flex-row justify-content-between align-items-center">
      <div class="resolve-header">
        <h5 class="text-dark fw-lighter mb-0">Monthly Case Statistics</h5>
        <!-- <p class="text-muted">Lost (red), Found (green), and Resolved (blue) cases per month.</p> -->
      </div>
      <div class="year-filter">
        <select 
          v-model="selectedYear" 
          @change="handleYearChange(selectedYear)"
          class="form-select form-select-sm"
          style="width: 120px;"
        >
          <option 
            v-for="year in yearOptions" 
            :key="year" 
            :value="year"
          >
            {{ year }}
          </option>
        </select>
      </div>
    </div>

    <v-chart v-if="hasAnyData()" class="chart" :option="chartOptions" />
    <div v-else class="rounded text-center my-5 text-muted">
      <img src="../../../../images/no-data.svg" alt="No Data" class="img-icon mb-2 mx-auto">
      <p class="text-muted text-center">No case data for {{ selectedYear }}.</p>
    </div>
  </div>
</template>

<style scoped>
.chart {
  width: 100%;
  height: 400px;
}
.img-icon {
  width: 150px;
  height: 150px;
}
.year-filter {
  margin-left: auto;
}
@media screen and (max-width: 768px) {
  .resolve-header h5 {
    font-size: 1.2rem;
  }
  .resolve-header p {
    font-size: 0.7rem;
  }
  .year-filter .form-select {
    width: 100px;
  }
}
</style>