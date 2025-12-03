<script setup>
</script>

<template>
  <div>
    <section id="howItsWork" class="how-it-works-section">
      <div class="container-fluid px-0">
        <div class="section-header text-center">
          <div class="section-badge">Process</div>
          <h1 class="section-title">
            How It <span class="gradient-text">Works?</span>
          </h1>
          <p class="section-subtitle">
            Simple steps to reconnect lost items with their owners
          </p>
        </div>

        <div class="container custom-container">
          <div class="process-wrapper">
            <!-- Connecting Line -->
            <div class="process-line"></div>
            
            <div class="row justify-content-center card-group g-4">
              <!-- Step 1 -->
              <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                <div class="process-card text-center">
                  <div class="card-step-number">01</div>
                  <div class="card-icon-wrapper">
                    <div class="card-icon">
                      <img src="../../../images/announce.svg" alt="Report Lost Item" />
                    </div>
                    <div class="icon-glow"></div>
                  </div>
                  <h3 class="card-title">Report a Lost Item</h3>
                  <p class="card-description">
                    Post details about your missing item, including a description,
                    last known location, and contact information.
                  </p>
                  <div class="card-hover-effect"></div>
                </div>
              </div>

              <!-- Step 2 -->
              <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                <div class="process-card text-center">
                  <div class="card-step-number">02</div>
                  <div class="card-icon-wrapper">
                    <div class="card-icon">
                      <img src="../../../images/found.svg" alt="Report Found Item" />
                    </div>
                    <div class="icon-glow"></div>
                  </div>
                  <h3 class="card-title">Report a Found Item</h3>
                  <p class="card-description">
                    Post details of what you found to help the rightful owner
                    claim their lost property.
                  </p>
                  <div class="card-hover-effect"></div>
                </div>
              </div>

              <!-- Step 3 -->
              <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                <div class="process-card text-center">
                  <div class="card-step-number">03</div>
                  <div class="card-icon-wrapper">
                    <div class="card-icon">
                      <img src="../../../images/brows.svg" alt="Browse Listings" />
                    </div>
                    <div class="icon-glow"></div>
                  </div>
                  <h3 class="card-title">Browse Listings</h3>
                  <p class="card-description">
                    Check listings to see if your item has been found or if someone
                    is looking for what you found.
                  </p>
                  <div class="card-hover-effect"></div>
                </div>
              </div>

              <!-- Step 4 -->
              <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                <div class="process-card text-center">
                  <div class="card-step-number">04</div>
                  <div class="card-icon-wrapper">
                    <div class="card-icon">
                      <img src="../../../images/claim.svg" alt="Reclaim Items" />
                    </div>
                    <div class="icon-glow"></div>
                  </div>
                  <h3 class="card-title">Reclaim Items</h3>
                  <p class="card-description">
                    Contact the admin (PNP) and arrange the return once an item matches.
                  </p>
                  <div class="card-hover-effect"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<style scoped>
.how-it-works-section {
  background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
  padding: 6rem 0;
  position: relative;
  overflow: hidden;
}

.how-it-works-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    radial-gradient(circle at 20% 80%, rgba(102, 126, 234, 0.05) 0%, transparent 50%),
    radial-gradient(circle at 80% 20%, rgba(245, 87, 108, 0.05) 0%, transparent 50%);
  pointer-events: none;
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

.process-wrapper {
  position: relative;
}

