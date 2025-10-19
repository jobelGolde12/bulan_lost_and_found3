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
            <div class="stat-value">{{ props.overallResolved || '...' }}</div>
            <div class="stat-label">Total Resolved</div>
          </div>
        </div>

        <!-- Progress Indicator -->
        <div class="progress-section">
          <div class="d-flex w-100 flex-row justify-content-between align-items-center px-0">
            <div class="progress-label d-flex flex-column justify-content-start align-items-start">
              <span class="d-block">Resolution Progress</span>
              <span class="progress-value d-block">{{ scaledPercent }}%</span>
            </div>

            <div>
            <div class="spinner-border" role="status" v-if="calculating">
              <span class="visually-hidden text-primary"></span>
            </div>
              <p class="target-value" v-else>{{ targetResolved || '100' }}%</p>
            </div>
          </div>

          <!-- PROGRESS BAR -->
          <div class="progress-bar">
            <div
              class="progress-fill"
              :style="{ width: `${progressWidth}%` }"
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
            <div class="center-value">{{ scaledPercent }}%</div>
          </div>
        </div>
        
        <!-- Chart Legend -->
        <div class="chart-legend d-flex flex-row gap-2 align-items-center">
          <div class="btn btn-light" 
            @click="modifyTargetResolve('decrease')"
            :class="{ 'disabled': calculating }"
          >
            <i class="bi bi-arrow-left"></i>
          </div>

          <div>
            <div class="legend-item d-flex flex-column gap-0">
              <div class="center-text">Target</div>
              <div class="text-center fw-bolder">{{ targetResolved }}%</div>
            </div>
          </div>

          <div class="btn btn-light" 
            @click="modifyTargetResolve('increase')"
            :class="{ 'disabled': calculating }"
          >
            <i class="bi bi-arrow-right"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import { use } from 'echarts/core';
import { CanvasRenderer } from 'echarts/renderers';
import { GaugeChart } from 'echarts/charts';
import { TitleComponent } from 'echarts/components';
import VChart from 'vue-echarts';
import axios from 'axios';

use([CanvasRenderer, GaugeChart, TitleComponent]);

const props = defineProps({
  overallResolved: {
    type: Number,
    default: 0
  }
});

const lastUpdated = ref('Just now');
const isAnimating = ref(false);
let targetResolved = ref(100); // default 100%
let calculating = ref(false);
/* ================
   STYLING VARIABLES
================ */
const cssVars = {
  '--primary-gradient': 'linear-gradient(135deg, #007BFF 0%, #0056CC 100%)',
  '--success-gradient': 'linear-gradient(135deg, #10B981 0%, #059669 100%)',
  '--gauge-progress': 'linear-gradient(135deg, #007BFF, #0056CC)',
  '--gauge-bg': 'rgba(0, 123, 255, 0.1)',
  '--card-bg': 'linear-gradient(135deg, #FFFFFF 0%, #F8FAFC 100%)'
};

/* ================
   COMPUTED VALUES
================ */

// Adjusts overallResolved based on targetResolved scaling
const scaledPercent = computed(() => {
  if (!targetResolved.value || targetResolved.value <= 0) return 0;
  const ratio = (props.overallResolved / targetResolved.value) * 100; // Logic sa progress bar
  return Math.min(Math.round(ratio), 100);
});

// Display number that reflects actual progress vs target
const scaledValue = computed(() => {
  if (!targetResolved.value || targetResolved.value <= 0) return props.overallResolved;
  const scaled = (props.overallResolved / targetResolved.value) * 100;
  return `${Math.min(Math.round(scaled), 100)}%`;
});

// Progress bar width (same as scaledPercent)
const progressWidth = computed(() => scaledPercent.value);

/* ================
   CHART CONFIG
================ */
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
            x: 0, y: 0, x2: 0, y2: 1,
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
      axisTick: { show: false },
      splitLine: { show: false },
      axisLabel: { show: false },
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
      detail: { show: false },
      data: [{ value: props.overallResolved }],
      animation: true,
      animationDuration: 2000,
      animationEasing: 'cubicOut'
    }
  ]
});

/* ================
   WATCHERS
================ */
watch(
  () => props.overallResolved,
  (newVal) => {
    chartOptions.value.series[0].data[0].value = scaledPercent.value;
    chartOptions.value = { ...chartOptions.value };
  },
  { immediate: true }
);

/* ================
   API METHODS
================ */
const modifyTargetResolve = async (type) => {
  calculating.value = true;
  if (targetResolved.value <= 100 && type === 'decrease') {
    alert('Cannot set a target resolved cases that are less than 100%');
    calculating.value = false;
    return;
  }
  try {
    const response = await axios.patch(`/target/resolved/${targetResolved.value}/${type}`);
    targetResolved.value = response?.data;
  } catch (e) {
    console.log("Error modifying target:", e);
  } finally {
    calculating.value = false;
  }
};

const fetchTargetResolved = async () => {
  calculating.value = true;
  try {
    const response = await axios.get(`/get/target/resolved`);
    targetResolved.value = response?.data;
  } catch (e) {
    console.log("Error fetching target:", e);
  } finally {
    calculating.value = false;
  }
};

/* ================
   LIFECYCLE
================ */
onMounted(() => {
  lastUpdated.value = new Date().toLocaleTimeString();
  const root = document.documentElement;
  Object.entries(cssVars).forEach(([key, value]) => {
    root.style.setProperty(key, value);
  });
  fetchTargetResolved();
});
</script>

<style scoped>
@import "../../../../css/admin/dashboard/overallResolved.css";

/* Smooth animated progress bar */
.progress-bar {
  width: 100%;
  height: 10px;
  background: rgba(0, 123, 255, 0.1);
  border-radius: 9999px;
  overflow: hidden;
  margin-top: 6px;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(135deg, #007BFF 0%, #0056CC 100%);
  border-radius: 9999px;
  transition: width 0.5s ease;
}
</style>
