<script setup>
import { Head, Link } from "@inertiajs/vue3";
import lostAndFoundLogo from "../../images/lost_and_found_logo.png";
import hero from "../../images/aboutUs/hero.svg";
import connection from "../../images/aboutUs/connection.svg";
import dataReport from "../../images/aboutUs/data-reports.svg";
</script>

<template>
  <Head title="About Us" />
  <div class="main-container">
    <!-- Navbar -->
    <div class="navbar d-flex justify-content-between px-3 px-lg-5 align-items-center">
      <div class="logo">
        <img :src="lostAndFoundLogo" alt="Application logo" />
      </div>
      <div class="links d-none d-lg-flex flex-row gap-4 align-items-center">
        <Link href="/" class="text-dark text-decoration-none">Home</Link>
        <Link :href="route('login')" class="btn btn-dark text-decoration-none">Login</Link>
      </div>
      <div
        class="bi bi-list fs-1 fw-bolder d-block d-lg-none pointer"
        data-bs-toggle="offcanvas"
        data-bs-target="#offcanvasMenu"
      ></div>
    </div>

    <!-- Offcanvas Menu -->
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasMenu">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title">Menu</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
        <Link href="/" class="d-block mb-2 text-dark text-decoration-none">Home</Link>
        <Link :href="route('login')" class="d-block mb-2 btn btn-dark text-decoration-none">Login</Link>
      </div>
    </div>

    <!-- Hero Section -->
    <section class="hero-section text-center text-md-start">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-12 col-md-6">
            <h1>Learn More About Our Mission to Help You Reunite with Your Lost Items</h1>
            <p>"A reliable and secure platform for locating lost and found items in Bulan, Sorsogon."</p>
            <Link :href="route('contactAdmin')" class="btn btn-dark">Contact Admin</Link>
          </div>
          <div class="col-12 col-md-6 text-center d-none d-lg-block">
            <img :src="hero" class="img-fluid rounded" alt="Hero illustration" />
          </div>
        </div>
      </div>
    </section>

    <!-- Mission Section -->
    <section class="text-center text-md-start py-5">
      <div class="container">
        <div class="text-center add-space">
          <h2 class="pb-0">Our Mission to Connect People and Their Lost Items</h2>
          <p class="text-muted">We are committed to providing a safe and efficient platform for finding and returning lost belongings.</p>
        </div>
        <div class="row align-items-center">
          <div class="col-12 col-md-6">
            <h2>Bridging the Gap Between Lost and Found</h2>
            <p>Our platform ensures that lost items find their way back to their rightful owners with ease and security.</p>
          </div>
          <div class="col-12 col-md-6 text-center">
            <img :src="connection" class="img-fluid rounded" alt="Connection illustration" />
          </div>
        </div>
      </div>
    </section>

    <!-- How It Works Section -->
    <section class="text-center text-md-start py-5">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-12 col-md-6 text-center order-md-1 order-2">
            <img :src="dataReport" class="img-fluid rounded" alt="Data Reports illustration" />
          </div>
          <div class="col-12 col-md-6 order-md-2 order-1">
            <h2>How It Works?</h2>
            <ul class="how-it-works-list">
                <li>Report lost or found items easily through our platform.</li>
                <li>Browse all posted listings to check for your lost or found items.</li>
                <li>Connect and communicate securely with the rightful owner, finder, or <span class="text-success">PNP</span>.</li>
                <li>Get your lost item in police station.</li>
                <li>Help build a trusted community in Bulan, Sorsogon.</li>
            </ul>
            </div>

        </div>
      </div>
    </section>

    <section id="privacy-security" class="py-5 bg-light mb-5">
    <div class="container">
        <h2 class="text-center">Privacy and Security Commitment</h2>
        <p class="lead text-center">We ensure that your personal data and communication are kept private and secure at all times.</p>
    </div>
</section>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-4">
      <div class="container">
        <div class="row">
          <div class="col-md-4 mb-3 mb-md-0">
            <h5>Contact Info</h5>
            <p>thephpemail@gmail.com</p>
            <p>09930543293</p>
            <p>Bulan, Sorsogon</p>
          </div>
          <div class="col-md-4 mb-3 mb-md-0">
            <h5>Social Media</h5>
            <p>Facebook | Twitter | Instagram</p>
          </div>
          <div class="col-md-4">
            <h5>Quick Links</h5>
            <p>Home | About Us | Terms & Conditions</p>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>

<style scoped>
.main-container {
  font-family: 'Poppins', sans-serif;
}
.hero-section {
  padding: 80px 0;
}
.hero-section h1 {
  font-weight: bold;
}
.btn-dark {
  background-color: black;
  border: none;
}
.btn-dark:hover {
  background-color: #333;
}
.navbar .logo {
  width: 50px;
  height: 50px;
  border-radius: 50%;
}
.logo img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: inherit;
}
.add-space{
    margin-bottom: 6rem;
}
.how-it-works-list {
  list-style-type: disc;
  padding-left: 1.5rem;
}
.how-it-works-list li {
  margin-bottom: 10px;
}
.privacy-security{
    margin-bottom: 3rem;
}

@media (max-width: 767px) {
  .hero-section {
    padding: 40px 0;
  }
  section{
    margin-bottom: 50px; 
  }
  .add-space{
    margin-bottom: 10rem;
  }
}
</style>
