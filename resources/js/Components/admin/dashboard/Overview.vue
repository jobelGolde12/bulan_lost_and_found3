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
const isLoading = ref(true);

// Modern color palette
const colors = {
  lost: {
    primary: "#FF6B6B",
    gradient: ["#FF6B6B", "#FF8E8E"],
    light: "#FFF5F5"
  },
  found: {
    primary: "#4CAF50", 
    gradient: ["#4CAF50", "#66BB6A"],
    light: "#F1F8E9"
  },
  resolved: {
    primary: "#007BFF",
    gradient: ["#007BFF", "#42A5F5"],
    light: "#E3F2FD"
  }
};

const chartOptions = ref({
  backgroundColor: 'transparent',
  tooltip: {
    trigger: "item",
    backgroundColor: "rgba(255, 255, 255, 0.95)",
    borderColor: "rgba(0, 0, 0, 0.1)",
    borderWidth: 1,
    textStyle: { color: "#333" },
    formatter: (params) => {
      const total = params.data.value + params.data.otherValues.reduce((a, b) => a + b, 0);
      const percentage = ((params.data.value / total) * 100).toFixed(1);
      return `
        <div style="padding: 8px;">
          <strong>${params.name}</strong><br/>
          Count: ${params.data.value}<br/>
          Percentage: ${percentage}%
        </div>
      `;
    }
  },
  legend: {
    bottom: "5%",
    left: "center",
    textStyle: { 
      color: "#64748B",
      fontSize: 12,
      fontWeight: 500
    },
    itemGap: 20,
    itemWidth: 12,
    itemHeight: 12
  },
  series: [
    {
      name: "Cases",
      type: "pie",
      radius: ["55%", "80%"],
      center: ["50%", "45%"],
      avoidLabelOverlap: false,
      itemStyle: {
        borderRadius: 8,
        borderColor: "#fff",
        borderWidth: 2
      },
      label: {
        show: false,
        position: "center",
        formatter: "{c}",
        fontSize: 24,
        fontWeight: "bold",
        color: "#1E293B"
      },
      emphasis: {
        label: {
          show: true,
          fontSize: 18,
          fontWeight: "bold",
          color: "#1E293B"
        },
        scale: true,
        scaleSize: 5
      },
      labelLine: { show: false },
      data: [
        { 
          value: props.data.lostItems, 
          name: "Lost Cases", 
          itemStyle: { 
            color: {
              type: 'linear',
              x: 0, y: 0, x2: 0, y2: 1,
              colorStops: [
                { offset: 0, color: colors.lost.gradient[0] },
                { offset: 1, color: colors.lost.gradient[1] }
              ]
            }
          } 
        },
        { 
          value: props.data.fountItems, 
          name: "Found Cases", 
          itemStyle: { 
            color: {
              type: 'linear',
              x: 0, y: 0, x2: 0, y2: 1,
              colorStops: [
                { offset: 0, color: colors.found.gradient[0] },
                { offset: 1, color: colors.found.gradient[1] }
              ]
            }
          } 
        },
        { 
          value: props.data.resolve, 
          name: "Resolved Cases", 
          itemStyle: { 
            color: {
              type: 'linear',
              x: 0, y: 0, x2: 0, y2: 1,
              colorStops: [
                { offset: 0, color: colors.resolved.gradient[0] },
                { offset: 1, color: colors.resolved.gradient[1] }
              ]
            }
          } 
        },
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
            { 
              value: lost, 
              name: "Lost Cases", 
              itemStyle: { 
                color: {
                  type: 'linear',
                  x: 0, y: 0, x2: 0, y2: 1,
                  colorStops: [
                    { offset: 0, color: colors.lost.gradient[0] },
                    { offset: 1, color: colors.lost.gradient[1] }
                  ]
                }
              } 
            },
            { 
              value: found, 
              name: "Found Cases", 
              itemStyle: { 
                color: {
                  type: 'linear',
                  x: 0, y: 0, x2: 0, y2: 1,
                  colorStops: [
                    { offset: 0, color: colors.found.gradient[0] },
                    { offset: 1, color: colors.found.gradient[1] }
                  ]
                }
              } 
            },
            { 
              value: resolved, 
              name: "Resolved Cases", 
              itemStyle: { 
                color: {
                  type: 'linear',
                  x: 0, y: 0, x2: 0, y2: 1,
                  colorStops: [
                    { offset: 0, color: colors.resolved.gradient[0] },
                    { offset: 1, color: colors.resolved.gradient[1] }
                  ]
                }
              } 
            },
          ],
        },
      ],
    });
  }
  isLoading.value = false;
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
  <div class="modern-overview">
    <!-- Header Section -->
    <div class="overview-header">
      <div class="header-content">
        <h2 class="overview-title">Case Overview</h2>
        <p class="overview-subtitle">
          Real-time summary of lost, found, and resolved cases in the system
        </p>
      </div>
      <div class="header-decoration">
        <div class="decoration-dot dot-1"></div>
        <div class="decoration-dot dot-2"></div>
        <div class="decoration-dot dot-3"></div>
      </div>
    </div>

    <!-- Main Content -->
    <div class="overview-content">
      <!-- Stats Cards -->
      <div class="stats-grid">
        <div class="stat-card lost-card">
          <div class="stat-icon">
            <div class="icon-wrapper">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                <path d="M12 2C13.1 2 14 2.9 14 4C14 5.1 13.1 6 12 6C10.9 6 10 5.1 10 4C10 2.9 10.9 2 12 2ZM21 9V7L15 5.5V7H9V5.5L3 7V9L9 10.5V12.5L3 14V16L9 17.5V22H15V17.5L21 16V14L15 12.5V10.5L21 9Z" 
                      :fill="colors.lost.primary"/>
              </svg>
            </div>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ data.lostItems || 0 }}</div>
            <div class="stat-label">Lost Items</div>
          </div>
          <div class="stat-trend">
            <div class="trend-dot" :style="{ backgroundColor: colors.lost.primary }"></div>
          </div>
        </div>

        <div class="stat-card found-card">
          <div class="stat-icon">
            <div class="icon-wrapper">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z" 
                      :fill="colors.found.primary"/>
              </svg>
            </div>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ data.fountItems || 0 }}</div>
            <div class="stat-label">Found Items</div>
          </div>
          <div class="stat-trend">
            <div class="trend-dot" :style="{ backgroundColor: colors.found.primary }"></div>
          </div>
        </div>

        <div class="stat-card resolved-card">
          <div class="stat-icon">
            <div class="icon-wrapper">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z" 
                      :fill="colors.resolved.primary"/>
              </svg>
            </div>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ data.resolve || 0 }}</div>
            <div class="stat-label">Resolved Cases</div>
          </div>
          <div class="stat-trend">
            <div class="trend-dot" :style="{ backgroundColor: colors.resolved.primary }"></div>
          </div>
        </div>
      </div>

      <!-- Chart Section -->
      <div class="chart-container">
        <div class="chart-wrapper">
          <v-chart
            ref="chartRef"
            :option="chartOptions"
            autoresize
            class="modern-chart"
            v-if="!isLoading"
          />
          <div v-else class="chart-skeleton">
            <div class="skeleton-loader"></div>
          </div>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <div class="overview-footer">
      <div class="footer-text">
        Last updated: {{ new Date().toLocaleTimeString() }}
      </div>
    </div>
  </div>
