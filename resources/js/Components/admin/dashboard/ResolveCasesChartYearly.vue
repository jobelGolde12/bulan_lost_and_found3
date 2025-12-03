<script setup>
import { ref, defineProps, watch, computed } from 'vue';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { BarChart } from 'echarts/charts';
import { GridComponent, TooltipComponent, LegendComponent } from 'echarts/components';
import VChart from 'vue-echarts';


use([CanvasRenderer, BarChart, GridComponent, TooltipComponent, LegendComponent]);

const props = defineProps({
  data: {
    type: Array,
    default: () => [],
  },
  lost: { type: Array, default: () => [] },
  found: { type: Array, default: () => [] },
});

const isLoading = ref(true);
const resolvedData = ref([]);

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

// --- Chart Options ---
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
        <div style="font-weight: 600; margin-bottom: 8px; color: #1E293B;">Year ${params[0].name}</div>`;
      
      let total = 0;
      params.forEach((item) => {
        total += item.value;
      });
      
      params.forEach((item) => {
        const percentage = total ? ((item.value / total) * 100).toFixed(1) : 0;
        const color = item.color;
        content += `
          <div style="display: flex; align-items: center; margin: 4px 0;">
            <div style="width: 8px; height: 8px; border-radius: 50%; background: ${color}; margin-right: 8px;"></div>
            <span style="flex: 1;">${item.seriesName}:</span>
            <strong style="margin-left: 8px;">${item.value}</strong>
            <span style="margin-left: 8px; color: #64748B;">(${percentage}%)</span>
          </div>`;
      });
      
      content += `
        <div style="border-top: 1px solid rgba(0,0,0,0.1); margin-top: 8px; padding-top: 8px; font-weight: 600;">
          Total: ${total} cases
        </div>
      </div>`;
      return content;
    }
  },
  legend: {
    top: '5%',
    right: '5%',
    textStyle: { 
      color: '#64748B',
      fontSize: 11,
      fontWeight: 500
    },
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
    axisLine: {
      lineStyle: { color: 'rgba(0, 0, 0, 0.1)' }
    },
    axisTick: {
      alignWithLabel: true,
      lineStyle: { color: 'rgba(0, 0, 0, 0.1)' }
    },
    axisLabel: {
      color: '#64748B',
      fontSize: 11,
      fontWeight: 500
    }
  },
  yAxis: {
    type: 'value',
    axisLine: {
      lineStyle: { color: 'rgba(0, 0, 0, 0.1)' }
    },
    axisTick: {
      lineStyle: { color: 'rgba(0, 0, 0, 0.1)' }
    },
    axisLabel: {
      color: '#64748B',
      fontSize: 11
    },
    splitLine: {
      lineStyle: {
        color: 'rgba(0, 0, 0, 0.05)',
        type: 'dashed'
      }
    }
  },
  series: []
});

// --- Update Chart Function ---
const updateChart = () => {
  isLoading.value = true;
  
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

  chartOptions.value.xAxis.data = uniqueYears;
  
  chartOptions.value.series = [
    {
      name: 'Lost Cases',
      type: 'bar',
      data: lostCounts,
      barWidth: '18%',
      itemStyle: {
        color: {
          type: 'linear',
          x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: colors.lost.gradient[0] },
            { offset: 1, color: colors.lost.gradient[1] }
          ]
        },
        borderRadius: [6, 6, 0, 0],
        shadowColor: 'rgba(255, 107, 107, 0.3)',
        shadowBlur: 8,
        shadowOffsetY: 3
      },
      emphasis: {
        itemStyle: {
          shadowColor: 'rgba(255, 107, 107, 0.5)',
          shadowBlur: 12
        }
      }
    },
    {
      name: 'Found Cases',
      type: 'bar',
      data: foundCounts,
      barWidth: '18%',
      itemStyle: {
        color: {
          type: 'linear',
          x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: colors.found.gradient[0] },
            { offset: 1, color: colors.found.gradient[1] }
          ]
        },
        borderRadius: [6, 6, 0, 0],
        shadowColor: 'rgba(76, 175, 80, 0.3)',
        shadowBlur: 8,
        shadowOffsetY: 3
      },
      emphasis: {
        itemStyle: {
          shadowColor: 'rgba(76, 175, 80, 0.5)',
          shadowBlur: 12
        }
      }
    },
    {
      name: 'Resolved Cases',
      type: 'bar',
      data: resolvedCounts,
      barWidth: '18%',
      itemStyle: {
        color: {
          type: 'linear',
          x: 0, y: 0, x2: 0, y2: 1,
          colorStops: [
            { offset: 0, color: colors.resolved.gradient[0] },
            { offset: 1, color: colors.resolved.gradient[1] }
          ]
        },
        borderRadius: [6, 6, 0, 0],
        shadowColor: 'rgba(0, 123, 255, 0.3)',
        shadowBlur: 8,
        shadowOffsetY: 3
      },
      emphasis: {
        itemStyle: {
          shadowColor: 'rgba(0, 123, 255, 0.5)',
          shadowBlur: 12
        }
      }
    }
  ];

  setTimeout(() => {
    isLoading.value = false;
  }, 600);
};

// --- Computed Properties ---
const hasData = computed(() => {
  const lostYearly = groupByYear(props.lost, 'date_lost');
  const foundYearly = groupByYear(props.found, 'date_found');
  const resolvedYearly = groupByYearAndStatus(props.data);

  const allYears = [
    ...Object.keys(lostYearly),
    ...Object.keys(foundYearly),
    ...Object.keys(resolvedYearly)
  ];
  const uniqueYears = [...new Set(allYears)];

  return uniqueYears.length > 0 && (
    Object.values(lostYearly).some(count => count > 0) ||
    Object.values(foundYearly).some(count => count > 0) ||
    Object.values(resolvedYearly).some(yearData => yearData.Resolved > 0)
  );
});

const totalCases = computed(() => {
  const lostYearly = groupByYear(props.lost, 'date_lost');
  const foundYearly = groupByYear(props.found, 'date_found');
  const resolvedYearly = groupByYearAndStatus(props.data);

  const totalLost = Object.values(lostYearly).reduce((sum, count) => sum + count, 0);
  const totalFound = Object.values(foundYearly).reduce((sum, count) => sum + count, 0);
  const totalResolved = Object.values(resolvedYearly).reduce((sum, yearData) => sum + yearData.Resolved, 0);

  return totalLost + totalFound + totalResolved;
});

const yearRange = computed(() => {
  const lostYearly = groupByYear(props.lost, 'date_lost');
  const foundYearly = groupByYear(props.found, 'date_found');
  const resolvedYearly = groupByYearAndStatus(props.data);

  const allYears = [
    ...Object.keys(lostYearly),
    ...Object.keys(foundYearly),
    ...Object.keys(resolvedYearly)
  ].map(year => parseInt(year));
  
  if (allYears.length === 0) return 'No data';
  
  const minYear = Math.min(...allYears);
  const maxYear = Math.max(...allYears);
  
  return minYear === maxYear ? `${minYear}` : `${minYear} - ${maxYear}`;
});

// --- Watch Props for Changes ---
watch(
  () => [props.data, props.lost, props.found],
  () => {
    if (!Array.isArray(props.data)) return;

    resolvedData.value = props.data.filter((item) =>
      item.status?.toLowerCase() === 'claimed' || item.status?.toLowerCase() === 'resolved'
    );

    updateChart();
  },
  { immediate: true, deep: true }
);
</script>

<template>
  <div class="modern-yearly-stats">
    <!-- Background Elements -->
    <div class="card-background">
      <div class="bg-gradient-1"></div>
      <div class="bg-gradient-2"></div>
    </div>

    <!-- Header Section -->
    <div class="card-header">
      <div class="header-content">
        <div class="title-section">
          <div class="icon-wrapper">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
              <path d="M9 17H7V10H9V17ZM13 17H11V7H13V17ZM17 17H15V13H17V17ZM19 19H5V5H19V19.1M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3Z" fill="currentColor"/>
            </svg>
          </div>
          <div class="text-content">
            <h3 class="card-title fs-5">Yearly Overview</h3>
            <p class="card-subtitle">Case trends and distribution across years</p>
          </div>
        </div>
        
        <!-- Stats Summary -->
        <div class="stats-summary">
          <div class="stat-item">
            <div class="stat-value fs-5">{{ totalCases }}</div>
            <div class="stat-label">Total Cases</div>
          </div>
          <div class="stat-item">
            <div class="stat-value fs-5">{{ yearRange }}</div>
            <div class="stat-label">Year Range</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Chart Section -->
    <div class="chart-section">
      <div class="chart-container" :class="{ 'loading': isLoading }">
        <v-chart 
          v-if="hasData && !isLoading" 
          class="modern-chart" 
          :option="chartOptions" 
          autoresize 
        />
        
        <!-- Loading State -->
        <div v-if="isLoading" class="chart-skeleton">
          <div class="skeleton-loader"></div>
        </div>
        
        <!-- Empty State -->
        <div v-if="!hasData && !isLoading" class="empty-state">
          <div class="empty-icon">
            <svg width="64" height="64" viewBox="0 0 24 24" fill="none">
              <path d="M19 3H5C3.9 3 3 3.9 3 5V19C3 20.1 3.9 21 5 21H19C20.1 21 21 20.1 21 19V5C21 3.9 20.1 3 19 3ZM9 17H7V10H9V17ZM13 17H11V7H13V17ZM17 17H15V13H17V17Z" fill="#E2E8F0"/>
            </svg>
          </div>
          <h4>No Historical Data</h4>
          <p>No case records available for yearly analysis</p>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <div class="card-footer">
      <div class="footer-text">
        Multi-year trend analysis • Hover bars for detailed breakdown
      </div>
    </div>
  </div>
</template>

<style scoped>
.modern-yearly-stats {
  background: v-bind('colors.background');
  border-radius: 20px;
  padding: 2rem;
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
}

.card-background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
  z-index: 0;
}

.bg-gradient-1 {
  position: absolute;
  top: -20%;
  right: -10%;
  width: 150px;
  height: 150px;
  background: radial-gradient(circle, rgba(76, 175, 80, 0.05) 0%, transparent 70%);
  border-radius: 50%;
}

.bg-gradient-2 {
  position: absolute;
  bottom: -30%;
  left: -5%;
  width: 120px;
  height: 120px;
  background: radial-gradient(circle, rgba(255, 107, 107, 0.05) 0%, transparent 70%);
  border-radius: 50%;
}

.card-header {
  position: relative;
  z-index: 1;
  margin-bottom: 2rem;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.title-section {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.icon-wrapper {
  width: 48px;
  height: 48px;
  background: linear-gradient(135deg, #10B981 0%, #059669 100%);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  box-shadow: 0 8px 16px rgba(16, 185, 129, 0.2);
}

.text-content {
  display: flex;
  flex-direction: column;
}

.card-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1E293B;
  margin: 0 0 0.25rem 0;
  line-height: 1.2;
}

.card-subtitle {
  color: #64748B;
  font-size: 0.9rem;
  line-height: 1.5;
  margin: 0;
}

.stats-summary {
  display: flex;
  align-items: center;
  gap: 2rem;
}

.stat-item {
  text-align: center;
}

.stat-value {
  font-size: 1.75rem;
  font-weight: 800;
  background: linear-gradient(135deg, #1E293B 0%, #475569 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1;
  margin-bottom: 0.25rem;
}

.stat-label {
  font-size: 0.875rem;
  color: #64748B;
  font-weight: 500;
}

.chart-section {
  position: relative;
  z-index: 1;
}

.chart-container {
  background: white;
  border-radius: 16px;
  padding: 1.5rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.03);
  min-height: 400px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.chart-container.loading {
  background: linear-gradient(90deg, #f8fafc 25%, #f1f5f9 50%, #f8fafc 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
}

.modern-chart {
  width: 100%;
  height: 400px;
}

.chart-skeleton {
  width: 100%;
  height: 400px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.skeleton-loader {
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
  border-radius: 12px;
}

.empty-state {
  text-align: center;
  padding: 3rem 2rem;
  color: #64748B;
}

.empty-icon {
  margin-bottom: 1rem;
  opacity: 0.5;
}

.empty-state h4 {
  color: #475569;
  margin: 0 0 0.5rem 0;
  font-weight: 600;
}

.empty-state p {
  margin: 0;
  font-size: 0.9rem;
}

.card-footer {
  position: relative;
  z-index: 1;
  margin-top: 1.5rem;
  padding-top: 1rem;
  border-top: 1px solid rgba(0, 0, 0, 0.05);
}

.footer-text {
  font-size: 0.75rem;
  color: #94A3B8;
  text-align: center;
}

/* Animations */
@keyframes loading {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

/* Responsive Design */
@media (max-width: 1024px) {
  .header-content {
    flex-direction: column;
    gap: 1.5rem;
    align-items: flex-start;
  }
  
  .stats-summary {
    align-self: stretch;
    justify-content: space-around;
  }
}

@media (max-width: 768px) {
  .modern-yearly-stats {
    padding: 1.5rem;
    border-radius: 16px;
  }
  
  .title-section {
    flex-direction: column;
    text-align: center;
    gap: 0.75rem;
  }
  .title-section{
    margin-left: auto;
  margin-right: auto;
}
  .text-content {
    display: flex;
    justify-content: center;
    align-items: center;
  }
  
  .stats-summary {
    flex-direction: column;
    gap: 1rem;
  }
  
  .stat-value {
    font-size: 1.5rem;
  }
  
  .chart-container {
    padding: 1rem;
    min-height: 350px;
  }
  
  .modern-chart {
    height: 350px;
  }
}

@media (max-width: 480px) {
  .modern-yearly-stats {
    padding: 1.25rem;
  }
  
  .card-title {
    font-size: 1.25rem;
  }
  
  .stats-summary {
    flex-direction: column;
    gap: 1rem;
  }
}
</style>