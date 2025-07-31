<template>
    <!-- Modal -->
    <div
      class="modal show d-flex flex-row justify-content-center align-items-center"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="false"
      :class="{ 'dark-mode': isDarkMode }"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-body d-flex flex-row gap-3">
            <div><h2 class="text-dark text-center fw-bolder">Loading</h2></div>
            <div class="loader"></div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref } from "vue";
  
  const isDarkMode = ref(false);
  
  const toggleDarkMode = () => {
    isDarkMode.value = !isDarkMode.value;
  };
  </script>
  
  <style scoped>
  .modal {
    background-color: rgba(85, 78, 78, 0.8);
    transition: background-color 0.3s ease-in-out;
  }
  
  /* Dark Mode */
  .dark-mode {
    background-color: rgba(0, 0, 0, 0.8);
    color: white;
  }
  
  /* Loader */
  .loader {
    width: 60px;
    aspect-ratio: 2;
    --_g: no-repeat radial-gradient(circle closest-side, #000 90%, #0000);
    background:
      var(--_g) 0% 50%,
      var(--_g) 50% 50%,
      var(--_g) 100% 50%;
    background-size: calc(100% / 3) 50%;
    animation: l3 1s infinite linear;
  }
  
  @keyframes l3 {
    20% {
      background-position: 0% 0%, 50% 50%, 100% 50%;
    }
    40% {
      background-position: 0% 100%, 50% 0%, 100% 50%;
    }
    60% {
      background-position: 0% 50%, 50% 100%, 100% 0%;
    }
    80% {
      background-position: 0% 50%, 50% 50%, 100% 100%;
    }
  }
  
  /* Toggle Button */
  .toggle-btn {
    position: fixed;
    bottom: 20px;
    right: 20px;
    padding: 10px 15px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
  }
  
  .toggle-btn:hover {
    background: #0056b3;
  }
  </style>
  