<script setup>
import { defineEmits } from "vue";
import { router } from "@inertiajs/vue3";

// Emit close event to parent
const emit = defineEmits(["close"]);

const goTo = (routeName) => {
  emit("close"); // Close modal first
  router.visit(route(routeName)); // Then navigate
};
</script>

<template>
  <div class="modal-overlay" @click.self="emit('close')">
    <div class="modal-content">
      <!-- Close button -->
      <button class="close-btn" @click="emit('close')">×</button>

      <!-- Modal body -->
      <div class="text-center p-6">
        <img
          src="../../../images/guest/undraw_secure-login_m11a.svg"
          class="icon"
          alt="Login Icon"
        />

        <h2 class="text-2xl font-semibold text-gray-800">
          Login to get started
        </h2>
        <p class="mt-2 text-gray-500 text-sm">
          Access your account to explore more features and manage your content.
        </p>

        <!-- Buttons -->
        <div class="mt-6 space-y-2">
          <button class="btn btn-dark w-100" @click="goTo('login')">
            Login
          </button>
          <p class="text-muted mt-2 text-center">
            Didn't have an account?
            <button class="btn btn-link" @click="goTo('register')">
              Signup
            </button>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Overlay */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.65);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1050;
  animation: fadeIn 0.2s ease-in-out;
}

/* Modal box */
.modal-content {
  background: #fff;
  border-radius: 12px;
  width: 100%;
  max-width: 450px;
  padding: 1.5rem;
  position: relative;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.25);
  animation: slideUp 0.25s ease-in-out;
}

/* Close icon */
.close-btn {
  position: absolute;
  top: 10px;
  right: 14px;
  font-size: 1.5rem;
  background: none;
  border: none;
  color: #444;
  cursor: pointer;
  transition: color 0.2s;
}

.close-btn:hover {
  color: #000;
}

/* Buttons */
.btn-dark {
  background-color: #222;
  color: #fff;
  padding: 0.6rem 1rem;
  border-radius: 6px;
  border: none;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-dark:hover {
  background-color: #000;
}

.btn-link {
  background: none;
  border: none;
  color: #007bff;
  text-decoration: underline;
  cursor: pointer;
  font-weight: 500;
  padding: 0;
}

.icon {
  height: 200px;
}

/* Animations */
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

@keyframes slideUp {
  from {
    transform: translateY(20px);
    opacity: 0.8;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}
</style>
