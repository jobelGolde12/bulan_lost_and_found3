<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
  <div>
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
        class=" action-button container d-flex flex-row align-items-center justify-content-center gap-5 pt-3 px-0 mx-0"
      >
        <Link
          :href="route('dashboard')"
          class="text-decoration-none text-light bg-dark px-3 py-2 report-found-item-link"
        >
          Get started <i class="bi bi-arrow-right"></i>
        </Link>
      </div>

      <div class="video-wrapper mx-auto">
        <video
          src="../../../videos/welcome_vid2.mp4"
          autoplay
          muted
          loop
          playsinline
        >
          Your browser does not support the video tag!
        </video>
      </div>
    </section>
  </div>
</template>

<style scoped>
@import '../../../css/welcome.css';

.video-wrapper {
  position: relative;
  width: 100%;
  max-width: 1200px;
  aspect-ratio: 16 / 9;
  overflow: hidden;
  border-radius: 20px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1), 0 8px 24px rgba(0, 0, 0, 0.08);
  background: linear-gradient(145deg, #f0f0f0, #ffffff);
  margin-top: 2rem;
  transition: all 0.3s ease;
}

.video-wrapper:hover {
  transform: translateY(-5px);
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15), 0 12px 30px rgba(0, 0, 0, 0.1);
}

.video-wrapper video {
  width: 100%;
  height: 100%;
  object-fit: contain;
  display: block;
  border-radius: 18px;
}

/* Modern gradient border effect */
.video-wrapper::before {
  content: '';
  position: absolute;
  top: -2px;
  left: -2px;
  right: -2px;
  bottom: -2px;
  background: linear-gradient(45deg, #667eea, #764ba2, #f093fb, #f5576c);
  border-radius: 22px;
  z-index: -1;
  opacity: 0.7;
  transition: opacity 0.3s ease;
}

.video-wrapper:hover::before {
  opacity: 1;
}

/* Responsive Design */
@media (max-width: 1200px) {
  .video-wrapper {
    max-width: 1000px;
    border-radius: 18px;
  }
}

@media (max-width: 992px) {
  .video-wrapper {
    max-width: 800px;
    border-radius: 16px;
    margin-top: 1.5rem;
  }
  
  .video-wrapper::before {
    border-radius: 18px;
  }
}

@media (max-width: 768px) {
  .video-wrapper {
    max-width: 95%;
    border-radius: 14px;
    margin-top: 1rem;
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1), 0 6px 18px rgba(0, 0, 0, 0.08);
  }
  
  .video-wrapper:hover {
    transform: translateY(-3px);
    box-shadow: 0 18px 36px rgba(0, 0, 0, 0.12), 0 8px 22px rgba(0, 0, 0, 0.1);
  }
  
  .video-wrapper::before {
    border-radius: 16px;
  }
}

@media (max-width: 576px) {
  .video-wrapper {
    max-width: 92%;
    border-radius: 12px;
    margin-top: 1rem;
    aspect-ratio: 16 / 9;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08), 0 4px 12px rgba(0, 0, 0, 0.06);
  }
  
  .video-wrapper:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1), 0 5px 15px rgba(0, 0, 0, 0.08);
  }
  
  .video-wrapper video {
    object-fit: contain;
    border-radius: 10px;
  }
  
  .video-wrapper::before {
    border-radius: 14px;
  }
}

@media (max-width: 400px) {
  .video-wrapper {
    max-width: 90%;
    border-radius: 10px;
    aspect-ratio: 16 / 9;
    margin: 1rem auto;
  }
  
  .video-wrapper video {
    object-fit: contain;
    border-radius: 8px;
  }
  
  .video-wrapper::before {
    border-radius: 12px;
  }
}

/* Extra small devices */
@media (max-width: 320px) {
  .video-wrapper {
    max-width: 88%;
    border-radius: 8px;
    aspect-ratio: 16 / 9;
  }
  
  .video-wrapper video {
    border-radius: 6px;
  }
  
  .video-wrapper::before {
    border-radius: 10px;
  }
}

/* Reduced motion for accessibility */
@media (prefers-reduced-motion: reduce) {
  .video-wrapper,
  .video-wrapper:hover,
  .video-wrapper::before {
    transition: none;
    transform: none;
  }
}

/* High contrast mode support */
@media (prefers-contrast: high) {
  .video-wrapper {
    border: 2px solid #000;
  }
  
  .video-wrapper::before {
    display: none;
  }
}

/* Dark mode support */
@media (prefers-color-scheme: dark) {
  .video-wrapper {
    background: linear-gradient(145deg, #2a2a2a, #3a3a3a);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3), 0 8px 24px rgba(0, 0, 0, 0.25);
  }
  
  .video-wrapper:hover {
    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.4), 0 12px 30px rgba(0, 0, 0, 0.3);
  }
}
</style>