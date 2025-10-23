<script setup>
import { ref, onUnmounted, defineProps } from 'vue'
import { useForm } from '@inertiajs/vue3'

const props = defineProps({
  item: Object
})

// Initialize form. image will hold the File object when user chooses a file.
const form = useForm({
  title: props.item.title ?? '',
  description: props.item.description ?? '',
  category: props.item.category ?? '',
  location: props.item.location ?? '',
  status: props.item.status ?? 'Lost',
  contact_info: props.item.contact_info ?? '',
  owner_phone_number: props.item.owner_phone_number ?? '',
  date: props.item.date ?? null,
  image: null,           // file input
  remove_image: false,   // boolean to indicate removal of existing image
})

const fileInput = ref(null)
const previewUrl = ref(props.item.image_url ?? null)
let objectUrl = null

function onFileChange(e) {
  const file = e.target.files[0] || null
  form.image = file

  // revoke previous object URL if any
  if (objectUrl) {
    URL.revokeObjectURL(objectUrl)
    objectUrl = null
  }

  if (file) {
    objectUrl = URL.createObjectURL(file)
    previewUrl.value = objectUrl
    form.remove_image = false // if new image chosen, we don't want to remove
  } else {
    // no file selected -> restore original item image
    previewUrl.value = props.item.image_url ?? null
  }
}

function removeImage() {
  // Clear the file input and set remove flag so backend deletes any stored image
  if (fileInput.value) {
    fileInput.value.value = null
  }
  form.image = null
  form.remove_image = true
  if (objectUrl) {
    URL.revokeObjectURL(objectUrl)
    objectUrl = null
  }
  previewUrl.value = null
}

onUnmounted(() => {
  if (objectUrl) {
    URL.revokeObjectURL(objectUrl)
    objectUrl = null
  }
})

function submit() {
  form.post(route('item.update', props.item.id), {
    method: 'post', // Laravel PUT via _method below
    forceFormData: true, // forces multipart/form-data
    data: {
      ...form.data(),
      _method: 'PUT', // so Laravel treats it as PUT
    },
    preserveScroll: true,
    onFinish: () => form.reset('image'),
  })
}

</script>

<template>
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-8">
        <div class="card shadow-sm border-0 rounded-4">
          <div class="card-header d-flex align-items-center justify-content-between bg-white border-0 px-4 py-3">
            <div>
              <h4 class="mb-0">Edit Item</h4>
              <small class="text-muted">Update item information and image</small>
            </div>
            <div>
              <a :href="route('dashboard')" class="btn btn-sm btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Back
              </a>
            </div>
          </div>

          <div class="card-body p-4">
            <form @submit.prevent="submit" enctype="multipart/form-data">
              <div class="row gx-4">
                <div class="col-md-6">
                  <!-- Title -->
                  <div class="mb-3">
                    <label class="form-label fw-semibold">Title</label>
                    <input type="text" v-model="form.title" class="form-control form-control-lg" placeholder="Item title" />
                    <div class="text-danger small" v-if="form.errors.title">{{ form.errors.title }}</div>
                  </div>

                  <!-- Category -->
                  <div class="mb-3">
                    <label class="form-label fw-semibold">Category</label>
                    <input type="text" v-model="form.category" class="form-control" placeholder="Category (e.g. wallet, phone)" />
                    <div class="text-danger small" v-if="form.errors.category">{{ form.errors.category }}</div>
                  </div>

                  <!-- Status -->
                  <div class="mb-3">
                    <label class="form-label fw-semibold">Status</label>
                    <select v-model="form.status" class="form-select">
                      <option value="Lost">Lost</option>
                      <option value="Found">Found</option>
                      <option value="Claimed">Claimed</option>
                    </select>
                    <div class="text-danger small" v-if="form.errors.status">{{ form.errors.status }}</div>
                  </div>

                  <!-- Date -->
                  <div class="mb-3">
                    <label class="form-label fw-semibold">Date</label>
                    <input type="date" v-model="form.date" class="form-control" />
                    <div class="text-danger small" v-if="form.errors.date">{{ form.errors.date }}</div>
                  </div>

                  <!-- Contact & Phone -->
                  <div class="mb-3">
                    <label class="form-label fw-semibold">Contact Info</label>
                    <input type="text" v-model="form.contact_info" class="form-control" placeholder="Name / email / phone" />
                  </div>

                  <div class="mb-3">
                    <label class="form-label fw-semibold">Owner Phone Number</label>
                    <input type="text" v-model="form.owner_phone_number" class="form-control" placeholder="09XXXXXXXXX" />
                  </div>
                </div>

                <div class="col-md-6">
                  <!-- Image preview & controls -->
                  <label class="form-label fw-semibold">Image</label>

                  <div class="mb-3">
                    <div class="card rounded-3" style="min-height:180px;">
                      <div class="card-body d-flex align-items-center justify-content-center">
                        <template v-if="previewUrl">
                          <img :src="previewUrl" class="img-fluid rounded" style="max-height: 240px; object-fit: contain;" />
                        </template>
                        <template v-else>
                          <div class="text-center text-muted">
                            <i class="bi bi-image fs-1"></i>
                            <div>No image</div>
                          </div>
                        </template>
                      </div>
                    </div>
                  </div>

                  <div class="mb-3 d-flex gap-2">
                    <input
                      ref="fileInput"
                      type="file"
                      accept="image/*"
                      @change="onFileChange"
                      class="form-control"
                      style="max-width: 100%;"
                    />

                    <button type="button" class="btn btn-outline-danger" @click="removeImage" title="Remove image">
                      <i class="bi bi-trash"></i>
                    </button>
                  </div>
                  <div class="small text-muted mb-3">Allowed: jpeg, png, gif, svg — max 5MB</div>

                  <!-- Location -->
                  <div class="mb-3">
                    <label class="form-label fw-semibold">Location</label>
                    <input type="text" v-model="form.location" class="form-control" placeholder="Where it was found / lost" />
                  </div>

                </div>
              </div>

              <!-- Description -->
              <div class="mb-3 mt-3">
                <label class="form-label fw-semibold">Description</label>
                <textarea v-model="form.description" class="form-control" rows="4" placeholder="Add more details"></textarea>
                <div class="text-danger small" v-if="form.errors.description">{{ form.errors.description }}</div>
              </div>

              <!-- Buttons -->
              <div class="d-flex justify-content-end gap-2 mt-4">
                <a :href="route('dashboard')" class="btn btn-outline-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary" :disabled="form.processing">
                  <i class="bi bi-save me-2"></i> Save Changes
                </button>
              </div>
            </form>
          </div>
        </div>

        <!-- server validation errors (optional) -->
        <div v-if="Object.keys(form.errors).length" class="mt-3">
          <div class="alert alert-danger small p-2">
            <ul class="mb-0">
              <li v-for="(err, key) in form.errors" :key="key">{{ err }}</li>
            </ul>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<style scoped>
.card {
  transition: transform 0.15s ease, box-shadow 0.15s ease;
}
.card:hover {
  transform: translateY(-6px);
  box-shadow: 0 14px 40px rgba(13, 110, 253, 0.07);
}
.form-label {
  color: #0d6efd;
}
</style>
