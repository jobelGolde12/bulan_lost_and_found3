<script setup>
import { ref, defineProps, watch } from 'vue';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { LineChart } from 'echarts/charts';
import { GridComponent, TooltipComponent, LegendComponent } from 'echarts/components';
import VChart from 'vue-echarts';
import FilterResolveCases from './FilterResolveCases.vue';

use([CanvasRenderer, LineChart, GridComponent, TooltipComponent, LegendComponent]);

const props = defineProps({
  resolve: {
    type: Array,
    default: () => []
  }
});

let getResolve = ref([]);

watch(
  () => props.resolve,
  (i) => {
    getResolve.value = i;
  },
  { immediate: true }
);

const getMonthlyResolvedCases = (data) => {
  const monthlyCounts = Array(12).fill(0);

  data.forEach((caseData) => {
    const reportedMonth = new Date(caseData.reported_at).getMonth();
    monthlyCounts[reportedMonth] += 1;
  });

  return monthlyCounts;
};

const resolvedCasesByMonth = getMonthlyResolvedCases(getResolve.value);

const hasResolvedCases = resolvedCasesByMonth.some(count => count > 0);

const chartOptions = ref({
  tooltip: {
    trigger: 'axis',
    axisPointer: {
      type: 'line'
    }
  },
  xAxis: {
    type: 'category',
    data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      name: 'Resolved Cases',
      type: 'line',
      data: resolvedCasesByMonth,
      smooth: true,
      lineStyle: {
        color: '#007BFF',
        width: 3
      },
      itemStyle: {
        color: '#4C9AFF'
      },
      areaStyle: {
        color: 'rgba(76, 154, 255, 0.2)'
      }
    }
  ]
});
</script>

<template>
  <div>
    <div class="container-fluid d-flex flex-row justify-content-between align-items-center">
      <div class="resolve-header">
        <h5 class="text-dark fw-lighter mb-0">Resolved Cases</h5>
        <p class="text-muted">Monthly statistics of resolved lost and found cases.</p>
      </div>
    </div>
    <v-chart v-if="hasResolvedCases" class="chart" :option="chartOptions" />
    <div v-else class="rounded text-center my-5 text-muted">
      <img src="../../../../images/noImage.jpg" alt="No Resolve Cases svg" class="img-icon mb-2 mx-auto">
      <p class="text-muted text-center">No resolved cases this month.</p>
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
  .filter {
    transform: translateY(-50%);
  }
}
</style>