</template>

<style scoped>
.modern-overview {
  background: linear-gradient(135deg, #FFFFFF 0%, #F8FAFC 100%);
  border-radius: 20px;
  padding: 2rem;
  /* box-shadow: 
    0 10px 25px rgba(0, 0, 0, 0.05),
    0 5px 10px rgba(0, 0, 0, 0.02);
  border: 1px solid rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px); */
  position: relative;
  overflow: hidden;
}

.overview-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 2rem;
  position: relative;
}

.header-content {
  flex: 1;
}

.overview-title {
  font-size: 1.75rem;
  font-weight: 700;
  background: linear-gradient(135deg, #1E293B 0%, #475569 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: 0.5rem;
}

.overview-subtitle {
  color: #64748B;
  font-size: 0.9rem;
  line-height: 1.5;
  margin: 0;
}

.header-decoration {
  display: flex;
  gap: 8px;
}

.decoration-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  animation: float 3s ease-in-out infinite;
}

.dot-1 {
  background: linear-gradient(135deg, #FF6B6B, #FF8E8E);
  animation-delay: 0s;
}

.dot-2 {
  background: linear-gradient(135deg, #4CAF50, #66BB6A);
  animation-delay: 0.2s;
}

.dot-3 {
  background: linear-gradient(135deg, #007BFF, #42A5F5);
  animation-delay: 0.4s;
}

.overview-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 2rem;
  align-items: center;
}

.stats-grid {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.stat-card {
  background: white;
  padding: 1.5rem;
  border-radius: 16px;
  display: flex;
  align-items: center;
  gap: 1rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.03);
  transition: all 0.3s ease;
}

.stat-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
}

.stat-icon .icon-wrapper {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.lost-card .icon-wrapper {
  background-color: v-bind('colors.lost.light');
}

.found-card .icon-wrapper {
  background-color: v-bind('colors.found.light');
}

.resolved-card .icon-wrapper {
  background-color: v-bind('colors.resolved.light');
}

.stat-info {
  flex: 1;
}

.stat-value {
  font-size: 2rem;
  font-weight: 700;
  color: #1E293B;
  line-height: 1;
  margin-bottom: 0.25rem;
}

.stat-label {
  font-size: 0.875rem;
  color: #64748B;
  font-weight: 500;
}

.stat-trend .trend-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.chart-container {
  position: relative;
}

.chart-wrapper {
  background: white;
  border-radius: 16px;
  padding: 1.5rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.03);
}

.modern-chart {
  width: 100%;
  height: 300px;
  min-height: 300px;
}

.chart-skeleton {
  width: 100%;
  height: 300px;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
  border-radius: 12px;
}

.overview-footer {
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
@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-5px); }
}

@keyframes loading {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

/* Responsive Design */
@media (max-width: 1024px) {
  .overview-content {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .stats-grid {
    order: 2;
  }
  
  .chart-container {
    order: 1;
  }
}

@media (max-width: 768px) {
  .modern-overview {
    padding: 1.5rem;
    border-radius: 16px;
  }
  
  .overview-header {
    flex-direction: column;
    gap: 1rem;
  }
  
  .header-decoration {
    align-self: flex-start;
  }
  
  .stat-card {
    padding: 1.25rem;
  }
  
  .stat-value {
    font-size: 1.75rem;
  }
}

@media (max-width: 480px) {
  .modern-overview {
    padding: 1rem;
  }
  
  .overview-title {
    font-size: 1.5rem;
  }
  
  .stat-card {
    flex-direction: column;
    text-align: center;
    gap: 0.75rem;
  }
  
  .stat-info {
    text-align: center;
  }
}
</style>