<template>
  <div class="modern-resolved-card">
    <!-- Background Decoration -->
    <div class="card-background">
      <div class="bg-gradient-1"></div>
      <div class="bg-gradient-2"></div>
      <div class="bg-pattern"></div>
    </div>

    <!-- Main Content -->
    <div class="card-content">
      <!-- Text Content -->
      <div class="text-content">
        <div class="header-section">
          <div class="icon-wrapper">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <path d="M9 16.17L4.83 12L3.41 13.41L9 19L21 7L19.59 5.59L9 16.17Z" fill="currentColor"/>
            </svg>
          </div>
          <div class="title-section">
            <h3 class="card-title">Cases Resolved</h3>
            <p class="card-subtitle">Successfully closed and claimed items in the system</p>
          </div>
        </div>

        <!-- Stats -->
        <div class="stats-section">
          <div class="main-stat d-flex align-items-center">
            <div class="stat-value">{{ formattedValue }}</div>
            <div class="stat-label">Total Resolved</div>
          </div>
          <!-- <div class="stat-breakdown">
            <div class="breakdown-item">
              <div class="breakdown-dot" style="background: var(--success-gradient)"></div>
              <span class="breakdown-text">Success Rate: {{ successRate }}%</span>
            </div>
          </div> -->
        </div>

        <!-- Progress Indicator -->
        <div class="progress-section">
          <div class="progress-label">
            <span>Resolution Progress</span>
            <span class="progress-value">{{ overallResolved }}%</span>
          </div>
          <div class="progress-bar">
            <div 
              class="progress-fill" 
              :style="{ width: `${Math.min(overallResolved, 100)}%` }"
            ></div>
          </div>
        </div>
      </div>

      <!-- Gauge Chart -->
      <div class="chart-section">
        <div class="chart-wrapper">
          <v-chart 
            class="modern-gauge" 
            :option="chartOptions" 
            autoresize 
          />
          <div class="chart-center-label">
            <div class="center-value">{{ overallResolved }}%</div>
          </div>
        </div>
        
        <!-- Chart Legend -->
        <div class="chart-legend">
          <div class="legend-item">
              <div class="center-text">Resolved</div>
          </div>
        </div>
      </div>
    </div>

    <!-- Interactive Elements -->
    <!-- <div class="card-actions">
      <button class="action-btn" @click="refreshData">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
          <path d="M17.65 6.35C16.2 4.9 14.21 4 12 4C7.58 4 4.01 7.58 4.01 12C4.01 16.42 7.58 20 12 20C15.73 20 18.84 17.45 19.73 14H17.65C16.83 16.33 14.61 18 12 18C8.69 18 6 15.31 6 12C6 8.69 8.69 6 12 6C13.66 6 15.14 6.69 16.22 7.78L13 11H20V4L17.65 6.35Z" fill="currentColor"/>
        </svg>
        Refresh
      </button>
      <div class="last-updated">
        Updated: {{ lastUpdated }}
      </div>
    </div> -->
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
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

const lastUpdated = ref('Just now');
const isAnimating = ref(false);

// CSS Custom Properties for theming
const cssVars = {
  '--primary-gradient': 'linear-gradient(135deg, #007BFF 0%, #0056CC 100%)',
  '--success-gradient': 'linear-gradient(135deg, #10B981 0%, #059669 100%)',
  '--gauge-progress': 'linear-gradient(135deg, #007BFF, #0056CC)',
  '--gauge-bg': 'rgba(0, 123, 255, 0.1)',
  '--card-bg': 'linear-gradient(135deg, #FFFFFF 0%, #F8FAFC 100%)'
};

const formattedValue = computed(() => {
  return Math.round(props.overallResolved);
});

const successRate = computed(() => {
  // Calculate success rate based on resolved percentage
  return Math.min(100, Math.max(0, props.overallResolved + 20));
});

