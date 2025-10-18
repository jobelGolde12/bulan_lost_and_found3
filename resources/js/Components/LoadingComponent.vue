<template>
  <!-- Modern Loading Modal -->
  <div
    class="modern-loading-modal"
    :class="{ 'dark-mode': isDarkMode }"
    aria-labelledby="loadingTitle"
    aria-hidden="false"
  >
    <div class="modal-backdrop"></div>
    
    <div class="modal-container">
      <div class="modal-content">
        <!-- Animated Logo/Brand -->
        <div class="brand-container">
          <div class="brand-icon">
            <div class="icon-shape"></div>
          </div>
        </div>
        
        <!-- Loading Content -->
        <div class="loading-content">
          <h2 class="loading-title" id="loadingTitle">Loading</h2>
          <p class="loading-subtitle">Please wait while we process your request</p>
          
          <!-- Modern Loader -->
          <div class="modern-loader">
            <div class="loader-track">
              <div class="loader-progress"></div>
            </div>
            <div class="loader-dots">
              <div class="dot dot-1"></div>
              <div class="dot dot-2"></div>
              <div class="dot dot-3"></div>
            </div>
          </div>
        </div>
        
        <!-- Optional Action -->
        <!-- <div class="action-container">
          <button class="action-btn" @click="$emit('cancel')">
            <span>Cancel</span>
          </button>
        </div> -->
      </div>
    </div>
    
    <!-- Theme Toggle -->
    <button class="theme-toggle" @click="toggleDarkMode" :aria-label="isDarkMode ? 'Switch to light mode' : 'Switch to dark mode'">
      <div class="toggle-track">
        <div class="toggle-thumb">
          <i class="bi" :class="isDarkMode ? 'bi-moon' : 'bi-sun'"></i>
        </div>
      </div>
    </button>
  </div>
</template>

<script setup>
import { ref } from "vue";

const isDarkMode = ref(false);

const toggleDarkMode = () => {
  isDarkMode.value = !isDarkMode.value;
};

defineEmits(['close', 'cancel']);
</script>

<style scoped>
.modern-loading-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
}

.modal-backdrop {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.4);
  transition: all 0.4s ease;
  z-index: 1;
}

.dark-mode .modal-backdrop {
  background: rgba(0, 0, 0, 0.6);
}

.modal-container {
  position: relative;
  width: 90%;
  max-width: 400px;
  z-index: 1001;
  animation: modalAppear 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.modal-content {
  background: white;
  border-radius: 24px;
  padding: 2.5rem 2rem;
  box-shadow: 
    0 25px 50px rgba(0, 0, 0, 0.15),
    0 5px 15px rgba(0, 0, 0, 0.1);
  text-align: center;
  position: relative;
  overflow: hidden;
}

.modal-content::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, #667eea, #764ba2);
}

.dark-mode .modal-content {
  background: #1a202c;
  box-shadow: 
    0 25px 50px rgba(0, 0, 0, 0.4),
    0 5px 15px rgba(0, 0, 0, 0.3);
}

.dark-mode .modal-content::before {
  background: linear-gradient(90deg, #4fd1c7, #4299e1);
}

/* Brand/Logo Animation */
.brand-container {
  margin-bottom: 1.5rem;
}

.brand-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 60px;
  height: 60px;
  border-radius: 16px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  animation: brandPulse 2s ease-in-out infinite;
}

.icon-shape {
  width: 24px;
  height: 24px;
  background: white;
  border-radius: 6px;
  transform: rotate(45deg);
}

.dark-mode .brand-icon {
  background: linear-gradient(135deg, #4fd1c7 0%, #4299e1 100%);
}

/* Loading Content */
.loading-content {
  margin-bottom: 2rem;
}

.loading-title {
  font-size: 1.75rem;
  font-weight: 700;
  margin: 0 0 0.5rem 0;
  color: #2d3748;
}

.dark-mode .loading-title {
  color: #f7fafc;
}

.loading-subtitle {
  color: #718096;
  font-size: 0.95rem;
  margin: 0 0 2rem 0;
  line-height: 1.5;
}

.dark-mode .loading-subtitle {
  color: #a0aec0;
}

/* Modern Loader */
.modern-loader {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  align-items: center;
}

.loader-track {
  width: 100%;
  height: 6px;
  background: #e2e8f0;
  border-radius: 3px;
  overflow: hidden;
  position: relative;
}

.dark-mode .loader-track {
  background: #4a5568;
}

.loader-progress {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 45%;
  background: linear-gradient(90deg, #667eea, #764ba2);
  border-radius: 3px;
  animation: progressAnimation 2s ease-in-out infinite;
}

.dark-mode .loader-progress {
  background: linear-gradient(90deg, #4fd1c7, #4299e1);
}

.loader-dots {
  display: flex;
  gap: 8px;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #cbd5e0;
  animation: dotsPulse 1.4s ease-in-out infinite both;
}

.dark-mode .dot {
  background: #718096;
}

.dot-1 { animation-delay: -0.32s; }
.dot-2 { animation-delay: -0.16s; }
.dot-3 { animation-delay: 0s; }

/* Action Button */
.action-container {
  margin-top: 1rem;
}

.action-btn {
  background: transparent;
  border: 1.5px solid #e2e8f0;
  color: #718096;
  padding: 0.75rem 1.5rem;
  border-radius: 12px;
  font-size: 0.9rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.action-btn:hover {
  background: #667eea;
  border-color: #667eea;
  color: white;
  transform: translateY(-1px);
}

.dark-mode .action-btn {
  border-color: #4a5568;
  color: #a0aec0;
}

.dark-mode .action-btn:hover {
  background: #4fd1c7;
  border-color: #4fd1c7;
  color: #1a202c;
}

/* Theme Toggle */
.theme-toggle {
  position: fixed;
  bottom: 2rem;
  right: 2rem;
  background: white;
  border: 1px solid #e2e8f0;
  border-radius: 50px;
  padding: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  z-index: 1002;
}

.theme-toggle:hover {
  transform: scale(1.1);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

.dark-mode .theme-toggle {
  background: #2d3748;
  border-color: #4a5568;
}

.toggle-track {
  position: relative;
  width: 40px;
  height: 20px;
}

.toggle-thumb {
  position: absolute;
  top: 0;
  left: 0;
  width: 20px;
  height: 20px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 0.7rem;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.dark-mode .toggle-thumb {
  transform: translateX(20px);
  background: linear-gradient(135deg, #4fd1c7, #4299e1);
}

/* Animations */
@keyframes modalAppear {
  0% {
    opacity: 0;
    transform: scale(0.8) translateY(20px);
  }
  100% {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

@keyframes brandPulse {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
}

@keyframes progressAnimation {
  0% {
    left: -45%;
  }
  100% {
    left: 100%;
  }
}

@keyframes dotsPulse {
  0%, 80%, 100% {
    transform: scale(0.8);
    opacity: 0.5;
  }
  40% {
    transform: scale(1);
    opacity: 1;
  }
}

/* Responsive Design */
@media (max-width: 480px) {
  .modal-container {
    width: 95%;
    max-width: 320px;
  }
  
  .modal-content {
    padding: 2rem 1.5rem;
  }
  
  .loading-title {
    font-size: 1.5rem;
  }
  
  .theme-toggle {
    bottom: 1rem;
    right: 1rem;
  }
}

/* Reduced motion support */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
</style>