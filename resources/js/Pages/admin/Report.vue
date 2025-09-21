<script setup>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import { useForm } from "@inertiajs/vue3";
import { usePage, Head } from "@inertiajs/vue3";
import { computed, ref, watch } from "vue";
import LoadingComponent from "@/Components/LoadingComponent.vue";

const props = defineProps({
  categories: {
    type: Object,
    default: () => ({}),
  },
  locations: {
    type: Array,
    default: () => [],
  },
  errors: Object,
});

const user = usePage().props.auth?.user;
const page = usePage();
const hasProfanity = ref(false);

// Watch for errors and flash messages
watch(() => page.props.errors, (newErrors) => {
  if (newErrors && newErrors.description) {
    hasProfanity.value = true;
  }
}, { immediate: true });

watch(() => page.props.flash, (newFlash) => {
  if (newFlash && newFlash.hasProfanity) {
    hasProfanity.value = true;
  }
}, { immediate: true });

const form = useForm({
  name: "",
  image: null,
  description: "",
  category: "",
  location: "",
  user_id: user.id,
  owner_phone_number: "",
  status: "lost",
});

const locations = computed(() => props.locations);
const dragState = ref(false);
const fileInput = ref(null);
const isSubmitting = ref(false);
const errorMessage = ref(null);
const maxSize = 5 * 1024 * 1024;
const allowedTypes = ["image/jpeg", "image/png", "image/jpg", "image/gif", "image/svg+xml"];

const preventDefault = (e) => {
  e.preventDefault();
  dragState.value = true;
};

const updateDragState = (state) => {
  dragState.value = state;
};

const validateFile = (file) => {
  errorMessage.value = null;

  if (!allowedTypes.includes(file.type)) {
    errorMessage.value = "Invalid file type. Only JPEG, PNG, JPG, GIF, or SVG are allowed.";
    form.image = null;
    return;
  }

  if (file.size > maxSize) {
    errorMessage.value = "Image must not be larger than 5MB.";
    form.image = null;
    return;
  }

  form.image = file;
};

const handleFileDrop = (e) => {
  e.preventDefault();
  updateDragState(false);
  const files = e.dataTransfer.files;
  if (files.length) {
    validateFile(files[0]);
  }
};

const handleFileChange = (e) => {
  const files = e.target.files;
  if (files.length) {
    validateFile(files[0]);
  }
};

const triggerFileInput = () => {
  fileInput.value.click();
};

const submitForm = () => {
  isSubmitting.value = true;
  hasProfanity.value = false;

  form.transform((data) => {
    const formData = new FormData();
    for (const key in data) {
      if (key === 'image' && !data[key]) continue;
      formData.append(key, data[key]);
    }
    return formData;
  }).post(route("addItem"), {
    onSuccess: () => {
      isSubmitting.value = false;
      alert("Submitted!");
    },
    onError: (errors) => {
      isSubmitting.value = false;
      console.error("An error while posting item: ", errors);
      
      if (errors && errors.description) {
        hasProfanity.value = true;
      }
    },
  });
};
</script>