const chartOptions = ref({
  series: [
    {
      type: 'gauge',
      startAngle: 210,
      endAngle: -30,
      min: 0,
      max: 100,
      radius: '110%',
      center: ['50%', '65%'],
      progress: {
        show: true,
        width: 12,
        roundCap: true,
        itemStyle: {
          color: {
            type: 'linear',
            x: 0,
            y: 0,
            x2: 0,
            y2: 1,
            colorStops: [
              { offset: 0, color: '#007BFF' },
              { offset: 1, color: '#0056CC' }
            ]
          },
          shadowColor: 'rgba(0, 123, 255, 0.3)',
          shadowBlur: 8,
          shadowOffsetX: 0,
          shadowOffsetY: 2
        }
      },
      axisLine: {
        lineStyle: {
          width: 12,
          color: [[1, 'rgba(0, 123, 255, 0.1)']],
          shadowColor: 'rgba(0, 0, 0, 0.05)',
          shadowBlur: 4
        },
        roundCap: true
      },
      axisTick: {
        show: false
      },
      splitLine: {
        show: false
      },
      axisLabel: {
        show: false
      },
      pointer: {
        icon: 'path://M12,0 L14,8 L22,8 L15.5,12.5 L18,20 L12,15 L6,20 L8.5,12.5 L2,8 L10,8 Z',
        length: '70%',
        width: 16,
        offsetCenter: [0, '10%'],
        itemStyle: {
          color: '#007BFF',
          shadowColor: 'rgba(0, 123, 255, 0.3)',
          shadowBlur: 6
        }
      },
      anchor: {
        show: true,
        size: 6,
        showAbove: true,
        itemStyle: {
          color: '#007BFF',
          borderWidth: 0,
          shadowColor: 'rgba(0, 123, 255, 0.3)',
          shadowBlur: 4
        }
      },
      detail: {
        show: false
      },
      data: [{ value: props.overallResolved }],
      animation: true,
      animationDuration: 2000,
      animationEasing: 'cubicOut'
    }
  ]
});

const refreshData = () => {
  isAnimating.value = true;
  lastUpdated.value = new Date().toLocaleTimeString();
  
  // Simulate refresh animation
  setTimeout(() => {
    isAnimating.value = false;
  }, 1000);
};

watch(
  () => props.overallResolved,
  (newVal) => {
    chartOptions.value.series[0].data[0].value = newVal;
    
    // Trigger animation update
    if (chartOptions.value.series) {
      chartOptions.value = { ...chartOptions.value };
    }
  },
  { immediate: true }
);

onMounted(() => {
  // Initialize last updated time
  lastUpdated.value = new Date().toLocaleTimeString();
  
  // Apply CSS custom properties
  const root = document.documentElement;
  Object.entries(cssVars).forEach(([key, value]) => {
    root.style.setProperty(key, value);
  });
});
</script>

<style scoped>
.modern-resolved-card {
  background: var(--card-bg);
  border-radius: 24px;
  padding: 2rem;
  position: relative;
  overflow: hidden;
  /* box-shadow: 
    0 20px 40px rgba(0, 0, 0, 0.05),
    0 8px 16px rgba(0, 0, 0, 0.03),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(255, 255, 255, 0.8); */
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
}

/* .modern-resolved-card:hover {
  transform: translateY(-4px);
  box-shadow: 
    0 25px 50px rgba(0, 0, 0, 0.08),
    0 12px 24px rgba(0, 0, 0, 0.04),
    inset 0 1px 0 rgba(255, 255, 255, 0.9);
} */

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
  top: -50%;
  right: -20%;
  width: 200px;
  height: 200px;
  background: radial-gradient(circle, rgba(0, 123, 255, 0.1) 0%, transparent 70%);
  border-radius: 50%;
}

.bg-gradient-2 {
  position: absolute;
  bottom: -30%;
  left: -10%;
  width: 150px;
  height: 150px;
  background: radial-gradient(circle, rgba(0, 123, 255, 0.05) 0%, transparent 70%);
  border-radius: 50%;
}

