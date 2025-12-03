<template>
  <Head title="About Us" />
  <div class="main-container">
    <!-- Navbar -->
    <nav class="navbar">
      <div class="nav-container container-fluid d-flex justify-content-between">
        <div class="logo">
          <img :src="lostAndFoundLogo" alt="Application logo" />
        </div>
        <div class="nav-links">
          <Link href="/" class="nav-link">Home</Link>
          <Link :href="route('login')" class="nav-link">Login</Link>
          <Link :href="route('register')" class="nav-btn">Sign Up</Link>
        </div>
        <div class="mobile-menu-btn" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu">
          <div class="hamburger">
            <span></span>
            <span></span>
            <span></span>
          </div>
        </div>
      </div>
    </nav>

    <!-- Offcanvas Menu -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasMenu">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title">Menu</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
        <Link href="/" class="mobile-nav-link">Home</Link>
        <Link :href="route('login')" class="mobile-nav-link">Login</Link>
        <Link :href="route('register')" class="mobile-nav-btn">Sign Up</Link>
      </div>
    </div>

    <!-- Hero Section -->
    <section class="hero-section">
      <div class="hero-container">
        <div class="hero-content">
          <div class="hero-text">
            <h1 class="hero-title">Reuniting People with Their <span class="gradient-text">Lost Treasures</span></h1>
            <p class="hero-subtitle">A modern, secure platform connecting the community of Bulan, Sorsogon to recover what matters most.</p>
            <div class="hero-stats">
              <div class="stat">
                <div class="stat-number">500+</div>
                <div class="stat-label">Items Reunited</div>
              </div>
              <div class="stat">
                <div class="stat-number">98%</div>
                <div class="stat-label">Success Rate</div>
              </div>
              <div class="stat">
                <div class="stat-number">24/7</div>
                <div class="stat-label">Platform Access</div>
              </div>
            </div>
          </div>
          <div class="hero-visual">
            <div class="floating-card card-1">
              <div class="card-icon">📱</div>
              <p>Easy Reporting</p>
            </div>
            <div class="floating-card card-2">
              <div class="card-icon">🔒</div>
              <p>Secure Platform</p>
            </div>
            <img :src="hero" class="hero-image" alt="Hero illustration" />
          </div>
        </div>
      </div>
    </section>

    <!-- Mission Section -->
    <section class="mission-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">Our Mission</h2>
          <p class="section-subtitle">Building bridges between lost items and their owners through technology and community</p>
        </div>
        <div class="mission-grid">
          <div class="mission-content">
            <h3>Connecting What's Lost with Who's Looking</h3>
            <p>We've created an intelligent platform that simplifies the process of recovering lost belongings while maintaining the highest standards of security and privacy.</p>
            <div class="mission-features">
              <div class="feature">
                <div class="feature-icon">🚀</div>
                <div class="feature-text">
                  <h4>Instant Reporting</h4>
                  <p>Report lost or found items in seconds</p>
                </div>
              </div>
              <div class="feature">
                <div class="feature-icon">🌐</div>
                <div class="feature-text">
                  <h4>Community Powered</h4>
                  <p>Leveraging local networks for faster recovery</p>
                </div>
              </div>
            </div>
          </div>
          <div class="mission-visual">
            <img :src="connection" class="mission-image" alt="Connection illustration" />
          </div>
        </div>
      </div>
    </section>

    <!-- How It Works Section -->
    <section class="works-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title">How It Works</h2>
          <p class="section-subtitle">Simple steps to recover lost items</p>
        </div>
        <div class="works-grid">
          <div class="works-visual">
            <img :src="dataReport" class="works-image" alt="Data Reports illustration" />
          </div>
          <div class="works-content">
            <div class="steps">
              <div class="step">
                <div class="step-number">1</div>
                <div class="step-content">
                  <h4>Report</h4>
                  <p>Easily report lost or found items through our intuitive platform</p>
                </div>
              </div>
              <div class="step">
                <div class="step-number">2</div>
                <div class="step-content">
                  <h4>Browse</h4>
                  <p>Search through all posted listings to find matches</p>
                </div>
              </div>
              <div class="step">
                <div class="step-number">3</div>
                <div class="step-content">
                  <h4>Connect</h4>
                  <p>Securely communicate with owners, finders, or <span class="highlight">PNP</span></p>
                </div>
              </div>
              <div class="step">
                <div class="step-number">4</div>
                <div class="step-content">
                  <h4>Retrieve</h4>
                  <p>Coordinate item retrieval at designated safe locations</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Security Section -->
    <section class="security-section">
      <div class="container">
        <div class="security-content">
          <div class="security-header">
            <h2>Privacy & Security First</h2>
            <p class="security-subtitle">Your safety and privacy are our top priorities</p>
          </div>
          <div class="security-features">
            <div class="security-feature">
              <div class="security-icon">🔐</div>
              <h4>Encrypted Communication</h4>
              <p>All messages and data are securely encrypted</p>
            </div>
            <div class="security-feature">
              <div class="security-icon">👁️</div>
              <h4>Privacy Control</h4>
              <p>You control what information is shared</p>
            </div>
            <div class="security-feature">
              <div class="security-icon">🛡️</div>
              <h4>Verified Users</h4>
              <p>Community verification for trusted interactions</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="container">
        <div class="cta-content">
          <h2>Ready to Get Started?</h2>
          <p>Join our community today and help make Bulan a place where lost items always find their way home.</p>
          <div class="cta-buttons">
            <Link :href="route('register')" class="cta-btn primary">Sign Up Free</Link>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <WelcomeFooter />
  </div>
