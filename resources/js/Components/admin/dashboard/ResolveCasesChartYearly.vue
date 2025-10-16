<script setup>
import { ref, defineProps, watch } from 'vue';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart } from 'echarts/charts';
import { GridComponent, TooltipComponent, LegendComponent } from 'echarts/components';
import VChart from 'vue-echarts';

// Register necessary ECharts modules
use([CanvasRenderer, BarChart, GridComponent, TooltipComponent, LegendComponent]);

// --- Props ---
const props = defineProps({
  data: {
    type: Array,
    default: () => [],
  },
  lost: { type: Array, default: () => [] },
  found: { type: Array, default: () => [] },
});

// --- Refs ---
const lostData = ref([]);
const foundData = ref([]);
const resolvedData = ref([]);
const chartOptions = ref({});
const hasData = ref(false);

// --- Helpers ---
const groupByYear = (data, dateField) => {
  const yearly = {};

  if (Array.isArray(data)) {
    data.forEach((item) => {
      if (item[dateField]) {
        const year = new Date(item[dateField]).getFullYear();
        const count = item.total || 1;

        if (!yearly[year]) {
          yearly[year] = 0;
        }
        yearly[year] += count;
      }
    });
  }

  return yearly;
};

const groupByYearAndStatus = (data) => {
  const yearly = {};

  if (Array.isArray(data)) {
    data.forEach((item) => {
      if (item.reported_at && item.status) {
        const year = new Date(item.reported_at).getFullYear();
        const status = item.status;

        if (!yearly[year]) {
          yearly[year] = { Lost: 0, Found: 0, Resolved: 0 };
        }

        if (status === 'Lost') yearly[year].Lost++;
        else if (status === 'Found') yearly[year].Found++;
        else if (status === 'Claimed' || status === 'Resolved') yearly[year].Resolved++;
      }
    });
  }

  return yearly;
};

// --- Watch Props for Changes ---
watch(
  () => [props.data, props.lost, props.found],
  () => {
    // Use props.lost with date_lost and props.found with date_found
    const lostYearly = groupByYear(props.lost, 'date_lost');
    const foundYearly = groupByYear(props.found, 'date_found');
    const resolvedYearly = groupByYearAndStatus(props.data);

    // Get all unique years from all data sources
    const allYears = [
      ...Object.keys(lostYearly),
      ...Object.keys(foundYearly),
      ...Object.keys(resolvedYearly)
    ];
    const uniqueYears = [...new Set(allYears)].sort();
    
    // Prepare data for chart
    const lostCounts = uniqueYears.map(year => lostYearly[year] || 0);
    const foundCounts = uniqueYears.map(year => foundYearly[year] || 0);
    const resolvedCounts = uniqueYears.map(year => resolvedYearly[year]?.Resolved || 0);

    hasData.value = uniqueYears.length > 0 && (lostCounts.some(count => count > 0) || 
                     foundCounts.some(count => count > 0) || 
                     resolvedCounts.some(count => count > 0));

    // Compute total per year for percentage display
    const yearlyTotals = uniqueYears.map((year, index) => 
      lostCounts[index] + foundCounts[index] + resolvedCounts[index]
    );

    // --- Chart Options ---
    chartOptions.value = {
      tooltip: {
        trigger: 'item',
        formatter: (params) => {
          const yearIndex = uniqueYears.indexOf(params.name);
          const total = yearlyTotals[yearIndex];
          const percentage = total
            ? ((params.value / total) * 100).toFixed(1)
            : 0;

          return `
            <div style="text-align:left;">
              <strong>${params.seriesName}</strong><br/>
              Year: ${params.name}<br/>
              Count: ${params.value}<br/>
              Percentage: ${percentage}% of total cases in ${params.name}
            </div>
          `;
        }
      },
      legend: { data: ['Lost Cases', 'Found Cases', 'Resolved Cases'] },
      xAxis: {
        type: 'category',
        data: uniqueYears,
        axisTick: { alignWithLabel: true },
        axisLabel: { color: '#555' }
      },
      yAxis: {
        type: 'value',
        axisLabel: { color: '#555' }
      },
      series: [
        {
          name: 'Lost Cases',
          type: 'bar',
          data: lostCounts,
          itemStyle: {
            color: '#FF4C4C',
            barBorderRadius: [4, 4, 0, 0]
          },
          barWidth: '20%'
        },
        {
          name: 'Found Cases',
          type: 'bar',
          data: foundCounts,
          itemStyle: {
            color: '#28A745',
            barBorderRadius: [4, 4, 0, 0]
          },
          barWidth: '20%'
        },
        {
          name: 'Resolved Cases',
          type: 'bar',
          data: resolvedCounts,
          itemStyle: {
            color: '#007BFF',
            barBorderRadius: [4, 4, 0, 0]
          },
          barWidth: '20%'
        }
      ]
    };
  },
  { immediate: true, deep: true }
);
</script>

<template>
  <div>
    <div class="container-fluid d-flex flex-row justify-content-between align-items-center">
      <div>
        <h5 class="text-dark fw-lighter mb-0">Yearly Case Statistics</h5>
        <!-- <p class="text-muted">
          Lost (red), Found (green), and Resolved (blue) cases per year.
        </p> -->
      </div>
    </div>

    <v-chart v-if="hasData" class="chart" :option="chartOptions" />

    <div v-else class="rounded text-center my-5 text-muted">
      <img
        src="../../../../images/no-data.svg"
        alt="No Resolve Cases svg"
        class="img-icon mx-auto mb-1"
      />
      <p class="text-muted text-center">No case data available yearly.</p>
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