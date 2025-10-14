<script setup>
import { ref, defineProps, watch } from 'vue';
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
});

// --- Refs ---
let lostData = ref([]);
let foundData = ref([]);
let resolvedData = ref([]);

// --- Helper: count cases by month ---
const getMonthlyCounts = (data) => {
  const monthlyCounts = Array(12).fill(0);
  data.forEach((item) => {
    if (item.reported_at) {
      const month = new Date(item.reported_at).getMonth();
      monthlyCounts[month] += 1;
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
          Count: ${params.value}
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
  const lostCounts = getMonthlyCounts(lostData.value);
  const foundCounts = getMonthlyCounts(foundData.value);
  const resolvedCounts = getMonthlyCounts(resolvedData.value);

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

// --- Watch Props (filter by status) ---
watch(
  () => props.data,
  (newData) => {
    if (!Array.isArray(newData)) return;

    // Group by status
    lostData.value = newData.filter((item) => item.status?.toLowerCase() === 'lost');
    foundData.value = newData.filter((item) => item.status?.toLowerCase() === 'found');
    resolvedData.value = newData.filter((item) =>
      item.status?.toLowerCase() === 'claimed' || item.status?.toLowerCase() === 'resolved'
    );

    updateChart();
  },
  { immediate: true, deep: true }
);

// --- Check if there’s any data ---
const hasAnyData = () => {
  const allCounts = [
    ...getMonthlyCounts(lostData.value),
    ...getMonthlyCounts(foundData.value),
    ...getMonthlyCounts(resolvedData.value)
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
    </div>

    <v-chart v-if="hasAnyData()" class="chart" :option="chartOptions" />
    <div v-else class="rounded text-center my-5 text-muted">
      <img src="../../../../images/noImage.jpg" alt="No Data" class="img-icon mb-2 mx-auto">
      <p class="text-muted text-center">No case data this month.</p>
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
@media screen and (max-width: 768px) {
  .resolve-header h5 {
    font-size: 1.2rem;
  }
  .resolve-header p {
    font-size: 0.7rem;
  }
}
</style>
