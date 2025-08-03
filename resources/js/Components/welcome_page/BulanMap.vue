<script setup>
</script>

<template>
  <div class="container-fluid py-5">
    <h1 class="text-dark text-center fw-bolder mb-4">
      Bulan, Sorsogon Lost and Found Map
    </h1>

    <div class="d-flex flex-column flex-lg-row gap-4 justify-content-center align-items-start">
      <!-- Info Panel -->
      <div class="content-box info-box">
        <h2 class="fw-semibold mb-3">
          <i class="bi bi-geo-alt-fill text-dark me-2"></i>Find Lost & Found Locations
        </h2>
        <p class="text-muted">
          This map displays locations in <strong>Bulan, Sorsogon</strong> where lost or found items have been reported by members of the community.
        </p>
        <p>
          Use it to trace back where you might have lost something or to help return found items to their rightful owners.
        </p>
       <ul class="list-unstyled">
            <li class="mb-2">
                <i class="bi bi-search text-dark me-2"></i>
                <strong>Zoom in</strong> to specific barangays and streets.
            </li>
            <li class="mb-2">
                <i class="bi bi-geo-alt text-dark me-2"></i>
                <strong>Check markers</strong> for reported items.
            </li>
            <li class="mb-2">
                <i class="bi bi-upload text-dark me-2"></i>
                <strong>Contribute</strong> by submitting new reports via our app.
            </li>
        </ul>

      </div>

      <!-- Map Panel -->
      <div class="content-box map-box">
        <div class="border rounded shadow-sm overflow-hidden">
          <iframe
            src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d62340.82818489969!2d123.8915112!3d12.6692278!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33a0d168a6bcb5a3%3A0x24c94298cb5be0b6!2sBulan%2C%20Sorsogon!5e0!3m2!1sen!2sph!4v1754210839383!5m2!1sen!2sph"
            width="100%"
            height="400"
            style="border: 0"
            allowfullscreen=""
            loading="lazy"
            referrerpolicy="no-referrer-when-downgrade"
            class="w-100"
          ></iframe>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
*{
  font-family: 'Poppins', sans-serif;
}
.content-box {
  flex: 1;
}

@media (min-width: 992px) {
  .content-box {
    width: 50%;
  }
}

.map-box {
  width: 100%;
}

@media (max-width: 991px) {
  .map-box {
    width: 100vw;
    margin-left: calc(-50vw + 50%);
    margin-right: calc(-50vw + 50%);
  }
}
</style>
