<script setup>
</script>

<template>
  <div class="map-section">
    <div class="container-fluid">
      <!-- Section Header -->
      <div class="section-header text-center">
        <div class="section-badge">Interactive Map</div>
        <h1 class="section-title">
          Bulan, Sorsogon <span class="gradient-text">Lost and Found</span> Map
        </h1>
        <p class="section-subtitle">
          Discover reported lost and found items across our community
        </p>
      </div>

      <!-- Content Layout -->
      <div class="map-content-wrapper">
        <!-- Info Panel -->
        <div class="info-panel">
          <div class="panel-header">
            <div class="header-icon">
              <i class="bi bi-geo-alt-fill"></i>
            </div>
            <h2>Find Lost & Found Locations</h2>
          </div>
          
          <div class="panel-body">
            <p class="intro-text">
              This map displays locations in <strong>Bulan, Sorsogon</strong> where lost or found items have been reported by members of the community.
            </p>
            <p class="intro-text">
              Use it to trace back where you might have lost something or to help return found items to their rightful owners.
            </p>

            <div class="features-list">
              <div class="feature-item">
                <div class="feature-icon">
                  <i class="bi bi-search"></i>
                </div>
                <div class="feature-content">
                  <h4>Zoom In</h4>
                  <p>Explore specific barangays and streets in detail</p>
                </div>
              </div>

              <div class="feature-item">
                <div class="feature-icon">
                  <i class="bi bi-geo-alt"></i>
                </div>
                <div class="feature-content">
                  <h4>Check Markers</h4>
                  <p>View reported items with detailed information</p>
                </div>
              </div>

              <div class="feature-item">
                <div class="feature-icon">
                  <i class="bi bi-upload"></i>
                </div>
                <div class="feature-content">
                  <h4>Contribute</h4>
                  <p>Submit new reports to help the community</p>
                </div>
              </div>
            </div>

            <div class="stats-grid">
              <div class="stat-item">
                <div class="stat-number">100+</div>
                <div class="stat-label">Items Reported</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">80%</div>
                <div class="stat-label">Success Rate</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">24/7</div>
                <div class="stat-label">Available</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Map Panel -->
        <div class="map-panel">
          <div class="map-container">
            <div class="map-frame-wrapper">
              <iframe
                src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d62340.82818489969!2d123.8915112!3d12.6692278!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33a0d168a6bcb5a3%3A0x24c94298cb5be0b6!2sBulan%2C%20Sorsogon!5e0!3m2!1sen!2sph!4v1754210839383!5m2!1sen!2sph"
                width="100%"
                height="100%"
                style="border: 0"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"
                class="map-iframe"
              ></iframe>
            </div>
            <div class="map-overlay">
              <div class="map-controls">
                <button class="control-btn">
                  <i class="bi bi-plus"></i>
                </button>
                <button class="control-btn">
                  <i class="bi bi-dash"></i>
                </button>
                <button class="control-btn">
                  <i class="bi bi-geo"></i>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.map-section {
  background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
  padding: 6rem 0;
  position: relative;
  overflow: hidden;
}

.map-section::before {
  content: '';
  position: absolute;
  top: -50%;
  right: -20%;
  width: 600px;
  height: 600px;
  background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  opacity: 0.03;
  animation: float 6s ease-in-out infinite;
}

.section-header {
  margin-bottom: 4rem;
  position: relative;
  z-index: 2;
}

