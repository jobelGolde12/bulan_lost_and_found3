<script setup>
import { ref } from 'vue';
import { Head, Link } from '@inertiajs/vue3';

const activeIndex = ref(null)

const items = [
  {
    question: 'What is the purpose of this Lost and Found web app?',
    answer:
      'Our platform is designed to help people report, track, and recover lost and found items in Bulan, Sorsogon.',
  },
  {
    question: 'How do I report a lost item?',
    answer:
      'Go to the "Report" section, fill out the form with the item details and your contact info.',
  },
  {
    question: 'How do I report a found item?',
    answer:
      'Visit the "Report" page, enter item description and where it was found.',
  },
  {
    question: 'How does the verification process work?',
    answer:
      'Claimants must answer verification questions and provide supporting evidence. (Can only claim in PNP Station)',
  },
]

function toggle(index) {
  activeIndex.value = activeIndex.value === index ? null : index
}
</script>

<template>
  <Head title="Privacy" />
   <div id="main-container">
    <!-- Enhanced Navbar -->
    <nav class="navbar navbar-enhanced">
      <div class="nav-container">
        <div class="nav-brand">
          <img src="../../images/lost_and_found_logo.png" class="brand-logo" alt="Logo">
          <button class="brand-text">Lost & Found</button>
        </div>
        <Link :href="route('settings.index')" class="back-btn">
          <span>Back to Settings</span>
          <i class="bi bi-arrow-right back-icon"></i>
        </Link>
      </div>
    </nav>

    <!-- Main Content -->
    <div class="content-wrapper">
      <!-- Hero Section -->
      <div class="hero-section">
        <div class="hero-content">
          <h1 class="hero-title rubberBand">Bulan Lost and Found</h1>
          <p class="hero-subtitle">Terms and Policy</p>
          <div class="hero-divider"></div>
          <p class="hero-description">Ensuring a safe and trustworthy platform for locating lost and found items in Bulan, Sorsogon.</p>
        </div>
      </div>

      <!-- Policy Content -->
      <div class="policy-container">
        <div class="policy-card">
          <div class="policy-intro">
            <p>Welcome to the Bulan Lost and Found web app. Our platform is designed to help individuals report and recover lost and found items within the Municipality of Bulan. By using our services, you agree to comply with the following terms and policies.</p>
          </div>

          <!-- Policy Sections -->
          <div class="policy-section">
            <div class="section-header">
              <div class="section-number">1</div>
              <h3 class="section-title">Introduction</h3>
            </div>
            <div class="section-content">
              <p>Welcome to the Bulan Lost and Found web app. Our platform is designed to help individuals report and recover lost and found items within the Municipality of Bulan. By using our services, you agree to comply with the following terms and policies.</p>
            </div>
          </div>

          <div class="policy-section">
            <div class="section-header">
              <div class="section-number">2</div>
              <h3 class="section-title">User Responsibilities</h3>
            </div>
            <div class="section-content">
              <ul class="styled-list">
                <li>
                  <div class="list-icon">✓</div>
                  <div>Users must provide <span class="highlight-text">accurate information</span> when reporting a lost or found item.</div>
                </li>
                <li>
                  <div class="list-icon">✓</div>
                  <div>Any false or misleading reports may result in account <span class="highlight-text">suspension or removal</span>.</div>
                </li>
                <li>
                  <div class="list-icon">✓</div>
                  <div>The platform is not responsible for verifying the ownership of lost items; it is the responsibility of the involved parties to communicate and validate ownership.</div>
                </li>
              </ul>
            </div>
          </div>

          <div class="policy-section">
            <div class="section-header">
              <div class="section-number">3</div>
              <h3 class="section-title">Reporting Lost and Found Items</h3>
            </div>
            <div class="section-content">
              <ul class="styled-list">
                <li>
                  <div class="list-icon">📝</div>
                  <div>When reporting a <strong>lost item</strong>, provide detailed descriptions, photos (if available), and the last known location.</div>
                </li>
                <li>
                  <div class="list-icon">🔍</div>
                  <div>When reporting a <strong>found item</strong>, include clear details and a safe pickup location or return found item to the police station.</div>
                </li>
                <li>
                  <div class="list-icon">📞</div>
                  <div>Contact information should be provided for easier communication between the finder and the owner.</div>
                </li>
              </ul>
              
              <div class="warning-box">
                <div class="warning-icon">⚠️</div>
                <div class="warning-content">
                  <strong>Important Notice:</strong> Don't use bad words or profanity when reporting lost or found items. Any reports containing inappropriate language will be rejected. This platform uses API to detect profanity.
                </div>
              </div>
            </div>
          </div>

          <div class="policy-section">
            <div class="section-header">
              <div class="section-number">4</div>
              <h3 class="section-title">Privacy and Data Protection</h3>
            </div>
            <div class="section-content">
              <ul class="styled-list">
                <li>
                  <div class="list-icon">🔒</div>
                  <div>Personal data such as contact information will be handled securely and used only for communication purposes related to lost and found items.</div>
                </li>
                <li>
                  <div class="list-icon">🛡️</div>
                  <div>The platform does not sell or share personal information with third parties.</div>
                </li>
              </ul>
            </div>
          </div>

          <div class="policy-section">
            <div class="section-header">
              <div class="section-number">5</div>
              <h3 class="section-title">Disclaimer</h3>
            </div>
            <div class="section-content">
              <ul class="styled-list">
                <li>
                  <div class="list-icon">💼</div>
                  <div>The Bulan Lost and Found web app serves as a facilitator for reconnecting owners with their lost belongings.</div>
                </li>
                <li>
                  <div class="list-icon">⚖️</div>
                  <div>We do not guarantee the recovery of lost items but strive to provide an efficient and safe platform for users.</div>
                </li>
              </ul>
            </div>
          </div>
        </div>

        <!-- FAQ Section -->
        <div class="faq-section">
          <div class="faq-header">
            <h2 class="faq-title">Frequently Asked Questions</h2>
            <p class="faq-subtitle">Quick answers to common questions about our platform</p>
          </div>

          <div class="accordion-wrapper">
            <div v-for="(item, index) in items" :key="index" class="accordion-item" :class="{ 'active': activeIndex === index }">
              <div class="accordion-header" @click="toggle(index)">
                <span class="accordion-question">{{ item.question }}</span>
                <span class="accordion-icon">
                  <i class="bi" :class="activeIndex === index ? 'bi-dash' : 'bi-plus'"></i>
                </span>
              </div>
              <transition name="slide">
                <div v-show="activeIndex === index" class="accordion-body">
                  <div class="accordion-content">
                    {{ item.answer }}
                  </div>
                </div>
              </transition>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Enhanced Navbar */
