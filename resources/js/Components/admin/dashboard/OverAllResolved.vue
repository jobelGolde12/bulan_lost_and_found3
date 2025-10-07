<template>
  <div class="resolved-card">
    <div class="content-wrapper d-flex flex-row align-items-center justify-content-between">
      <!-- Left side text -->
      <div class="info">
        <h5 class="fw-semibold mb-2 fs-1 fw-bold">Overall Resolved Cases</h5>
        <p class="text-muted  mb-0 ">
          Number of resolved cases recorded in this system.
        </p>
      </div>

      <!-- Right side chart -->
      <div class="chart-container">
        <v-chart class="chart" :option="chartOptions" autoresize />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps, watch, onMounted } from 'vue';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { GaugeChart } from 'echarts/charts';
import { TitleComponent } from 'echarts/components';
import VChart from 'vue-echarts';

use([CanvasRenderer, GaugeChart, TitleComponent]);

const props = defineProps({
  overallResolved: {
    type: Number,
    default: 0
  }
});

const chartOptions = ref({
  series: [
    {
      type: 'gauge',
      startAngle: 210,
      endAngle: -30,
      min: 0,
      max: 100,
      radius: '100%',
      progress: {
        show: true,
        width: 16,
        itemStyle: { color: '#007BFF' }
      },
      axisLine: {
        lineStyle: { width: 16, color: [[1, '#E9ECEF']] }
      },
      pointer: {
        show: true,
        length: '70%',
        width: 6
      },
      splitLine: { show: false },
      axisTick: { show: false },
      axisLabel: { show: false },
      detail: {
        valueAnimation: true,
        fontSize: 28,
        color: '#007BFF',
        offsetCenter: [0, '60%'],
        formatter: '{value}'
      },
      data: [{ value: props.overallResolved }]
    }
  ]
});

watch(
  () => props.overallResolved,
  (val) => {
    chartOptions.value.series[0].data[0].value = val;
  },
  { immediate: true }
);

onMounted(() => {
  setTimeout(() => {
    chartOptions.value = { ...chartOptions.value };
  }, 150);
});
</script>

<style scoped>
.resolved-card {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 30px;
}

.content-wrapper {
  width: 100%;
  border-radius: 16px;
  padding: 10px 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-top: 2px solid rgba(76, 154, 255, 0.2);
  border-bottom: 2px solid rgba(76, 154, 255, 0.2);
  padding-top: 2rem;
  padding-bottom: 2rem;
}

.info {
  flex: 1;
  padding-right: 20px;
}

.chart-container {
  width: 250px;
  height: 200px;
}

.chart {
  width: 100%;
  height: 100%;
}
</style>
