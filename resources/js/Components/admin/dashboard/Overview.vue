<script setup>
import { ref, onMounted, nextTick, watch } from "vue";
import { use } from "echarts/core";
import { PieChart } from "echarts/charts";
import { TooltipComponent, LegendComponent } from "echarts/components";
import { CanvasRenderer } from "echarts/renderers";
import VChart from "vue-echarts";

// Register needed parts
use([PieChart, TooltipComponent, LegendComponent, CanvasRenderer]);

const props = defineProps({
  data:{
    type: Object,
    default: () => ({}),
  }
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
        { value: props.data.lostItems, name: "Lost", itemStyle: { color: "#da7575" } },
        { value: props.data.fountItems, name: "Found", itemStyle: { color: "#4C9AFF" } },
      ],
    },
  ],
});

function updateChart(lost, found) {
  const instance = chartRef.value?.getEchartsInstance?.();
  if (instance) {
    instance.setOption({
      series: [{ data: [
        { value: lost, name: "Lost", itemStyle: { color: "#E9ECEF" } },
        { value: found, name: "Found", itemStyle: { color: "#4C9AFF" } },
      ]}],
    });
  }
}

watch(
  () => [props.lostCount, props.foundCount],
  ([lost, found]) => {
    updateChart(lost, found);
  },
  { immediate: true }
);

onMounted(async () => {
  // Wait until DOM is ready and visible
  await nextTick();
  const container = chartRef.value?.$el;
  const waitUntilVisible = setInterval(() => {
    if (container?.clientWidth > 0 && container?.clientHeight > 0) {
      clearInterval(waitUntilVisible);
      updateChart(props.lostCount, props.foundCount);
    }
  }, 100);
});
</script>

<template>
  <div class="overview my-5">
    <h5 class="fw-semibold fs-1">Overview</h5>
    <p class="text-muted small ">
      Current Lost and Found Cases Reported on this System.
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
  /* background: #da7575; */
}
</style>
