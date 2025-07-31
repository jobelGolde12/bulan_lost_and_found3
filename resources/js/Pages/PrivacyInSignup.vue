
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
      'Go to the "Report Lost Item" section, fill out the form with the item details and your contact info.',
  },
  {
    question: 'How do I report a found item?',
    answer:
      'Visit the "Report Found Item" page, enter item description and where it was found.',
  },
  {
    question: 'How does the verification process work?',
    answer:
      'Claimants must answer verification questions and provide supporting evidence.',
  },
]

function toggle(index) {
  activeIndex.value = activeIndex.value === index ? null : index
}
</script>

<template>
  <Head title="Privacy" />
   <div id="main-container">
    <nav class="navbar bg-white shadow-sm px-4 py-3">
      <div class="container-fluid">
        <div class="d-flex align-items-center">
          <img src="../../images/lost_and_found_logo.png" class="rounded-circle me-2 logo" alt="Logo">
          <span class="logo-text">Lost & Found</span>
        </div>
        <Link :href="route('register')" class="back-link text-decoration-none text-dark">Back <i class="bi bi-arrow-return-left ms-2"></i></Link>
      </div>
    </nav>

    <div class="content-wrapper">
      <div class="text-center mb-4">
        <h1>Bulan Lost and Found Terms and Policy</h1>
        <p class="text-muted">Ensuring a safe and trustworthy platform for locating lost and found items in Bulan, Sorsogon.</p>
      </div>

      <div>
        <h3 class="section-title">1. Introduction</h3>
        <p>Welcome to the Bulan Lost and Found web app. Our platform is designed to help individuals report and recover lost and found items within the Municipality of Bulan. By using our services, you agree to comply with the following terms and policies.</p>

        <h3 class="section-title">2. User Responsibilities</h3>
        <ul>
          <li>Users must provide accurate information when reporting a lost or found item.</li>
          <li>Any false or misleading reports may result in account suspension or removal.</li>
          <li>The platform is not responsible for verifying the ownership of lost items; it is the responsibility of the involved parties to communicate and validate ownership.</li>
        </ul>

        <h3 class="section-title">3. Reporting Lost and Found Items</h3>
        <ul>
          <li>When reporting a <strong>lost item</strong> to the police, provide detailed descriptions, photos (if available), and the last known location.</li>
          <li>When reporting a <strong>found item</strong> to the police, include clear details and a safe pickup location or return found item to the police station.</li>
          <li>Contact information should be provided for easier communication between the finder and the owner.</li>
        </ul>

        <h3 class="section-title">4. Privacy and Data Protection</h3>
        <ul>
          <li>Personal data such as contact information will be handled securely and used only for communication purposes related to lost and found items.</li>
          <li>The platform does not sell or share personal information with third parties.</li>
        </ul>

        <h3 class="section-title">5. Disclaimer</h3>
        <ul>
          <li>The Bulan Lost and Found web app serves as a facilitator for reconnecting owners with their lost belongings.</li>
          <li>We do not guarantee the recovery of lost items but strive to provide an efficient and safe platform for users.</li>
        </ul>
      </div>

    <!-- ------------ -->
    <div class="accordion-wrapper">
    <h1 class="page-title">Bulan Lost and Found Terms and Policy – Q&A</h1>

    <div v-for="(item, index) in items" :key="index" class="accordion-item">
      <div class="accordion-header" @click="toggle(index)">
        {{ item.question }}
        <span class="icon">{{ activeIndex === index ? '−' : '+' }}</span>
      </div>
      <div
        class="accordion-body"
        v-show="activeIndex === index"
      >
        {{ item.answer }}
      </div>
    </div>
  </div>

  
    </div>
  </div>

</template>
<style scoped>
.logo{
  width: 40px;
  height: 40px;
}
 h1, h2, h3 {
      color: #1f1f47;
    }
    .section-title {
      font-weight: 700;
      margin-top: 2rem;
    }
    .back-link {
      font-weight: 500;
      cursor: pointer;
    }
    .content-wrapper {
      max-width: 960px;
      margin: auto;
      padding: 2rem 1rem;
    }
    .logo-text {
      font-weight: 600;
      font-size: 1.2rem;
    }
    footer {
      margin-top: 4rem;
      text-align: center;
      font-weight: 600;
      color: #2c2c5f;
    }
    .back-icon {
      margin-left: 0.25rem;
      color: #333;
    }
    /* --------- */
    .page-title {
      font-size: 1.75rem;
      font-weight: 700;
      color: #2c2363;
      text-align: center;
      margin-top: 4rem;
      margin-bottom: 2rem;
    }
    .accordion-button {
      background-color: #3b2d7d;
      color: white;
      font-weight: 600;
    }
    .accordion-button:not(.collapsed) {
      background-color: #3b2d7d;
      color: white;
    }
    .accordion-body {
      background-color: #fff;
      color: #333;
    }
    .accordion-item {
      border-radius: 8px;
      margin-bottom: 1rem;
      overflow: hidden;
      border: 1px solid #ddd;
    }
    
.accordion-wrapper {
  max-width: 800px;
  margin: 4rem auto;
  padding: 0 1rem;
}

.page-title {
  text-align: center;
  font-size: 1.75rem;
  font-weight: 700;
  color: #2c2363;
  margin-bottom: 2rem;
}

.accordion-item {
  border: 1px solid #ddd;
  border-radius: 8px;
  margin-bottom: 1rem;
  overflow: hidden;
  background-color: white;
}

.accordion-header {
  background-color: #3b2d7d;
  color: white;
  font-weight: 600;
  padding: 1rem;
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.accordion-body {
  padding: 1rem;
  background-color: #fff;
  color: #333;
  animation: slideDown 0.3s ease forwards;
}

.icon {
  font-size: 1.5rem;
  margin-left: 1rem;
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-4px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>

