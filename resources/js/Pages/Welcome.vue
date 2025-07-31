<script setup>
import { Head, Link } from "@inertiajs/vue3";
import lostAndFoundLogo from "../../images/lost_and_found_logo.png";
</script>

<template>
    <Head title="Welcome" />
    <div class="main-container bg-light">
        <!-- Navigation Bar -->
        <div
            class="navbar d-flex flex-row justify-content-between align-items-center px-3"
        >
            <div class="d-flex flex-row gap-2 align-items-center">
                <div class="logo">
                    <img :src="lostAndFoundLogo" alt="Application logo" />
                </div>
                <div><p class="text-dark laf-text">Lost and found</p></div>
            </div>
            <div
                class="links d-none d-lg-flex flex-row gap-4 align-items-center"
            >
                <Link
                    :href="route('aboutUs')"
                    class="text-dark text-decoration-none"
                    >AboutUs</Link
                >
                <Link
                    :href="route('login')"
                    class="text-dark text-decoration-none"
                    >Login</Link
                >
                <Link
                    :href="route('register')"
                    class="text-decoration-none bg-dark text-light px-2 py-1 signup-link"
                    >Signup</Link
                >
            </div>

            <div
                class="bi bi-list fs-1 fw-bolder pointer hover d-block d-lg-none"
                data-bs-placement="bottom"
                title="menu"
                data-bs-target="#offcanvasMenu"
                data-bs-toggle="offcanvas"
            ></div>
        </div>

        <!-- Offcanvas Menu -->
        <div
            class="offcanvas offcanvas-end"
            tabindex="-1"
            id="offcanvasMenu"
            aria-labelledby="offcanvasMenuLabel"
        >
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasMenuLabel">Menu</h5>
                <button
                    type="button"
                    class="btn-close text-reset"
                    data-bs-dismiss="offcanvas"
                    aria-label="Close"
                ></button>
            </div>
            <div class="offcanvas-body">
                <Link
                    :href="route('aboutUs')"
                    class="text-dark text-decoration-none"
                    >AboutUs</Link
                >
                <Link
                    :href="route('login')"
                    class="d-block mb-2 text-dark text-decoration-none"
                    >Login</Link
                >
                <Link
                    :href="route('register')"
                    class="d-block mb-2 text-decoration-none bg-dark text-light px-2 py-1 signup-link"
                    >Signup</Link
                >
            </div>
        </div>

        <!-- hero section content  -->
        <section
            id="hero-content"
            class="h-auto d-flex flex-column align-items-center justify-content-center bg-light text-dark text-center mt-3"
        >
            <h1 class="text-dark text-center">
                Find and Report Lost or Found <br />
                Items in Bulan <span class="has-paint text-light">Easily</span>
            </h1>
            <p class="text-dark text-center">
                Join others in Bulan and report lost or found items with just a
                few clicks.
            </p>

            <div
                class="action-button container d-flex flex-row align-items-center justify-content-center gap-5 pt-3 px-5"
            >
                <Link
                    :href="route('dashboard')"
                    class="text-decoration-none text-light bg-dark px-3 py-2 report-found-item-link"
                    >Get started <i class="bi bi-arrow-right"></i
                ></Link>
            </div>

            <div
                class="video-wrapper container mt-5 pt-5 mx-auto d-flex flex-row justify-content-center align-items-center"
            >
                <!-- <img src="../../images/welcome.png" alt=""> -->
                <video
                    src="../../videos/welcome_vid1.mp4"
                    autoplay
                    muted
                    loop
                    playsinline
                    width="640"
                    height="360"
                >
                    Your browser does not support the video tag!
                </video>
            </div>
        </section>

        <section id="about">
            <div class="container text-center pt-5">
                <!-- <h1 class="text-dark fw-bolder">About Us!</h1> -->

                <div class="about-hero-section mt-5">
                    <div class="container custom-container">
                        <div class="row align-items-center">
                            <div class="col-lg-6 text-left">
                                <h1 class="hero-title">
                                    Welcome to the Bulan Lost and Found Website!
                                </h1>
                                <p class="hero-subtitle">
                                    This platform was created to help the people
                                    of Bulan reconnect with their lost items and
                                    recover valuables. Our goal is to make it
                                    easier for individuals to report lost or
                                    found items and promote a more connected,
                                    responsible community.
                                </p>
                            </div>
                            <div
                                class="col-lg-6 text-left about-image-container"
                            >
                                <img
                                    src="../../images/happy.svg"
                                    alt="Image "
                                    class="d about-image"
                                />
                                <!-- <h5 class="text-dark">Our Mission</h5>
                            <p class="d-block text-dark">We aim to provide a simple, user-friendly online service that bridges the gap between those who have lost something and those who have found it.</p> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="howItsWork">
            <div class="stats-section pt-5 mt-5">
                <h1 class="text-dark text-center fw-bolder pt-5 mb-3">
                    How It Works?
                </h1>
                <div class="container custom-container mt-5 pt-5">
                    <div class="row justify-content-center">
                        <!-- Card 1 -->
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="stats-card text-center">
                                <img src="../../images/announce.svg" alt="" />
                                <div class="stats-title mt-3">
                                    Report a Lost Item
                                </div>
                                <div class="stats-label">
                                    Post details about your missing item,
                                    including a description, last known
                                    location, and contact information.
                                </div>
                            </div>
                        </div>
                        <!-- Card 2 -->
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="stats-card text-center">
                                <img src="../../images/found.svg" alt="" />
                                <div class="stats-title mt-3">
                                    Report a Found Item
                                </div>
                                <div class="stats-label">
                                    Post details of what you found to help the
                                    rightful owner claim their lost property.
                                </div>
                            </div>
                        </div>
                        <!-- Card 3 -->
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="stats-card text-center">
                                <img src="../../images/brows.svg" alt="" />
                                <div class="stats-title mt-3">
                                    Browse Lost or Found Listings
                                </div>
                                <div class="stats-label">
                                    Check listings to see if your item has been
                                    found or if someone is looking for what you
                                    found.
                                </div>
                            </div>
                        </div>
                        <!-- Card 4 -->
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="stats-card text-center">
                                <img src="../../images/claim.svg" alt="" />
                                <div class="stats-title mt-3">
                                    Reclaim or Return Items
                                </div>
                                <div class="stats-label">
                                    Contact the person and arrange the return
                                    once an item matches.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <footer id="footer" class="footer mt-5 pt-5">
            <div class="container">
                <div class="row">
                    <!-- <div class="col-md-4">
    <div class="logo-section">
      <p>Find and Report Lost or Found
        Items in Bulan easily</p>
    </div>
  </div> -->
                    <div class="col-md-3">
                        <h5>Contact Info.</h5>
                        <ul class="list-unstyled">
                            <li><a href="#">jobelgolde43@gmail.com</a></li>
                            <li><a href="#">09930543293</a></li>
                            <li><a href="#">Bonga, Bulan, Sor</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h5>Social media</h5>
                        <ul class="list-unstyled">
                            <li>
                                <a href="#"
                                    ><i
                                        class="bi bi-facebook text-light me-1"
                                    ></i
                                    >Facebook</a
                                >
                            </li>
                            <li>
                                <a href="#"
                                    ><i
                                        class="bi bi-twitter text-light me-1"
                                    ></i
                                    >Twitter</a
                                >
                            </li>
                            <li>
                                <a href="#"
                                    ><i
                                        class="bi bi-instagram text-light me-1"
                                    ></i
                                    >Instagram</a
                                >
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h5>Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="#hero-content">Home</a></li>
                            <!-- <li> <Link :href="route('contactPage')" class="link text-decoration-none">Contact</Link></li> -->
                            <li>
                                <Link :href="route('aboutUs')">About Us</Link>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h5>Company</h5>
                        <ul class="list-unstyled">
                            <li><a href="#">Terms & Conditions</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                        </ul>
                    </div>
                </div>
                <div class="row mt-5">
                    <div class="col-md-4">
                        <h5>Bulan Lost And Found Website</h5>
                        <div class="social-icons">
                            <a href="#"><i class="fab fa-facebook"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                        </div>
                    </div>
                    <!-- <div class="col-md-8 text-md-end">
    <form class="subscribe-form">
      <input type="email" class="form-control" placeholder="Enter email address">
      <button class="btn btn-primary">Subscribe</button>
    </form>
  </div> -->
                </div>
            </div>
        </footer>
    </div>
</template>

<style lang="css" scoped>
@import "../../css/global.css";
@import "../../css/welcome.css";
</style>