</template>

<script setup>
import { Head, Link } from "@inertiajs/vue3";
import lostAndFoundLogo from "../../images/lost_and_found_logo.png";
import hero from "../../images/aboutUs/hero.svg";
import connection from "../../images/aboutUs/connection.svg";
import dataReport from "../../images/aboutUs/data-reports.svg";
import WelcomeFooter from "@/Components/welcome_page/WelcomeFooter.vue";
</script>

<style scoped>
.main-container {
  font-family: 'Inter', 'Poppins', sans-serif;
  color: #1a1a1a;
}

/* Navbar Styles */
.navbar {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  padding: 1rem 0;
  position: fixed;
  top: 0;
  width: 100%;
  z-index: 1000;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.logo img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.nav-links {
  display: none;
  align-items: center;
  gap: 2rem;
}

.nav-link {
  color: #1a1a1a;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s ease;
  position: relative;
}

.nav-link:hover {
  color: #6366f1;
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: -5px;
  left: 0;
  width: 0;
  height: 2px;
  background: linear-gradient(90deg, #6366f1, #8b5cf6);
  transition: width 0.3s ease;
}

.nav-link:hover::after {
  width: 100%;
}

.nav-btn {
  background: linear-gradient(135deg, #6366f1, #8b5cf6);
  color: white;
  padding: 0.75rem 1.5rem;
  border-radius: 50px;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
}

.nav-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
  color: white;
}

.mobile-menu-btn {
  display: block;
  cursor: pointer;
}

.hamburger span {
  display: block;
  width: 25px;
  height: 3px;
  background: #1a1a1a;
  margin: 5px 0;
  transition: 0.3s;
  border-radius: 2px;
}

/* Offcanvas Styles */
.offcanvas {
  background: rgba(255, 255, 255, 0.98);
  backdrop-filter: blur(20px);
}

.mobile-nav-link {
  display: block;
  padding: 1rem 0;
  color: #1a1a1a;
  text-decoration: none;
  font-weight: 500;
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  transition: color 0.3s ease;
}

.mobile-nav-link:hover {
  color: #6366f1;
}

.mobile-nav-btn {
  display: block;
  background: linear-gradient(135deg, #6366f1, #8b5cf6);
  color: white;
  padding: 1rem;
  border-radius: 12px;
  text-decoration: none;
  font-weight: 600;
  text-align: center;
  margin-top: 1rem;
  transition: transform 0.3s ease;
}

.mobile-nav-btn:hover {
  transform: translateY(-2px);
  color: white;
}

/* Hero Section */
.hero-section {
  padding: 120px 0 80px;
  background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
  position: relative;
  overflow: hidden;
}

.hero-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.hero-content {
  display: grid;
  grid-template-columns: 1fr;
  gap: 3rem;
  align-items: center;
}

.hero-title {
  font-size: 3rem;
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 1.5rem;
  background: linear-gradient(135deg, #1a1a1a 0%, #4b5563 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.gradient-text {
  background: linear-gradient(135deg, #6366f1, #8b5cf6);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: 1.25rem;
  color: #64748b;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.hero-stats {
  display: flex;
  gap: 2rem;
  margin-top: 2rem;
}

.stat {
  text-align: left;
}

.stat-number {
  font-size: 2rem;
  font-weight: 800;
  color: #6366f1;
  line-height: 1;
}

.stat-label {
  font-size: 0.875rem;
  color: #64748b;
  font-weight: 500;
}

.hero-visual {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
}

.hero-image {
  max-width: 100%;
  border-radius: 20px;
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
  transform: perspective(1000px) rotateY(-5deg) rotateX(5deg);
  transition: transform 0.5s ease;
}

.hero-image:hover {
  transform: perspective(1000px) rotateY(0deg) rotateX(0deg);
}

.floating-card {
  position: absolute;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  padding: 1rem;
  border-radius: 16px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  animation: float 3s ease-in-out infinite;
}

.card-1 {
  top: 20%;
  left: 10%;
  animation-delay: 0s;
}

.card-2 {
  bottom: 20%;
  right: 10%;
  animation-delay: 1.5s;
}

.card-icon {
  font-size: 1.5rem;
  margin-bottom: 0.5rem;
}

.floating-card p {
  margin: 0;
  font-weight: 600;
  font-size: 0.875rem;
  color: #1a1a1a;
}

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}

/* Section Common Styles */
.section-header {
  text-align: center;
  margin-bottom: 4rem;
}

.section-title {
  font-size: 2.5rem;
  font-weight: 800;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #1a1a1a 0%, #4b5563 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.section-subtitle {
  font-size: 1.125rem;
  color: #64748b;
  max-width: 600px;
  margin: 0 auto;
  line-height: 1.6;
}

/* Mission Section */
.mission-section {
  padding: 80px 0;
  background: white;
}

.mission-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 4rem;
  align-items: center;
}

.mission-content h3 {
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 1.5rem;
  color: #1a1a1a;
}

.mission-content p {
  font-size: 1.125rem;
  color: #64748b;
  line-height: 1.7;
  margin-bottom: 2rem;
}

.mission-features {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.feature {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
}

.feature-icon {
  font-size: 2rem;
  flex-shrink: 0;
}

.feature-text h4 {
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: #1a1a1a;
}

.feature-text p {
  margin: 0;
  color: #64748b;
  font-size: 1rem;
}

.mission-image {
  max-width: 100%;
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
}

/* Works Section */
.works-section {
  padding: 80px 0;
  background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
}

.works-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 4rem;
  align-items: center;
}

.works-image {
  max-width: 100%;
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
}

.steps {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.step {
  display: flex;
  align-items: flex-start;
  gap: 1.5rem;
  padding: 1.5rem;
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.step:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
}

.step-number {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, #6366f1, #8b5cf6);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 800;
  font-size: 1.25rem;
  flex-shrink: 0;
}

.step-content h4 {
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: #1a1a1a;
}

.step-content p {
  margin: 0;
  color: #64748b;
  line-height: 1.6;
}

.highlight {
  color: #10b981;
  font-weight: 600;
}

/* Security Section */
.security-section {
  padding: 80px 0;
  background: white;
}

.security-content {
  max-width: 800px;
  margin: 0 auto;
  text-align: center;
}

.security-header h2 {
  font-size: 2.5rem;
  font-weight: 800;
  margin-bottom: 1rem;
  background: linear-gradient(135deg, #1a1a1a 0%, #4b5563 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.security-subtitle {
  font-size: 1.125rem;
  color: #64748b;
  margin-bottom: 3rem;
}

.security-features {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
}

.security-feature {
  padding: 2rem;
  background: #f8fafc;
  border-radius: 16px;
  transition: transform 0.3s ease;
}

.security-feature:hover {
  transform: translateY(-5px);
}

.security-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.security-feature h4 {
  font-weight: 600;
  margin-bottom: 1rem;
  color: #1a1a1a;
}

.security-feature p {
  color: #64748b;
  line-height: 1.6;
  margin: 0;
}

/* CTA Section */
.cta-section {
  padding: 80px 0;
  background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
  color: white;
  text-align: center;
}

.cta-content h2 {
  font-size: 2.5rem;
  font-weight: 800;
  margin-bottom: 1rem;
}

.cta-content p {
  font-size: 1.125rem;
  margin-bottom: 2rem;
  opacity: 0.9;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
}

.cta-buttons {
  display: flex;
  gap: 1rem;
  justify-content: center;
  flex-wrap: wrap;
}

.cta-btn {
  padding: 1rem 2rem;
  border-radius: 50px;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
  border: 2px solid transparent;
}

.cta-btn.primary {
  background: white;
  color: #6366f1;
}

.cta-btn.primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 30px rgba(255, 255, 255, 0.3);
}

.cta-btn.secondary {
  background: transparent;
  color: white;
  border-color: white;
}

.cta-btn.secondary:hover {
  background: white;
  color: #6366f1;
  transform: translateY(-2px);
}

/* Responsive Design */
@media (min-width: 768px) {
  .nav-links {
    display: flex;
  }
  
  .mobile-menu-btn {
    display: none;
  }
  
  .hero-content {
    grid-template-columns: 1fr 1fr;
  }
  
  .mission-grid,
  .works-grid {
    grid-template-columns: 1fr 1fr;
  }
  
  .security-features {
    grid-template-columns: repeat(3, 1fr);
  }
  
  .hero-title {
    font-size: 3.5rem;
  }
}

@media (min-width: 1024px) {
  .hero-title {
    font-size: 4rem;
  }
  
  .section-title {
    font-size: 3rem;
  }
}

@media (max-width: 767px) {
  .hero-section {
    padding: 100px 0 60px;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-stats {
    flex-direction: column;
    gap: 1rem;
  }
  
  .section-title {
    font-size: 2rem;
  }
  
  .cta-buttons {
    flex-direction: column;
    align-items: center;
  }
  
  .cta-btn {
    width: 100%;
    max-width: 300px;
  }
  
  .floating-card {
    display: none;
  }
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}
</style>