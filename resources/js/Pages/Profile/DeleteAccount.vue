<script setup>
import { ref } from 'vue'
import { Head, useForm, Link } from '@inertiajs/vue3'

// Form setup
const form = useForm({
  password: '',
})

// State
const showConfirm = ref(false)

// Handle delete request
const submit = () => {
  form.delete(route('profile.destroy'), {
    onFinish: () => {
      form.reset('password')
      showConfirm.value = false
    }
  })
}
</script>

<template>
  <Head title="Delete Account" />

  <div class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-8">

        <!-- Card -->
        <div class="card shadow-sm border-danger">
          <div class="card-header bg-danger text-white fw-bold">
            Delete Account
          </div>
          <div class="card-body">
            <h5 class="card-title text-danger fw-bold">⚠️ Are you sure you want to delete your account?</h5>
            <p class="card-text">
              Once your account is deleted, all of your data—including your profile information
              and activity history—will be permanently removed. This action <strong>cannot be undone.</strong>
            </p>

            <ul style="list-style-type: disc; padding-left: 1.5rem;">
              <li>Your profile and data will be erased.</li>
              <li>You won’t be able to recover your account later.</li>
              <li>Your posts will be deleted.
              </li>
            </ul>

            <div class="mt-4">
              <button class="btn btn-outline-danger" @click="showConfirm = true">
                Delete My Account
              </button>

              <Link :href="route('profile')" class="btn btn-secondary ms-2">
                Cancel
              </Link>
            </div>
          </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" tabindex="-1" :class="{ show: showConfirm }" style="display: block;" v-if="showConfirm">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Confirm Account Deletion</h5>
                <button type="button" class="btn-close" @click="showConfirm = false"></button>
              </div>
              <div class="modal-body">
                <p>
                  Please confirm your password to permanently delete your account.
                </p>

                <div class="mb-3">
                  <label for="password" class="form-label">Password</label>
                  <input
                    v-model="form.password"
                    type="password"
                    class="form-control"
                    id="password"
                    placeholder="Enter your password"
                    :class="{ 'is-invalid': form.errors.password }"
                  />
                  <div class="invalid-feedback">
                    {{ form.errors.password }}
                  </div>
                </div>
              </div>
              <div class="modal-footer">
                <button class="btn btn-secondary" @click="showConfirm = false">Cancel</button>
                <button class="btn btn-danger" :disabled="form.processing" @click="submit">
                  <span v-if="form.processing" class="spinner-border spinner-border-sm me-2"></span>
                  Confirm Delete
                </button>
              </div>
            </div>
          </div>
        </div>
        <!-- Modal Backdrop -->
        <div class="modal-backdrop fade show" v-if="showConfirm"></div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.modal {
  background-color: rgba(0, 0, 0, 0.5);
}
</style>
