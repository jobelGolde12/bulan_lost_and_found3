<script setup>
import { Head, Link } from "@inertiajs/vue3";
import lostAndFoundLogo from "../../images/lost_and_found_logo.png";
import AboutSection from "@/Components/welcome_page/AboutSection.vue";
import HowItWorksSection from "@/Components/welcome_page/HowItWorksSection.vue";
import BulanMap from "@/Components/welcome_page/BulanMap.vue";
import WelcomeFooter from "@/Components/welcome_page/WelcomeFooter.vue";
import HeroSection from "@/Components/welcome_page/HeroSection.vue";
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
                    <img :src="lostAndFoundLogo" alt="Application logo"/>
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
                    class="text-decoration-none btn btn-dark"
                    >Login</Link
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
                
            </div>
        </div>
        
        <HeroSection />
        <AboutSection />
        <HowItWorksSection />
        <BulanMap />
        <WelcomeFooter />
    </div>
</template>

<style lang="css" scoped>
@import "../../css/global.css";
@import "../../css/welcome.css";
</style>
