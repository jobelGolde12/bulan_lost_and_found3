<script setup>
import { onMounted, ref, onBeforeUnmount } from "vue";
import * as echarts from "echarts";

const props = defineProps({
  totalLostItems: {
    type: Number,
    required: true,
  },
  totalFoundItems: {
    type: Number,
    required: true,
  },
  totalClaimedItems: {
    type: Array,
    default: () => [],
  },
});

const chartRef = ref(null);
let chartInstance = null;

function initChart() {
  if (!chartRef.value) return;
  chartInstance = echarts.init(chartRef.value);

  const claimedCount = props.totalClaimedItems.length;

  const option = {
    tooltip: {
      trigger: "item",
    },
    legend: {
      orient: "vertical",
      left: "left",
    },
    series: [
      {
        name: "Reports",
        type: "pie",
        radius: "50%",
        // ✅ Move the circle lower using center (x, y)
        center: ["50%", "58%"], // default is ["50%", "50%"]
        data: [
          { value: props.totalLostItems, name: "Lost Cases" },
          { value: props.totalFoundItems, name: "Found Cases" },
          { value: claimedCount, name: "Claimed Cases" },
        ],
        color: ["#768fb8", "#4C9AFF", "#2ecc71"],
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: "rgba(0, 0, 0, 0.5)",
          },
        },
      },
    ],
  };

  chartInstance.setOption(option);
}

function resizeChart() {
  if (chartInstance) chartInstance.resize();
}

onMounted(() => {
  initChart();
  window.addEventListener("resize", resizeChart);
});

onBeforeUnmount(() => {
  window.removeEventListener("resize", resizeChart);
  if (chartInstance) {
    chartInstance.dispose();
    chartInstance = null;
  }
});
</script>

<template>
  <div class="chart-wrapper">
    <!-- Chart -->
    <div ref="chartRef" class="chart-box"></div>

    <!-- Summary -->
    <div class="summary">
      <div class="summary-title">Number of Cases Recorded in the System</div>

      <div class="summary-stats">
        <div>
          <h5 class="lost">Lost Cases</h5>
          <p class="text-center">{{ props.totalLostItems }}</p>
        </div>
        <div>
          <h5 class="found">Found Cases</h5>
          <p class="text-center">{{ props.totalFoundItems }}</p>
        </div>
        <div>
          <h5 class="claimed">Claimed Cases</h5>
          <p class="text-center">{{ props.totalClaimedItems.length }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.chart-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
  width: 100%;
  margin-right: 3rem;
}

.chart-box {
  width: 250px;
  height: 250px;
  max-width: 100%;
  margin-left: 1.5rem; /* Slight move to the right */
}

.summary {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  text-align: center;
  width: 100%;
}
.summary-title {
  font-size: 0.95rem;
  color: #6b7280;
}
.summary-stats {
  display: flex;
  gap: 2rem;
  justify-content: center;
}
.summary .lost {
  color: #768fb8;
}
.summary .found {
  color: #4C9AFF;
}
.summary .claimed {
  color: #2ecc71;
}

@media (max-width: 893px) {
  .chart-wrapper {
    flex-direction: row;
    align-items: center;
    justify-content: flex-start;
  }

  .summary {
    order: 1;
    flex: 1 1 auto;
    text-align: left;
    align-items: flex-start;
    padding-right: 1rem;
  }

  .chart-box {
    order: 2;
    flex: 0 0 auto;
    margin-left: 2rem;
    width: 200px;
    height: 200px;
  }

  .summary-stats {
    justify-content: flex-start;
    gap: 1.25rem;
  }

  .summary .lost,
  .summary .found,
  .summary .claimed {
    font-size: 0.9rem;
  }
}
@media screen and (max-width: 731px) {
  .summary .lost,
  .summary .found,
  .summary .claimed {
    font-size: 0.7rem;
  }
}
@media screen and (max-width: 619px) {
  .chart-wrapper {
    margin-bottom: 5rem;
  }
}
@media screen and (max-width: 500px) {
  .summary-title {
    font-size: 0.8rem;
  }
}
</style>