.navbar-enhanced {
  background: transparent;
  padding: 1rem 0;
  color: #333;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.nav-brand {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.brand-logo {
  width: 45px;
  height: 45px;
  border-radius: 50%;
}

.brand-text {
  font-size: 1.2rem;
  font-weight: 700;
  color: rgb(7, 7, 7);
  text-decoration: none;
  cursor:default;
}

.back-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: rgba(255, 255, 255, 0.2);
  color: rgb(3, 3, 3);
  text-decoration: none;
  border-radius: 50px;
  font-weight: 600;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.3);
}

.back-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateX(-5px);
}

.back-icon {
  transition: transform 0.3s ease;
}

.back-btn:hover .back-icon {
  transform: translateX(3px);
}

/* Hero Section */
.hero-section {
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 4rem 2rem;
  text-align: center;
  margin-bottom: 3rem;
}

.hero-content {
  max-width: 800px;
  margin: 0 auto;
}

.hero-title {
  font-size: 3rem;
  font-weight: 800;
  color: #2c2363;
  margin-bottom: 0.5rem;
}

.hero-subtitle {
  font-size: 1.5rem;
  color: #667eea;
  font-weight: 600;
  margin-bottom: 1.5rem;
}

.hero-divider {
  width: 80px;
  height: 4px;
  background: linear-gradient(90deg, #667eea, #764ba2);
  margin: 0 auto 1.5rem;
  border-radius: 2px;
}

.hero-description {
  font-size: 1.1rem;
  color: #6c757d;
  line-height: 1.6;
}

/* Policy Container */
.policy-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 0 2rem;
}

.policy-card {
  background: white;
  border-radius: 20px;
  padding: 3rem;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
  margin-bottom: 4rem;
  border: 1px solid #e8eaf6;
}

