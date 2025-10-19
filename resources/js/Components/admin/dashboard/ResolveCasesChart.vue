<script setup>
import { ref, defineProps, watch, computed } from 'vue';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart } from 'echarts/charts';
import { GridComponent, TooltipComponent, LegendComponent } from 'echarts/components';
import VChart from 'vue-echarts';

use([CanvasRenderer, BarChart, GridComponent, TooltipComponent, LegendComponent]);

const props = defineProps({
  data: { type: Array, default: () => [] },
  lost: { type: Array, default: () => [] },
  found: { type: Array, default: () => [] },
});

const isLoading = ref(true);
const resolvedData = ref([]);

// --- Modern Color Scheme ---
const colors = {
  lost: {
    primary: '#FF6B6B',
    gradient: ['#FF6B6B', '#FF8E8E'],
    light: '#FFF5F5'
  },
  found: {
    primary: '#4CAF50',
    gradient: ['#4CAF50', '#66BB6A'],
    light: '#F1F8E9'
  },
  resolved: {
    primary: '#007BFF',
    gradient: ['#007BFF', '#42A5F5'],
    light: '#E3F2FD'
  },
  background: 'linear-gradient(135deg, #FFFFFF 0%, #F8FAFC 100%)'
};

// --- Helper: extract available years ---
const getAvailableYears = (dataSets) => {
  const years = new Set();
  dataSets.forEach(data => {
    data.forEach(item => {
      const rawDate = item.date_lost || item.date_found || item.reported_at || item.created_at;
      if (rawDate) {
        const date = new Date(rawDate);
        if (!isNaN(date)) years.add(date.getFullYear());
      }
    });
  });
  return Array.from(years).sort((a, b) => b - a);
};

const yearOptions = computed(() => getAvailableYears([props.lost, props.found, resolvedData.value]));

// Default selected year to latest available
const selectedYear = ref(yearOptions.value.length ? yearOptions.value[0] : new Date().getFullYear());

// --- Helper: count cases by month for specific year ---
const getMonthlyCounts = (data, dateField) => {
  const monthlyCounts = Array(12).fill(0);
  data.forEach((item) => {
    const rawDate = item[dateField];
    if (!rawDate) return;

    const date = new Date(rawDate);
    if (isNaN(date)) return;

    const month = date.getMonth();
    const year = date.getFullYear();
    if (year === selectedYear.value) {
      monthlyCounts[month] += item.total || 1;
    }
  });
  return monthlyCounts;
};

// --- Modern Chart Config ---
const chartOptions = ref({
  backgroundColor: 'transparent',
  tooltip: {
    trigger: 'axis',
    backgroundColor: 'rgba(255, 255, 255, 0.95)',
    borderColor: 'rgba(0, 0, 0, 0.1)',
    borderWidth: 1,
    textStyle: { color: '#1E293B' },
    formatter: (params) => {
      let content = `<div style="padding: 12px; font-size: 12px;">
        <div style="font-weight: 600; margin-bottom: 8px; color: #1E293B;">${params[0].name} ${selectedYear.value}</div>`;
      params.forEach((item) => {
        const color = item.color;
        content += `
          <div style="display: flex; align-items: center; margin: 4px 0;">
            <div style="width: 8px; height: 8px; border-radius: 50%; background: ${color}; margin-right: 8px;"></div>
            <span style="flex: 1;">${item.seriesName}:</span>
            <strong style="margin-left: 8px;">${item.value}</strong>
          </div>`;
      });
      content += '</div>';
      return content;
    }
  },
  legend: {
    top: '5%',
    right: '5%',
    textStyle: { color: '#64748B', fontSize: 11, fontWeight: 500 },
    itemGap: 15,
    itemWidth: 12,
    itemHeight: 12
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    top: '15%',
    containLabel: true
  },
  xAxis: {
    type: 'category',
    data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    axisLine: { lineStyle: { color: 'rgba(0, 0, 0, 0.1)' } },
    axisTick: { alignWithLabel: true, lineStyle: { color: 'rgba(0, 0, 0, 0.1)' } },
    axisLabel: { color: '#64748B', fontSize: 11 }
  },
  yAxis: {
    type: 'value',
    axisLine: { lineStyle: { color: 'rgba(0, 0, 0, 0.1)' } },
    axisTick: { lineStyle: { color: 'rgba(0, 0, 0, 0.1)' } },
    axisLabel: { color: '#64748B', fontSize: 11 },
    splitLine: { lineStyle: { color: 'rgba(0, 0, 0, 0.05)', type: 'dashed' } }
  },
  series: []
});

