<template>
  <div class="modern-loader" :class="{ 'fullscreen': fullscreen }">
    <div class="loader-content">
      <!-- Pulsing core with orbiting particles -->
      <div class="quantum-loader">
        <div class="core"></div>
        <div 
          v-for="particle in particles" 
          :key="particle.id"
          class="particle" 
          :class="`particle-${particle.id}`"
          :style="particle.style"
        ></div>
      </div>
      
      <!-- Loading text with animated gradient -->
      <div class="loading-text">
        <span class="text-gradient">{{ loadingText }}</span>
        <span class="dots">
          <span v-for="dot in visibleDots" :key="dot" class="dot">.</span>
        </span>
      </div>
      
      <!-- Optional progress indicator -->
      <div v-if="showProgress" class="progress-container">
        <div class="progress-track">
          <div class="progress-fill" :style="{ width: progress + '%' }">
            <div class="progress-glow"></div>
          </div>
        </div>
        <div class="progress-text">{{ progress }}%</div>
      </div>
    </div>
    
    <!-- Optional background elements -->
    <div v-if="showBackgroundElements" class="background-elements">
      <div class="bg-grid"></div>
      <div class="bg-glow"></div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

// Props
const props = defineProps({
  fullscreen: {
    type: Boolean,
    default: false
  },
  loadingText: {
    type: String,
    default: 'Loading'
  },
  showProgress: {
    type: Boolean,
    default: false
  },
  progress: {
    type: Number,
    default: 0
  },
  showBackgroundElements: {
    type: Boolean,
    default: true
  },
  size: {
    type: String,
    default: 'medium', // 'small', 'medium', 'large'
    validator: (value) => ['small', 'medium', 'large'].includes(value)
  }
})

// Reactive state
const dotsCount = ref(0)
const dotsInterval = ref(null)

// Particle system
const particles = ref([
  { id: 1, style: {} },
  { id: 2, style: {} },
  { id: 3, style: {} },
  { id: 4, style: {} },
  { id: 5, style: {} },
  { id: 6, style: {} }
])

// Computed properties
const visibleDots = computed(() => {
  const count = dotsCount.value % 4
  return Array.from({ length: count }, (_, i) => i)
})

const sizeMultiplier = computed(() => {
  switch (props.size) {
    case 'small': return 0.7
    case 'large': return 1.3
    default: return 1
  }
})

// Lifecycle
onMounted(() => {
  // Animate dots
  dotsInterval.value = setInterval(() => {
    dotsCount.value = (dotsCount.value + 1) % 4
  }, 500)
})

onUnmounted(() => {
  if (dotsInterval.value) {
    clearInterval(dotsInterval.value)
  }
})
</script>

<style scoped>
.modern-loader {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  background: transparent;
  position: relative;
}

.modern-loader.fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(10, 10, 20, 0.95);
  backdrop-filter: blur(5px);
  z-index: 9999;
}

.loader-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2rem;
  z-index: 2;
  position: relative;
}

/* Quantum Loader */
.quantum-loader {
  position: relative;
  width: calc(120px * v-bind(sizeMultiplier));
  height: calc(120px * v-bind(sizeMultiplier));
  display: flex;
  align-items: center;
  justify-content: center;
}

