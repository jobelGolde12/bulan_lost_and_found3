<script setup>
import { router, usePage, Head } from '@inertiajs/vue3'
import { ref, onMounted } from 'vue'
import AdminLayout from '@/Layouts/AdminLayout.vue'
const props = defineProps({
  totalItems: Number, // passed from controller
})

const showCleaner = ref(false)

// check if remember-me exists
onMounted(() => {
  const remember = localStorage.getItem('storageCleanerRemember')
  if (!remember && props.totalItems > 1000) {
    showCleaner.value = true
  }
})

// delete all claimed items but keep title, location, user_id
const deleteClaimed = () => {
  router.post('/storage-cleaner/delete-claimed', {}, {
    onSuccess: () => {
      showCleaner.value = false
    }
  })
}

// deny and remember 30 days
const denyCleaner = () => {
  const expiry = new Date()
  expiry.setDate(expiry.getDate() + 30)
  localStorage.setItem('storageCleanerRemember', expiry.toISOString())
  router.get('/dashboard')
}
</script>

<template>

<AdminLayout>
<Head title="Storage Cleaner" />
  <div v-if="showCleaner" class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card shadow-sm">
          <div class="card-header bg-danger text-white text-center">
            <h4>⚠ Storage Warning</h4>
          </div>
          <div class="card-body text-center">
            <p class="lead">
              Your database currently has <strong>{{ totalItems }}</strong> items (lost, found, claimed).
            </p>
            <p class="text-muted">
              This consumes more storage and may slow down your system.
            </p>
            <hr>
            <p>
              Do you want to <strong>delete all claimed items</strong>?  
              (Essential info like <em>title, location, and user_id</em> will be kept)
            </p>

            <div class="d-flex justify-content-center gap-3 mt-4">
              <button class="btn btn-danger px-4" @click="deleteClaimed">
                Delete Claimed Items
              </button>
              <button class="btn btn-secondary px-4" @click="denyCleaner">
                Not Now (Remember 30 days)
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</AdminLayout>

</template>
