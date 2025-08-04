<script setup></script>
<template>
  <div>
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
                    src="../../../videos/welcome_vid1.mp4"
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
  </div>
</template>

<style scoped>
@import '../../../css/welcome.css';
</style>