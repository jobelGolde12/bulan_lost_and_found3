<template>
  <div class="overview-wrapper">
    <div class="card border-0 overview-card">
      <div class="card-body">
        <h5 class="card-title mb-4">Overview</h5>

        <!-- Chart Section -->
        <div class="chart-container">
          <ECharts
            :option="overviewChartOptions"
            autoresize
            class="echart"
          />
        </div>

        <!-- Bottom labels in a row -->
        <div class="d-flex flex-row justify-content-start flex-wrap gap-4 mt-3">
          <div class="d-flex align-items-center legend">
            <span class="rounded-circle me-2" style="background-color: #FFC043;"></span>
            Lost items
          </div>
          <div class="d-flex align-items-center legend">
            <span class="rounded-circle me-2" style="background-color: #6B8BFF;"></span>
            Found items
          </div>
          <div class="d-flex align-items-center legend">
            <span class="rounded-circle me-2" style="background-color: #7ED957;"></span>
            Resolved cases
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, defineProps, watch } from "vue";
import { use } from "echarts/core";
import { LineChart } from "echarts/charts";
import { TooltipComponent, GridComponent } from "echarts/components";
import { CanvasRenderer } from "echarts/renderers";
import ECharts from "vue-echarts";

use([CanvasRenderer, LineChart, TooltipComponent, GridComponent]);

const props = defineProps({
  data: {
    type: Object,
    default: () => ({}),
  },
});

const getData = ref({});
watch(
  () => props.data,
  (val) => {
    getData.value = val || {};
  },
  { immediate: true }
);

const countLostItems = computed(() => Number(getData.value.lostItems) || 0);
const countFoundItems = computed(() => Number(getData.value.fountItems) || 0);
const countResolvedCases = computed(() => Number(getData.value.resolve) || 0);

const overviewChartOptions = ref({});

watch(
  () => [countLostItems.value, countFoundItems.value, countResolvedCases.value],
  ([lost, found, resolved]) => {
    overviewChartOptions.value = {
      tooltip: { trigger: "axis" },
      grid: {
        left: "5%",
        right: "5%",
        bottom: "12%",
        top: "6%",
        containLabel: true,
      },
      xAxis: {
        type: "category",
        boundaryGap: false,
        data: ["Lost", "Found", "Resolved"],
        axisLine: { lineStyle: { color: "#333", width: 2 } },
        axisTick: { show: true },
        axisLabel: { color: "#333", fontSize: 12 },
      },
      yAxis: {
        type: "value",
        axisLine: { lineStyle: { color: "#333", width: 2 } },
        splitLine: { lineStyle: { color: "#eee" } },
        axisLabel: { color: "#333" },
      },
      series: [
        {
          name: "Cases",
          type: "line",
          smooth: true,
          data: [lost, found, resolved],
          symbol: "circle",
          symbolSize: 9,
          lineStyle: { width: 4 },
          areaStyle: { opacity: 0.15 },
          emphasis: { focus: "series" },
        },
      ],
    };
  },
  { immediate: true }
);
</script>

<style scoped>
.overview-wrapper {
  width: 100%;
  display: flex;
  justify-content: flex-start; /* align left */
}

.overview-card {
  width: 600px;        /* default width */
  max-width: 100%;     /* shrink on small screens */
  background: #fff;
  border-radius: 12px;
}

.chart-container {
  width: 100%;
  height: 350px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.echart {
  width: 100% !important;
  height: 100% !important;
}

.legend {
  font-size: 13px;
}
.legend span {
  display: inline-block;
  width: 12px;
  height: 12px;
}
</style>