.bg-pattern {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: 
    radial-gradient(circle at 20% 80%, rgba(0, 123, 255, 0.03) 0%, transparent 50%),
    radial-gradient(circle at 80% 20%, rgba(0, 123, 255, 0.03) 0%, transparent 50%);
}

.card-content {
  position: relative;
  z-index: 1;
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 2rem;
  align-items: center;
}

.text-content {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.header-section {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
}

.icon-wrapper {
  width: 48px;
  height: 48px;
  background: var(--primary-gradient);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  box-shadow: 0 8px 16px rgba(0, 123, 255, 0.2);
}

.title-section {
  flex: 1;
}

.card-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1E293B;
  margin: 0 0 0.5rem 0;
  line-height: 1.2;
}

.card-subtitle {
  color: #64748B;
  font-size: 0.9rem;
  line-height: 1.5;
  margin: 0;
}

.stats-section {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.main-stat {
  display: flex;
  align-items: baseline;
  gap: 0.5rem;
}

.stat-value {
  font-size: 3rem;
  font-weight: 800;
  background: var(--primary-gradient);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  line-height: 1;
}

.stat-label {
  font-size: 1rem;
  color: #64748B;
  font-weight: 500;
}

.stat-breakdown {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.breakdown-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.breakdown-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
}

.breakdown-text {
  font-size: 0.875rem;
  color: #64748B;
}

.progress-section {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.progress-label {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.875rem;
  color: #64748B;
}

.progress-value {
  font-weight: 600;
  color: #007BFF;
}

.progress-bar {
  height: 6px;
  background: rgba(0, 123, 255, 0.1);
  border-radius: 3px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: var(--primary-gradient);
  border-radius: 3px;
  transition: width 1s ease-in-out;
  box-shadow: 0 2px 4px rgba(0, 123, 255, 0.2);
}

.chart-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
}

.chart-wrapper {
  position: relative;
  width: 200px;
  height: 160px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modern-gauge {
  width: 100%;
  height: 100%;
}

.chart-center-label {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
  pointer-events: none;
}

.center-value {
  font-size: 1.5rem;
  font-weight: 700;
  color: #007BFF;
  line-height: 1;
}

.center-text {
  font-size: 0.75rem;
  color: #64748B;
  margin-top: 0.25rem;
}

.chart-legend {
  display: flex;
  gap: 1rem;
  font-size: 0.75rem;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #64748B;
}

.legend-color {
  width: 12px;
  height: 4px;
  border-radius: 2px;
}

.card-actions {
  position: relative;
  z-index: 1;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 1.5rem;
  padding-top: 1.5rem;
  border-top: 1px solid rgba(0, 0, 0, 0.05);
}

.action-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: rgba(0, 123, 255, 0.1);
  border: 1px solid rgba(0, 123, 255, 0.2);
  border-radius: 8px;
  color: #007BFF;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
}

.action-btn:hover {
  background: rgba(0, 123, 255, 0.15);
  transform: translateY(-1px);
}

.last-updated {
  font-size: 0.75rem;
  color: #94A3B8;
}

/* Responsive Design */
@media (max-width: 1024px) {
  .card-content {
    grid-template-columns: 1fr;
    gap: 2rem;
    text-align: center;
  }
  
  .header-section {
    justify-content: center;
    text-align: center;
  }
  
  .stats-section {
    align-items: center;
  }
  
  .main-stat {
    justify-content: center;
  }
}

@media (max-width: 768px) {
  .modern-resolved-card {
    padding: 1.5rem;
    border-radius: 20px;
  }
  
  .stat-value {
    font-size: 2.5rem;
  }
  
  .chart-wrapper {
    width: 180px;
    height: 140px;
  }
}

@media (max-width: 480px) {
  .modern-resolved-card {
    padding: 1.25rem;
  }
  
  .card-actions {
    flex-direction: column;
    gap: 1rem;
    align-items: stretch;
  }
  
  .action-btn {
    justify-content: center;
  }
  
  .last-updated {
    text-align: center;
  }
}

/* Animation for value changes */
@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}

.stat-value {
  animation: pulse 0.6s ease-in-out;
}
</style>