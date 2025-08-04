<script setup>
</script>

<template>
  <div>
    <section id="howItsWork">
      <div class="stats-section pt-5 mt-5">
        <h1 class="text-dark text-center fw-bolder pt-5 mb-3">
          How It Works?
        </h1>
        <div class="container custom-container mt-5 pt-5">
          <!-- Card wrapper for blur logic -->
          <div class="row justify-content-center card-group">
            <!-- Card 1 -->
            <div class="col-lg-3 col-md-6 mb-4">
              <div class="stats-card text-center">
                <img src="../../../images/announce.svg" alt="" />
                <div class="stats-title mt-3">Report a Lost Item</div>
                <div class="stats-label">
                  Post details about your missing item, including a description,
                  last known location, and contact information.
                </div>
              </div>
            </div>

            <!-- Card 2 -->
            <div class="col-lg-3 col-md-6 mb-4">
              <div class="stats-card text-center">
                <img src="../../../images/found.svg" alt="" />
                <div class="stats-title mt-3">Report a Found Item</div>
                <div class="stats-label">
                  Post details of what you found to help the rightful owner
                  claim their lost property.
                </div>
              </div>
            </div>

            <!-- Card 3 -->
            <div class="col-lg-3 col-md-6 mb-4">
              <div class="stats-card text-center">
                <img src="../../../images/brows.svg" alt="" />
                <div class="stats-title mt-3">Browse Lost or Found Listings</div>
                <div class="stats-label">
                  Check listings to see if your item has been found or if someone
                  is looking for what you found.
                </div>
              </div>
            </div>

            <!-- Card 4 -->
            <div class="col-lg-3 col-md-6 mb-4">
              <div class="stats-card text-center">
                <img src="../../../images/claim.svg" alt="" />
                <div class="stats-title mt-3">Reclaim or Return Items</div>
                <div class="stats-label">
                  Contact the person and arrange the return once an item matches.
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
#howItsWork {
  width: 100vw;
  height: auto;
}

/* Section padding */
.stats-section {
  padding: 60px 20px;
}

/* Card styling */
.stats-card {
  overflow: hidden;
  position: relative;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  background-color: #f8f9fa;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 100%;
  transition: transform 0.3s ease, filter 0.3s ease;
}

/* Image inside cards */
.stats-card img {
  width: 50%;
  height: auto;
  margin: 0 auto;
}

/* Title and label */
.stats-title {
  font-size: 1.2rem;
  font-weight: 700;
  margin-top: 10px;
}

.stats-label {
  font-size: 1rem;
  color: #6c757d;
  margin-top: 10px;
}

/* Container max width */
.custom-container {
  max-width: 1200px;
}

/* Responsive margin */
@media (max-width: 768px) {
  #howItsWork {
    margin-top: 15rem;
  }
}

/* 🔍 Hover blur effect */
.card-group:hover .stats-card {
  filter: opacity(.7);
}

.card-group .stats-card:hover {
  filter: none;
  transform: scale(1.03);
  z-index: 2;
}
</style>