.core {
  width: calc(24px * v-bind(sizeMultiplier));
  height: calc(24px * v-bind(sizeMultiplier));
  border-radius: 50%;
  background: radial-gradient(circle, #60a5fa, #3b82f6);
  box-shadow: 
    0 0 calc(20px * v-bind(sizeMultiplier)) #3b82f6,
    0 0 calc(40px * v-bind(sizeMultiplier)) rgba(59, 130, 246, 0.4),
    inset 0 0 calc(10px * v-bind(sizeMultiplier)) rgba(255, 255, 255, 0.2);
  animation: core-pulse 2.5s ease-in-out infinite;
  z-index: 2;
}

.particle {
  position: absolute;
  width: calc(10px * v-bind(sizeMultiplier));
  height: calc(10px * v-bind(sizeMultiplier));
  border-radius: 50%;
  background: linear-gradient(45deg, #60a5fa, #a78bfa);
  box-shadow: 0 0 calc(8px * v-bind(sizeMultiplier)) #a78bfa;
  animation-duration: 3s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
}

.particle-1 {
  animation-name: orbit-1;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
}

.particle-2 {
  animation-name: orbit-2;
  top: 25%;
  right: 0;
}

.particle-3 {
  animation-name: orbit-3;
  bottom: 25%;
  right: 0;
}

.particle-4 {
  animation-name: orbit-4;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
}

.particle-5 {
  animation-name: orbit-5;
  bottom: 25%;
  left: 0;
}

.particle-6 {
  animation-name: orbit-6;
  top: 25%;
  left: 0;
}

/* Loading Text */
.loading-text {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  font-size: calc(1.25rem * v-bind(sizeMultiplier));
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 2px;
}

.text-gradient {
  background: linear-gradient(90deg, #60a5fa, #a78bfa, #60a5fa);
  background-size: 200% 100%;
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: text-shimmer 3s ease-in-out infinite;
}

.dots {
  display: inline-flex;
}

.dot {
  color: #a78bfa;
  animation: dot-bounce 1.4s ease-in-out infinite both;
}

.dot:nth-child(1) { animation-delay: -0.32s; }
.dot:nth-child(2) { animation-delay: -0.16s; }
.dot:nth-child(3) { animation-delay: 0s; }

/* Progress Bar */
.progress-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
  width: calc(200px * v-bind(sizeMultiplier));
}

.progress-track {
  width: 100%;
  height: calc(6px * v-bind(sizeMultiplier));
  background: rgba(255, 255, 255, 0.1);
  border-radius: 3px;
  overflow: hidden;
  position: relative;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #3b82f6, #8b5cf6, #3b82f6);
  background-size: 200% 100%;
  border-radius: 3px;
  transition: width 0.5s ease;
  animation: progress-shimmer 2s linear infinite;
  position: relative;
  overflow: hidden;
}

.progress-glow {
  position: absolute;
  top: 0;
  left: -100%;
  width: 50%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
  animation: progress-glow 2s ease-in-out infinite;
}

.progress-text {
  font-family: 'Inter', monospace;
  font-size: calc(0.875rem * v-bind(sizeMultiplier));
  color: #d1d5db;
  font-weight: 500;
}

/* Background Elements */
.background-elements {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 1;
  overflow: hidden;
}

.bg-grid {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: 
    linear-gradient(rgba(59, 130, 246, 0.1) 1px, transparent 1px),
    linear-gradient(90deg, rgba(59, 130, 246, 0.1) 1px, transparent 1px);
  background-size: 40px 40px;
  opacity: 0.3;
  animation: grid-move 20s linear infinite;
}

.bg-glow {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 300px;
  height: 300px;
  background: radial-gradient(ellipse at center, rgba(59, 130, 246, 0.15) 0%, transparent 70%);
  filter: blur(20px);
  animation: glow-pulse 4s ease-in-out infinite alternate;
}

/* Animations */
@keyframes core-pulse {
  0%, 100% { 
    transform: scale(1);
    box-shadow: 
      0 0 calc(20px * v-bind(sizeMultiplier)) #3b82f6,
      0 0 calc(40px * v-bind(sizeMultiplier)) rgba(59, 130, 246, 0.4),
      inset 0 0 calc(10px * v-bind(sizeMultiplier)) rgba(255, 255, 255, 0.2);
  }
  50% { 
    transform: scale(1.1);
    box-shadow: 
      0 0 calc(30px * v-bind(sizeMultiplier)) #3b82f6,
      0 0 calc(60px * v-bind(sizeMultiplier)) rgba(59, 130, 246, 0.6),
      inset 0 0 calc(15px * v-bind(sizeMultiplier)) rgba(255, 255, 255, 0.3);
  }
}

@keyframes orbit-1 {
  0% { transform: translateX(-50%) rotate(0deg) translateY(calc(-50px * v-bind(sizeMultiplier))) rotate(0deg); }
  100% { transform: translateX(-50%) rotate(360deg) translateY(calc(-50px * v-bind(sizeMultiplier))) rotate(-360deg); }
}

@keyframes orbit-2 {
  0% { transform: rotate(0deg) translateX(calc(50px * v-bind(sizeMultiplier))) rotate(0deg); }
  100% { transform: rotate(360deg) translateX(calc(50px * v-bind(sizeMultiplier))) rotate(-360deg); }
}

@keyframes orbit-3 {
  0% { transform: rotate(0deg) translateX(calc(50px * v-bind(sizeMultiplier))) rotate(0deg); }
  100% { transform: rotate(360deg) translateX(calc(50px * v-bind(sizeMultiplier))) rotate(-360deg); }
}

@keyframes orbit-4 {
  0% { transform: translateX(-50%) rotate(0deg) translateY(calc(50px * v-bind(sizeMultiplier))) rotate(0deg); }
  100% { transform: translateX(-50%) rotate(360deg) translateY(calc(50px * v-bind(sizeMultiplier))) rotate(-360deg); }
}

@keyframes orbit-5 {
  0% { transform: rotate(0deg) translateX(calc(-50px * v-bind(sizeMultiplier))) rotate(0deg); }
  100% { transform: rotate(360deg) translateX(calc(-50px * v-bind(sizeMultiplier))) rotate(-360deg); }
}

@keyframes orbit-6 {
  0% { transform: rotate(0deg) translateX(calc(-50px * v-bind(sizeMultiplier))) rotate(0deg); }
  100% { transform: rotate(360deg) translateX(calc(-50px * v-bind(sizeMultiplier))) rotate(-360deg); }
}

@keyframes text-shimmer {
  0% { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}

@keyframes dot-bounce {
  0%, 80%, 100% {
    transform: translateY(0);
    opacity: 0.7;
  }
  40% {
    transform: translateY(calc(-5px * v-bind(sizeMultiplier)));
    opacity: 1;
  }
}

@keyframes progress-shimmer {
  0% { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}

@keyframes progress-glow {
  0% { left: -100%; }
  100% { left: 200%; }
}

@keyframes grid-move {
  0% { transform: translate(0, 0); }
  100% { transform: translate(40px, 40px); }
}

@keyframes glow-pulse {
  0% { opacity: 0.5; transform: translate(-50%, -50%) scale(1); }
  100% { opacity: 0.8; transform: translate(-50%, -50%) scale(1.1); }
}

/* Responsive */
@media (max-width: 768px) {
  .quantum-loader {
    width: 80px;
    height: 80px;
  }
  
  .loading-text {
    font-size: 1rem;
  }
  
  .progress-container {
    width: 180px;
  }
}
</style>