.policy-intro {
  text-align: center;
  font-size: 1.1rem;
  line-height: 1.7;
  color: #555;
  margin-bottom: 3rem;
  padding-bottom: 2rem;
  border-bottom: 2px solid #f0f2f5;
}

/* Policy Sections */
.policy-section {
  margin-bottom: 3rem;
}

.section-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.section-number {
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1.1rem;
}

.section-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #2c2363;
  margin: 0;
}

.section-content {
  padding-left: 1rem;
  border-left: 3px solid #e8eaf6;
  margin-left: 20px;
}

/* Styled List */
.styled-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.styled-list li {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  margin-bottom: 1rem;
  padding: 1rem;
  background: #f8f9ff;
  border-radius: 10px;
  border-left: 4px solid #667eea;
  transition: all 0.3s ease;
}

.styled-list li:hover {
  background: #f0f2ff;
  transform: translateX(5px);
}

.list-icon {
  font-size: 1.2rem;
  flex-shrink: 0;
}

.highlight-text {
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 600;
}

/* Warning Box */
.warning-box {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  padding: 1.5rem;
  background: #fff3cd;
  border: 1px solid #ffeaa7;
  border-radius: 12px;
  margin-top: 1.5rem;
}

.warning-icon {
  font-size: 1.5rem;
  flex-shrink: 0;
}

.warning-content {
  color: #856404;
  line-height: 1.6;
}

/* FAQ Section */
.faq-section {
  background: white;
  border-radius: 20px;
  padding: 3rem;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
}

.faq-header {
  text-align: center;
  margin-bottom: 3rem;
}

.faq-title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #2c2363;
  margin-bottom: 1rem;
}

.faq-subtitle {
  font-size: 1.1rem;
  color: #6c757d;
}

/* Enhanced Accordion */
.accordion-wrapper {
  max-width: 800px;
  margin: 0 auto;
}

.accordion-item {
  border: 1px solid #e8eaf6;
  border-radius: 12px;
  margin-bottom: 1rem;
  overflow: hidden;
  background: white;
  transition: all 0.3s ease;
}

.accordion-item.active {
  border-color: #667eea;
  box-shadow: 0 5px 20px rgba(102, 126, 234, 0.1);
}

.accordion-header {
  padding: 1.5rem;
  background: white;
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  align-items: center;
  transition: all 0.3s ease;
}

.accordion-item.active .accordion-header {
  background: linear-gradient(135deg, #f8f9ff, #f0f2ff);
}

.accordion-question {
  font-weight: 600;
  color: #2c2363;
  font-size: 1.1rem;
  flex: 1;
}

.accordion-icon {
  width: 32px;
  height: 32px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  transition: all 0.3s ease;
}

.accordion-body {
  background: white;
}

.accordion-content {
  padding: 1.5rem;
  color: #555;
  line-height: 1.6;
  border-top: 1px solid #f0f2f5;
}

/* Animations */
.slide-enter-active {
  animation: slideDown 0.3s ease;
}

.slide-leave-active {
  animation: slideDown 0.3s ease reverse;
}

@keyframes rubberBand {
  0% { transform: scale3d(1, 1, 1); }
  30% { transform: scale3d(1.25, 0.75, 1); }
  40% { transform: scale3d(0.75, 1.25, 1); }
  50% { transform: scale3d(1.15, 0.85, 1); }
  65% { transform: scale3d(0.95, 1.05, 1); }
  75% { transform: scale3d(1.05, 0.95, 1); }
  100% { transform: scale3d(1, 1, 1); }
}

.rubberBand {
  animation: rubberBand 1s;
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Responsive Design */
@media (max-width: 768px) {
  .nav-container {
    padding: 0 1rem;
    flex-direction: column;
    gap: 1rem;
  }
  
  .hero-title {
    font-size: 2rem;
  }
  
  .hero-subtitle {
    font-size: 1.2rem;
  }
  
  .policy-card,
  .faq-section {
    padding: 2rem 1.5rem;
  }
  
  .section-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }
  
  .section-content {
    padding-left: 0;
    border-left: none;
    margin-left: 0;
    border-top: 2px solid #f0f2f5;
    padding-top: 1rem;
  }
  
  .styled-list li {
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .accordion-header {
    padding: 1.25rem;
  }
  
  .accordion-question {
    font-size: 1rem;
  }
}
</style>