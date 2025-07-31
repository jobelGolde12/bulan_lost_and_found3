<template>
  <Head title="Contact Admin" />
  <div class="main-container bg-light">
      <div class="container d-flex justify-content-center align-items-center">
          <div class="card p-5 rounded-4 border-0 w-100" style="max-width: 600px; background: #f9f9f9;">
              <h3 class="text-center mb-4 text-dark fw-bold">Contact Admin</h3>
              <form @submit.prevent="submitForm">
                  <div class="mb-3">
                      <label for="name" class="form-label fw-medium">Name</label>
                      <input type="text" id="name" class="form-control rounded-3 px-3" v-model="form.name" required>
                  </div>
                  
                  <div class="mb-3">
                      <label for="email" class="form-label fw-medium">Email</label>
                      <input type="email" id="email" class="form-control rounded-3 px-3" v-model="form.email" required>
                  </div>
                  
                  <div class="mb-3">
                      <label for="message" class="form-label fw-medium">Message</label>
                      <textarea id="message" class="form-control rounded-3 px-3" v-model="form.message" rows="4" required></textarea>
                  </div>
                  
                  <button type="submit" class="btn btn-primary w-100 rounded-3 py-2 fw-bold" :disabled="loading">
                      {{ loading ? 'Sending...' : 'Send Message' }}
                  </button>
              </form>
          </div>
      </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import { Head, useForm } from '@inertiajs/vue3';

const form = useForm({
  name: '',
  email: '',
  message: ''
});

const loading = ref(false);

const submitForm = () => {
  loading.value = true;
  form.post(route('sendMessage'), {
      onSuccess: () => {
          alert('Message Sent Successfully!');
          form.reset();
      },
      onError: (errors) => {
          alert('Failed to send message. Please try again.');
          console.error(errors);
      },
      onFinish: () => {
          loading.value = false;
      }
  });
};
</script>

<style scoped>
@import "../../../css/global.css";
.main-container{
  width: 100vw;
  height: 100vh;
  overflow-x: hidden;
}
.container {
  min-height: 100vh;
}
.card {
  background: transparent;
  border-radius: 16px;
  width: 100%;
}
.form-control {
  border: 2px solid #e0e0e0;
  transition: all 0.3s ease-in-out;
  font-size: 1rem;
  padding: 12px;
}
.form-control:focus {
  border-color: #007bff;
  box-shadow: 0 0 8px rgba(0, 123, 255, 0.2);
}
.btn-primary {
  background: linear-gradient(135deg, #007bff, #0056b3);
  border: none;
}
.btn-primary:hover {
  background: linear-gradient(135deg, #0056b3, #004494);
}
</style>