<template>
  <Head title="Report Item" />
  <AdminLayout>
    <div class="main-container">
      <h1 class="text-3xl font-light text-center mt-6">Report Item</h1>

      <div class="container mx-auto px-6 py-8">
        <!-- Bootstrap Alert for Profanity Error -->
        <div v-if="hasProfanity" class="alert alert-danger alert-dismissible fade show" role="alert">
          <strong>Profanity Detected!</strong> {{ page.props.errors?.description || 'Your content contains inappropriate language.' }}
          <button type="button" class="btn-close" @click="hasProfanity = false" aria-label="Close"></button>
        </div>

        <form @submit.prevent="submitForm" class="form space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="text-gray-600 block mb-2">Lost or found name</label>
              <input
                type="text"
                placeholder="e.g., Wallet"
                class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                v-model="form.name"
                required
              />
            </div>
            <div>
              <label class="text-gray-600 block mb-2">Location (Where did lost or found it?)</label>
              <select
                class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                v-model="form.location"
                required
              >
                <option disabled value="">Select a location</option>
                <option v-for="loc in locations" :key="loc" :value="loc.name">
                  {{ loc.name }}
                </option>
              </select>
            </div>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="text-gray-600 block mb-2">Item Image (Optional)</label>
              <div
                class="border-2 rounded-lg p-6 text-center cursor-pointer hover:border-blue-400 focus:ring-2 focus:ring-blue-400"
                :class="dragState ? 'border-blue-400' : 'border-gray-400'"
                @dragover="preventDefault"
                @dragenter="preventDefault"
                @dragleave="() => updateDragState(false)"
                @drop="handleFileDrop"
              >
                <p class="text-gray-500" v-if="!form.image">Drag & Drop your image here or</p>
                <p class="text-green-500" v-if="form.image">Image selected: {{ form.image.name }}</p>
                <input
                  type="file"
                  accept="image/*"
                  class="hidden"
                  ref="fileInput"
                  @change="handleFileChange"
                />
                <button
                  type="button"
                  class="text-blue-500 underline"
                  @click="triggerFileInput"
                >
                  Browse
                </button>
              </div>
              <p v-if="errorMessage" class="text-red-500 mt-2">
                {{ errorMessage }}
              </p>
              <p class="text-muted mt-2">Maximum of 5MB</p>
            </div>
            <div>
              <label class="text-gray-600 block mb-2"> Description</label>
              <textarea
                placeholder="e.g., Brown wallet with initials, found in Zone 3."
                class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                :class="{'border-red-500': hasProfanity}"
                v-model="form.description"
                required
              ></textarea>
            </div>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="text-gray-600 block mb-2">Category</label>
              <select
                class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                v-model="form.category"
                required
              >
                <option disabled value="">Select a category</option>
                <option
                  v-for="data in props.categories"
                  :key="data.id"
                  :value="data.id"
                >
                  {{ data.name }}
                </option>
              </select>
            </div>
            <div>
              <label class="text-gray-600 block mb-2">Your Phone Number (Optional)</label>
              <input
                type="text"
                placeholder="e.g., 09461284345"
                class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                v-model="form.owner_phone_number"
              />
            </div>
          </div>

          <div>
            <label class="text-gray-600 block mb-2">Status</label>
            <select
              class="w-100 p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
              v-model="form.status"
            >
              <option value="found">Found</option>
              <option value="lost">Lost</option>
            </select>
          </div>

          <button
            type="submit"
            class="w-100 btn btn-dark py-3"
            :disabled="isSubmitting"
          >
            {{ isSubmitting ? "Submitting..." : "Submit" }}
          </button>
        </form>
      </div>
    </div>
  </AdminLayout>

  <LoadingComponent v-if="isSubmitting" />
</template>

<style scoped>
.main-container {
  width: 100%;
  height: 100%;
  overflow-x: hidden;
}

.alert-danger {
  color: #721c24;
  background-color: #f8d7da;
  border-color: #f5c6cb;
  padding: 0.75rem 1.25rem;
  margin-bottom: 1rem;
  border: 1px solid transparent;
  border-radius: 0.25rem;
}

.alert-dismissible .btn-close {
  position: absolute;
  top: 0;
  right: 0;
  padding: 0.75rem 1.25rem;
  color: inherit;
}

.btn-close {
  background: transparent url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%23000'%3e%3cpath d='M.293.293a1 1 0 011.414 0L8 6.586 14.293.293a1 1 0 111.414 1.414L9.414 8l6.293 6.293a1 1 0 01-1.414 1.414L8 9.414l-6.293 6.293a1 1 0 01-1.414-1.414L6.586 8 .293 1.707a1 1 0 010-1.414z'/%3e%3c/svg%3e") center/1em auto no-repeat;
  border: 0;
  border-radius: 0.25rem;
  opacity: 0.5;
  width: 1em;
  height: 1em;
}

.btn-close:hover {
  opacity: 0.75;
}
</style>