// --- Update Chart Function ---
const updateChart = () => {
  isLoading.value = true;

  const lostCounts = getMonthlyCounts(props.lost, 'date_lost');
  const foundCounts = getMonthlyCounts(props.found, 'date_found');
  const resolvedCounts = getMonthlyCounts(resolvedData.value, 'reported_at');

  chartOptions.value.series = [
    {
      name: 'Lost Cases',
      type: 'bar',
      data: lostCounts,
      barWidth: '20%',
      itemStyle: {
        color: {
          type: 'linear', x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: colors.lost.gradient[0] },
            { offset: 1, color: colors.lost.gradient[1] }
          ]
        },
        borderRadius: [4, 4, 0, 0],
        shadowColor: 'rgba(255, 107, 107, 0.2)',
        shadowBlur: 8,
        shadowOffsetY: 2
      }
    },
    {
      name: 'Found Cases',
      type: 'bar',
      data: foundCounts,
      barWidth: '20%',
      itemStyle: {
        color: {
          type: 'linear', x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: colors.found.gradient[0] },
            { offset: 1, color: colors.found.gradient[1] }
          ]
        },
        borderRadius: [4, 4, 0, 0],
        shadowColor: 'rgba(76, 175, 80, 0.2)',
        shadowBlur: 8,
        shadowOffsetY: 2
      }
    },
    {
      name: 'Resolved Cases',
      type: 'bar',
      data: resolvedCounts,
      barWidth: '20%',
      itemStyle: {
        color: {
          type: 'linear', x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: colors.resolved.gradient[0] },
            { offset: 1, color: colors.resolved.gradient[1] }
          ]
        },
        borderRadius: [4, 4, 0, 0],
        shadowColor: 'rgba(0, 123, 255, 0.2)',
        shadowBlur: 8,
        shadowOffsetY: 2
      }
    }
  ];

  setTimeout(() => {
    isLoading.value = false;
  }, 500);
};

// --- Handle Year Change ---
const handleYearChange = (year) => {
  selectedYear.value = year;
  updateChart();
};

// --- Watchers ---
watch(
  () => props.data,
  (newData) => {
    if (!Array.isArray(newData)) return;
    resolvedData.value = newData.filter((item) =>
      item.status?.toLowerCase() === 'claimed' || item.status?.toLowerCase() === 'resolved'
    );
    updateChart();
  },
  { immediate: true, deep: true }
);

watch(
  () => [props.lost, props.found],
  () => {
    updateChart();
  },
  { immediate: true, deep: true }
);

watch(
  () => selectedYear.value,
  () => {
    updateChart();
  }
);

// --- Check if there's any data ---
const hasAnyData = computed(() => {
  const lostCounts = getMonthlyCounts(props.lost, 'date_lost');
  const foundCounts = getMonthlyCounts(props.found, 'date_found');
  const resolvedCounts = getMonthlyCounts(resolvedData.value, 'reported_at');
  const allCounts = [...lostCounts, ...foundCounts, ...resolvedCounts];
  return allCounts.some((count) => count > 0);
});

// --- Total Cases Computed ---
const totalCases = computed(() => {
  const lostCounts = getMonthlyCounts(props.lost, 'date_lost');
  const foundCounts = getMonthlyCounts(props.found, 'date_found');
  const resolvedCounts = getMonthlyCounts(resolvedData.value, 'reported_at');
  return [...lostCounts, ...foundCounts, ...resolvedCounts].reduce((sum, count) => sum + count, 0);
});
</script>

<template>
  <div class="modern-monthly-stats">
    <div class="card-header">
      <div class="header-content">
        <div class="title-section">
          <div class="icon-wrapper">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
              <path d="M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3ZM9 17H7V10H9V17ZM13 17H11V7H13V17ZM17 17H15V13H17V17Z" fill="currentColor"/>
            </svg>
          </div>
          <div class="text-content">
            <h3 class="card-title">Monthly Analytics</h3>
            <p class="card-subtitle">Case distribution and trends over time</p>
          </div>
        </div>

        <div class="stats-summary">
          <div class="stat-item">
            <div class="stat-value">{{ totalCases }}</div>
            <div class="stat-label">Total Cases</div>
          </div>
        </div>
      </div>

      <div class="filter-section">
        <div class="filter-wrapper">
          <label class="filter-label">View Year</label>
          <select 
            v-model="selectedYear" 
            @change="handleYearChange(selectedYear)"
            class="modern-select"
          >
            <option v-for="year in yearOptions" :key="year" :value="year">{{ year }}</option>
          </select>
        </div>
      </div>
    </div>

    <div class="chart-section">
      <div class="chart-container" :class="{ 'loading': isLoading }">
        <v-chart v-if="hasAnyData && !isLoading" class="modern-chart" :option="chartOptions" autoresize />
        <div v-if="isLoading" class="chart-skeleton"><div class="skeleton-loader"></div></div>
        <div v-if="!hasAnyData && !isLoading" class="empty-state">
          <div class="empty-icon">
            <svg width="64" height="64" viewBox="0 0 24 24" fill="none">
              <path d="M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3ZM9 17H7V10H9V17ZM13 17H11V7H13V17ZM17 17H15V13H17V17Z" fill="#E2E8F0"/>
            </svg>
          </div>
          <h4>No Data Available</h4>
          <p>No case records found for {{ selectedYear }}</p>
        </div>
      </div>
    </div>

    <div class="card-footer">
      <div class="footer-text">Interactive monthly breakdown • Hover for details</div>
    </div>
  </div>
</template>

<style scoped>
@import '../../../../css/admin/dashboard/monthlyStatistic.css';
</style>
