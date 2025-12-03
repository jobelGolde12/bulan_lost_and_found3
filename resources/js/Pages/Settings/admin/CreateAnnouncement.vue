<script setup>
import { ref } from 'vue';
import { Inertia } from '@inertiajs/inertia';
import { Head } from '@inertiajs/vue3';
import AdminSettingsLayout from '@/Layouts/settings/AdminSettingsLayout.vue';

const form = ref({
  title: '',
  content: ''
});

const errors = ref({});

const submitForm = () => {
  Inertia.post(route('settings.announcements.store'), form.value, {
    onError: (errorMessages) => {
      errors.value = errorMessages;
    },
    onSuccess: () => {
      form.value.title = '';
      form.value.content = '';
      errors.value = {};
    }
  });
   alert("Created successfully...");
};
</script>
<template>
  <AdminSettingsLayout>
    <Head title="Add Announcement" />
    <div class="container mt-5">
      <h1 class="text-center mb-4">Create Announcement</h1>
      <form @submit.prevent="submitForm" class="shadow p-4 rounded bg-white">
        <div class="mb-3">
          <label for="title" class="form-label">Title</label>
          <input
            type="text"
            id="title"
            v-model="form.title"
            class="form-control"
            :class="{ 'is-invalid': errors.title }"
            placeholder="Enter the announcement title"
            required
          />
          <div v-if="errors.title" class="invalid-feedback">{{ errors.title }}</div>
        </div>

        <div class="mb-3">
          <label for="content" class="form-label">Content</label>
          <textarea
            id="content"
            v-model="form.content"
            class="form-control"
            :class="{ 'is-invalid': errors.content }"
            rows="5"
            placeholder="Enter the announcement content"
            required
          ></textarea>
          <div v-if="errors.content" class="invalid-feedback">{{ errors.content }}</div>
        </div>

        <button type="submit" class="btn btn-primary w-100">Create Announcement</button>
      </form>
    </div>
  </AdminSettingsLayout>
</template>

<style>
body {
  background-color: #f8f9fa;
}
form {
  max-width: 600px;
  margin: 0 auto;
}
</style>