<script setup>
import { ref, onMounted, nextTick, watch } from "vue";
import { use } from "echarts/core";
import { PieChart } from "echarts/charts";
import { TooltipComponent, LegendComponent } from "echarts/components";
import { CanvasRenderer } from "echarts/renderers";
import VChart from "vue-echarts";

// Register echarts modules
use([PieChart, TooltipComponent, LegendComponent, CanvasRenderer]);

const props = defineProps({
  data: {
    type: Object,
    default: () => ({
      lostItems: 0,
      fountItems: 0,
      resolve: 0,
    }),
  },
});

const chartRef = ref(null);

const chartOptions = ref({
  tooltip: { trigger: "item" },
  legend: {
    bottom: 0,
    textStyle: { color: "#333" },
  },
  series: [
    {
      name: "Cases",
      type: "pie",
      radius: ["45%", "70%"],
      avoidLabelOverlap: false,
      label: { show: false },
      emphasis: {
        label: { show: true, fontSize: 18, fontWeight: "bold" },
      },
      labelLine: { show: false },
      data: [
        { value: props.data.lostItems, name: "Lost", itemStyle: { color: "#FF6B6B" } },
        { value: props.data.fountItems, name: "Found", itemStyle: { color: "#4CAF50" } },
        { value: props.data.resolve, name: "Resolved", itemStyle: { color: "#007BFF" } },
      ],
    },
  ],
});

function updateChart(lost, found, resolved) {
  const instance = chartRef.value?.getEchartsInstance?.();
  if (instance) {
    instance.setOption({
      series: [
        {
          data: [
            { value: lost, name: "Lost", itemStyle: { color: "#FF6B6B" } },
            { value: found, name: "Found", itemStyle: { color: "#4CAF50" } },
            { value: resolved, name: "Resolved", itemStyle: { color: "#007BFF" } },
          ],
        },
      ],
    });
  }
}

// Watch for prop changes and update chart
watch(
  () => props.data,
  (newData) => {
    const lost = Number(newData.lostItems) || 0;
    const found = Number(newData.fountItems) || 0;
    const resolved = Number(newData.resolve) || 0;
    updateChart(lost, found, resolved);
  },
  { deep: true, immediate: true }
);

onMounted(async () => {
  await nextTick();
  const container = chartRef.value?.$el;
  const waitUntilVisible = setInterval(() => {
    if (container?.clientWidth > 0 && container?.clientHeight > 0) {
      clearInterval(waitUntilVisible);
      const { lostItems, fountItems, resolve } = props.data;
      updateChart(lostItems, fountItems, resolve);
    }
  }, 100);
});
</script>

<template>
  <div class="overview my-5">
    <h5 class="fw-semibold fs-1">Overview</h5>
    <p class="text-muted small">
      Current Lost, Found, and Resolved (Claimed) Cases Reported on this System.
    </p>

    <v-chart
      ref="chartRef"
      :option="chartOptions"
      autoresize
      class="overview-chart"
    />
  </div>
</template>

<style scoped>
.overview {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.overview-chart {
  width: 100%;
  height: 320px;
  min-height: 300px;
}
</style>