.process-line {
  position: absolute;
  top: 120px;
  left: 10%;
  right: 10%;
  height: 2px;
  background: linear-gradient(90deg, transparent, #667eea, #764ba2, transparent);
  z-index: 1;
  opacity: 0.3;
}

.process-card {
  position: relative;
  padding: 3rem 1.5rem 2rem;
  border-radius: 20px;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 
    0 10px 30px rgba(0, 0, 0, 0.05),
    0 1px 0 rgba(255, 255, 255, 0.8) inset;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  z-index: 2;
  overflow: hidden;
}

.process-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(45deg, #667eea, #764ba2);
  transform: scaleX(0);
  transition: transform 0.4s ease;
}

.card-step-number {
  position: absolute;
  top: 1rem;
  left: 1.5rem;
  font-size: 0.875rem;
  font-weight: 700;
  color: #667eea;
  opacity: 0.7;
}

.card-icon-wrapper {
  position: relative;
  width: 100px;
  height: 100px;
  margin: 0 auto 1.5rem;
}

.card-icon {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  z-index: 2;
  transition: all 0.4s ease;
  box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
}

.card-icon img {
  width: 50%;
  height: auto;
  filter: brightness(0) invert(1);
}

.icon-glow {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 120px;
  height: 120px;
  background: linear-gradient(45deg, #667eea, #764ba2);
  border-radius: 50%;
  opacity: 0.1;
  animation: pulse-glow 2s ease-in-out infinite;
}

.card-title {
  font-size: 1.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: #2d3748;
  transition: color 0.3s ease;
}

.card-description {
  color: #64748b;
  line-height: 1.6;
  margin-bottom: 0;
}

.card-hover-effect {
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(45deg, transparent, rgba(102, 126, 234, 0.05), transparent);
  transition: left 0.6s ease;
}

/* Hover Effects */
.card-group:hover .process-card {
  transform: translateY(-5px);
  filter: brightness(0.95);
}

.card-group .process-card:hover {
  transform: translateY(-10px) scale(1.02);
  filter: brightness(1);
  box-shadow: 
    0 25px 50px rgba(0, 0, 0, 0.1),
    0 15px 30px rgba(102, 126, 234, 0.2);
}

.card-group .process-card:hover::before {
  transform: scaleX(1);
}

.card-group .process-card:hover .card-icon {
  transform: scale(1.1) rotate(5deg);
  box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
}

.card-group .process-card:hover .card-hover-effect {
  left: 100%;
}

.card-group .process-card:hover .card-title {
  background: linear-gradient(45deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* Animations */
@keyframes gradient-shift {
  0%, 100% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
}

@keyframes pulse-glow {
  0%, 100% { 
    transform: translate(-50%, -50%) scale(1);
    opacity: 0.1;
  }
  50% { 
    transform: translate(-50%, -50%) scale(1.1);
    opacity: 0.15;
  }
}

/* Responsive Design */
@media (max-width: 1200px) {
  .section-title {
    font-size: 3rem;
  }
  
  .process-line {
    display: none;
  }
}

@media (max-width: 992px) {
  .how-it-works-section {
    padding: 4rem 0;
  }
  
  .section-title {
    font-size: 2.5rem;
  }
  
  .section-header {
    margin-bottom: 3rem;
  }
  
  .card-icon-wrapper {
    width: 80px;
    height: 80px;
  }
  
  .icon-glow {
    width: 100px;
    height: 100px;
  }
}

@media (max-width: 768px) {
  .section-title {
    font-size: 2rem;
  }
  
  .section-subtitle {
    font-size: 1.125rem;
  }
  
  .process-card {
    padding: 2rem 1rem 1.5rem;
  }
  
  .card-title {
    font-size: 1.25rem;
  }
}

@media (max-width: 576px) {
  .how-it-works-section {
    padding: 3rem 0;
  }
  
  .section-title {
    font-size: 1.75rem;
  }
  
  .section-badge {
    font-size: 0.75rem;
    padding: 0.4rem 1rem;
  }
  
  .card-icon-wrapper {
    width: 70px;
    height: 70px;
  }
  
  .icon-glow {
    width: 90px;
    height: 90px;
  }
}

/* Reduced motion for accessibility */
@media (prefers-reduced-motion: reduce) {
  .process-card,
  .card-icon,
  .icon-glow,
  .gradient-text {
    animation: none;
    transition: none;
  }
  
  .card-group:hover .process-card,
  .card-group .process-card:hover {
    transform: none;
  }
  
  .card-hover-effect {
    display: none;
  }
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
  .how-it-works-section {
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
  
  .process-card {
    background: rgba(45, 55, 72, 0.8);
    border: 1px solid rgba(74, 85, 104, 0.3);
  }
  
  .card-title {
    color: #e2e8f0;
  }
  
  .card-description {
    color: #a0aec0;
  }
}
</style>