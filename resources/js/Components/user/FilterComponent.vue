<template>
  <div class="container-fluid mt-3 d-flex flex-row justify-content-between align-items-center">
    <div class="d-flex gap-2">
      <div>
        <select
          name="filter"
          id="filter"
          class="form-control bg-light mt-2 fixed-width"
          v-model="selectedFilter"
          @change="emitFilter"
        >
          <option disabled value="">Status</option>
          <option value="all">All</option>
          <option value="Lost">Lost</option>
          <option value="Found">Found</option>
        </select>
      </div>
    </div>

    <div>
      <FindMatchButton />
    </div>

    <div class="change-text d-none d-lg-block">
      <p class="text-dark">
        All <span v-if="selectedFilter !== 'all'">{{ selectedFilter }}</span> items
      </p>
    </div>

    <!-- Fullscreen Loading Overlay -->
    <div v-if="loading" class="loading-overlay">
      <div class="loading-container">
        <!-- Modern Glass Spinner -->
        <div class="glass-spinner">
          <div class="spinner-core"></div>
          <div class="spinner-orbits">
            <div class="orbit orbit-1"></div>
            <div class="orbit orbit-2"></div>
            <div class="orbit orbit-3"></div>
          </div>
          <div class="spinner-pulse"></div>
        </div>
        
        <!-- Loading Text -->
        <div class="loading-content">
          <h3 class="loading-title">Loading Items</h3>
          <p class="loading-subtitle">Please wait while we fetch your data</p>
          <div class="progress-track">
            <div class="progress-bar"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps, defineModel } from "vue";
import FindMatchButton from "../admin/dashboard/FindMatchButton.vue";
import axios from "axios";

const selectedFilter = ref("");
const items = defineModel("items");
const category = defineModel("category");
const loading = defineModel("loading");

const emit = defineEmits(["filterSelected"]);

const emitFilter = () => {
  emit("filterSelected", selectedFilter.value);
  filerItem();
};

const filerItem = async () => {
  loading.value = true;
  try {
    const res = await axios.get(
      `/items/filter/${selectedFilter.value}/${category.value || "all"}`
    );
    items.value = res.data;
  } catch (e) {
    console.error("An error while filtering items: ", e);
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
.fixed-width {
  width: 10%;
  min-width: 100px;
  max-width: 200px;
}

.change-text {
  width: 130px;
  right: 20%;
}

/* Fullscreen Light Overlay */
.loading-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
}

.loading-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3rem;
}

/* Modern Glass Spinner */
.glass-spinner {
  position: relative;
  width: 120px;
  height: 120px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.spinner-core {
  width: 20px;
  height: 20px;
  background: linear-gradient(135deg, #3b82f6, #8b5cf6);
  border-radius: 50%;
  box-shadow: 
    0 0 20px rgba(59, 130, 246, 0.4),
    0 0 40px rgba(139, 92, 246, 0.2);
  z-index: 3;
  animation: corePulse 2s ease-in-out infinite;
}

.spinner-orbits {
  position: absolute;
  width: 100%;
  height: 100%;
}

.orbit {
  position: absolute;
  border: 2px solid transparent;
  border-radius: 50%;
  animation: orbitSpin linear infinite;
}

.orbit-1 {
  top: 10%;
  left: 10%;
  right: 10%;
  bottom: 10%;
  border-top-color: #3b82f6;
  border-right-color: #3b82f6;
  animation-duration: 3s;
}

.orbit-2 {
  top: 20%;
  left: 20%;
  right: 20%;
  bottom: 20%;
  border-bottom-color: #8b5cf6;
  border-left-color: #8b5cf6;
  animation-duration: 4s;
  animation-direction: reverse;
}

.orbit-3 {
  top: 30%;
  left: 30%;
  right: 30%;
  bottom: 30%;
  border-top-color: #10b981;
  border-left-color: #10b981;
  animation-duration: 5s;
}

.spinner-pulse {
  position: absolute;
  width: 100%;
  height: 100%;
  border: 2px solid #e2e8f0;
  border-radius: 50%;
  animation: pulseGlow 3s ease-out infinite;
}

/* Loading Content */
.loading-content {
  text-align: center;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.loading-title {
  font-size: 1.5rem;
  font-weight: 600;
  color: #1e293b;
  margin: 0;
  letter-spacing: -0.025em;
}

.loading-subtitle {
  font-size: 0.95rem;
  color: #64748b;
  margin: 0;
  font-weight: 400;
}

.progress-track {
  width: 200px;
  height: 4px;
  background: #f1f5f9;
  border-radius: 2px;
  overflow: hidden;
  margin: 0.5rem auto 0;
}

.progress-bar {
  height: 100%;
  background: linear-gradient(90deg, #3b82f6, #8b5cf6);
  border-radius: 2px;
  animation: progressLoad 2s ease-in-out infinite;
}

/* Animations */
@keyframes orbitSpin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

@keyframes corePulse {
  0%, 100% {
    transform: scale(1);
    opacity: 1;
  }
  50% {
    transform: scale(1.1);
    opacity: 0.8;
  }
}

@keyframes pulseGlow {
  0% {
    transform: scale(1);
    opacity: 1;
    border-color: #e2e8f0;
  }
  50% {
    transform: scale(1.1);
    opacity: 0.7;
    border-color: #cbd5e1;
  }
  100% {
    transform: scale(1.2);
    opacity: 0;
    border-color: #94a3b8;
  }
}

@keyframes progressLoad {
  0% {
    transform: translateX(-100%);
    width: 20%;
  }
  50% {
    transform: translateX(0%);
    width: 60%;
  }
  100% {
    transform: translateX(200%);
    width: 20%;
  }
}

/* Responsive Design */
@media (max-width: 768px) {
  .glass-spinner {
    width: 100px;
    height: 100px;
  }
  
  .loading-title {
    font-size: 1.25rem;
  }
  
  .loading-subtitle {
    font-size: 0.875rem;
  }
  
  .progress-track {
    width: 160px;
  }
  
  .loading-container {
    gap: 2rem;
  }
}

/* Smooth entrance animation */
.loading-overlay {
  animation: fadeIn 0.3s ease-out;
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
</style>