.section-badge {
  display: inline-block;
  background: linear-gradient(45deg, #667eea, #764ba2);
  color: white;
  padding: 0.5rem 1.5rem;
  border-radius: 50px;
  font-size: 0.875rem;
  font-weight: 600;
  letter-spacing: 0.5px;
  text-transform: uppercase;
  margin-bottom: 1rem;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.section-title {
  font-size: 3.5rem;
  font-weight: 800;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #2d3748 0%, #4a5568 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.gradient-text {
  background: linear-gradient(45deg, #667eea, #764ba2, #f093fb);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: gradient-shift 3s ease-in-out infinite;
}

.section-subtitle {
  font-size: 1.25rem;
  color: #64748b;
  max-width: 500px;
  margin: 0 auto;
}

.map-content-wrapper {
  display: grid;
  grid-template-columns: 1fr 1.2fr;
  gap: 3rem;
  align-items: start;
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 2rem;
  position: relative;
  z-index: 2;
}

/* Info Panel Styles */
.info-panel {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border-radius: 24px;
  padding: 2.5rem;
  box-shadow: 
    0 20px 40px rgba(0, 0, 0, 0.1),
    0 8px 24px rgba(0, 0, 0, 0.08),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
}

.info-panel:hover {
  transform: translateY(-5px);
  box-shadow: 
    0 25px 50px rgba(0, 0, 0, 0.15),
    0 12px 30px rgba(0, 0, 0, 0.1);
}

.panel-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
}

.header-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(45deg, #667eea, #764ba2);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.5rem;
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
}

.panel-header h2 {
  font-size: 1.75rem;
  font-weight: 700;
  color: #2d3748;
  margin: 0;
}

.intro-text {
  color: #64748b;
  line-height: 1.7;
  margin-bottom: 1.5rem;
  font-size: 1.1rem;
}

.features-list {
  margin: 2.5rem 0;
}

.feature-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1.5rem;
  margin-bottom: 1rem;
  background: rgba(248, 250, 252, 0.8);
  border-radius: 16px;
  border-left: 4px solid #667eea;
  transition: all 0.3s ease;
}

.feature-item:hover {
  background: rgba(102, 126, 234, 0.05);
  transform: translateX(5px);
}

.feature-icon {
  width: 50px;
  height: 50px;
  background: linear-gradient(45deg, #667eea, #764ba2);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.25rem;
  flex-shrink: 0;
}

.feature-content h4 {
  margin: 0 0 0.5rem 0;
  font-weight: 600;
  color: #2d3748;
}

.feature-content p {
  margin: 0;
  color: #64748b;
  font-size: 0.95rem;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
  margin-top: 2rem;
}

.stat-item {
  text-align: center;
  padding: 1.5rem 1rem;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 16px;
  color: white;
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
}

.stat-number {
  font-size: 1.5rem;
  font-weight: 800;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 0.875rem;
  opacity: 0.9;
}

/* Map Panel Styles */
.map-panel {
  position: relative;
}

.map-container {
  position: relative;
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 
    0 25px 50px rgba(0, 0, 0, 0.15),
    0 12px 30px rgba(0, 0, 0, 0.1);
  transform: perspective(1000px) rotateY(-2deg) rotateX(2deg);
  transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.map-container:hover {
  transform: perspective(1000px) rotateY(0deg) rotateX(0deg) scale(1.02);
}

.map-frame-wrapper {
  width: 100%;
  height: 600px;
  border-radius: 24px;
  overflow: hidden;
}

.map-iframe {
  width: 100%;
  height: 100%;
  border: none;
}

.map-overlay {
  position: absolute;
  top: 1rem;
  right: 1rem;
  pointer-events: none;
}

.map-controls {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  pointer-events: auto;
}

.control-btn {
  width: 45px;
  height: 45px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border: none;
  border-radius: 12px;
  color: #2d3748;
  font-size: 1.1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.control-btn:hover {
  background: #667eea;
  color: white;
  transform: scale(1.1);
}

/* Animations */
@keyframes float {
  0%, 100% { transform: translateY(0px) rotate(0deg); }
  50% { transform: translateY(-20px) rotate(180deg); }
}

@keyframes gradient-shift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

/* Responsive Design */
@media (max-width: 1200px) {
  .section-title {
    font-size: 3rem;
  }
  
  .map-content-wrapper {
    gap: 2rem;
    padding: 0 1.5rem;
  }
}

@media (max-width: 992px) {
  .map-section {
    padding: 4rem 0;
  }
  
  .section-title {
    font-size: 2.5rem;
  }
  
  .map-content-wrapper {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .map-container {
    transform: none;
  }
  
  .map-container:hover {
    transform: scale(1.01);
  }
}

@media (max-width: 768px) {
  .section-title {
    font-size: 2rem;
  }
  
  .section-subtitle {
    font-size: 1.125rem;
  }
  
  .info-panel {
    padding: 2rem 1.5rem;
  }
  
  .panel-header {
    flex-direction: column;
    text-align: center;
    gap: 1rem;
  }
  
  .stats-grid {
    grid-template-columns: 1fr;
  }
  
  .map-frame-wrapper {
    height: 400px;
  }
}

@media (max-width: 576px) {
  .map-section {
    padding: 3rem 0;
  }
  
  .section-title {
    font-size: 1.75rem;
  }
  
  .section-badge {
    font-size: 0.75rem;
    padding: 0.4rem 1rem;
  }
  
  .info-panel {
    padding: 1.5rem 1rem;
    border-radius: 20px;
  }
  
  .feature-item {
    flex-direction: column;
    text-align: center;
    gap: 1rem;
  }
  
  .map-frame-wrapper {
    height: 350px;
  }
}

/* Reduced motion for accessibility */
@media (prefers-reduced-motion: reduce) {
  .map-container,
  .info-panel,
  .feature-item,
  .control-btn,
  .gradient-text {
    animation: none;
    transition: none;
    transform: none;
  }
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
  .map-section {
    background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
  }
  
  .section-title {
    background: linear-gradient(135deg, #e2e8f0 0%, #cbd5e0 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }
  
  .section-subtitle {
    color: #a0aec0;
  }
  
  .info-panel {
    background: rgba(45, 55, 72, 0.9);
    border: 1px solid rgba(74, 85, 104, 0.3);
  }
  
  .panel-header h2 {
    color: #e2e8f0;
  }
  
  .intro-text {
    color: #a0aec0;
  }
  
  .feature-item {
    background: rgba(74, 85, 104, 0.3);
  }
  
  .feature-content h4 {
    color: #e2e8f0;
  }
  
  .feature-content p {
    color: #a0aec0;
  }
  
  .control-btn {
    background: rgba(45, 55, 72, 0.95);
    color: #e2e8f0;
  }
}
</style>