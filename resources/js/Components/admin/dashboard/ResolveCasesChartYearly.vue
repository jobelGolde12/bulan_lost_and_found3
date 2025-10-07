<script setup>
import { ref, defineProps, watch } from 'vue';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart } from 'echarts/charts';
import { GridComponent, TooltipComponent, LegendComponent } from 'echarts/components';
import VChart from 'vue-echarts';
import FilterResolveCases from './FilterResolveCases.vue';

// Register necessary ECharts modules
use([CanvasRenderer, BarChart, GridComponent, TooltipComponent, LegendComponent]);

const props = defineProps({
  resolve: {
    type: Array,
    default: () => []
  }
})

let getResolve = ref([]);


watch(
  () => props.resolve,
  (i) => {
    getResolve.value = i;
  },
  { immediate: true }
)


const getYearlyResolvedCases = (data) => {
  const yearlyCounts = {}; 


  if (Array.isArray(data) && data.length > 0) {
    data.forEach((caseData) => {
      const reportedYear = new Date(caseData.reported_at).getFullYear();
      yearlyCounts[reportedYear] = (yearlyCounts[reportedYear] || 0) + 1; 
    });
  }

  return yearlyCounts;
}


const yearlyResolvedCases = getYearlyResolvedCases(getResolve.value);


const years = Object.keys(yearlyResolvedCases).sort();
const resolvedCasesByYear = years.map((year) => yearlyResolvedCases[year]);


const hasResolvedCases = resolvedCasesByYear.length > 0;


const chartOptions = ref({
  tooltip: {
    trigger: 'axis',
    axisPointer: {
      type: 'shadow'
    }
  },
  xAxis: {
    type: 'category',
    data: years, 
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      name: 'Resolved Cases',
      type: 'bar',
      data: resolvedCasesByYear,
      itemStyle: {
        color: {
          type: 'linear',
          x: 0,
          y: 0,
          x2: 0,
          y2: 1,
          colorStops: [
            { offset: 0, color: '#4C9AFF' }, 
            { offset: 1, color: '#007BFF' }  
          ]
        },
        barBorderRadius: [5, 5, 0, 0]
      },
      barWidth: '50%'
    }
  ]
});
</script>

<template>
  <div>
    <div class="container-fluid d-flex flex-row justify-content-between align-items-center">
      <div>
        <h5 class="text-dark fw-lighter mb-0">Resolved Cases</h5>
        <p class="text-muted">Yearly statistics of resolved lost and found cases.</p>
      </div>
    </div>
    <v-chart v-if="hasResolvedCases" class="chart" :option="chartOptions" />
    <div v-else class="rounded text-center my-5 text-muted">
      <img src="../../../../images/no-data.svg" alt="No Resolve Cases svg" class="img-icon mx-auto mb-1">
      <p class="text-muted text-center">No resolved cases yearly.</p>
    </div>
  </div>
</template>

<style scoped>
.chart {
  width: 100%;
  height: 400px;
}
.img-icon{
  width: 150px;
  height: 150px;
}
@media screen and (max-width: 768px){
  .resolve-header h5{
    font-size: 1.2rem;
  }
  .resolve-header p{
    font-size: .7rem;
  }
  .filter{
    transform: translateY(-50%);
  }
}
</style>
