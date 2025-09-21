<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import {useForm} from "@inertiajs/vue3";
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

// Watch for errors and flash messages for profanity detection
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

const maxSize = 5 * 1024 * 1024; // 5 MB
const allowedTypes = ["image/jpeg", "image/png", "image/jpg", "image/gif", "image/svg+xml"];

const preventDefault = (e) => {
  e.preventDefault();
  dragState.value = true;
};

const updateDragState = (state) => {
  dragState.value = state;
};

const validateFile = (file) => {
  if (!allowedTypes.includes(file.type)) {
    errorMessage.value = "Invalid file format. Only jpeg, png, jpg, gif, and svg are allowed.";
    form.image = null;
    return false;
  }
  if (file.size > maxSize) {
    errorMessage.value = "File too large. Maximum allowed size is 5MB.";
    form.image = null;
    return false;
  }
  errorMessage.value = null;
  return true;
};

const handleFileDrop = (e) => {
  e.preventDefault();
  updateDragState(false);
  const files = e.dataTransfer.files;
  if (files.length && validateFile(files[0])) {
    form.image = files[0];
  }
};

const handleFileChange = (e) => {
  const files = e.target.files;
  if (files.length && validateFile(files[0])) {
    form.image = files[0];
  }
};

const triggerFileInput = () => {
  fileInput.value.click();
};

const submitForm = () => {
  if (errorMessage.value) {
    alert("Please fix the file error before submitting.");
    return;
  }

  isSubmitting.value = true;
  hasProfanity.value = false; // Reset profanity flag on new submission

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
      alert("Submitted! your item will be reviewed by admin. We will notify you once your item is approved.");
    },
    onError: (e) => {
      isSubmitting.value = false;
      console.error("An error while posting item: ", e);
      
      // Check if it's a profanity error
      if (e && e.description) {
        hasProfanity.value = true;
      }
    },
  });
};
</script>

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

<template>
  <Head title="Report Item" />
  <AuthenticatedLayout>
    <div class="main-container">
      <h1 class="text-3xl font-light text-center mt-6">Report Item</h1>

      <div class="container mx-auto px-6 py-8">
        <!-- Bootstrap Alert for Profanity Error -->
        <div v-if="hasProfanity" class="alert alert-danger alert-dismissible fade show" role="alert">
          <strong>Profanity Detected!</strong> {{ page.props.errors?.description || 'Your content contains inappropriate language.' }}
          <button type="button" class="btn-close" @click="hasProfanity = false" aria-label="Close"></button>
        </div>

        <form @submit.prevent="submitForm" class="form space-y-6">
          <!-- Item Name & Location -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="text-gray-600 block mb-2">Lost or Found Name</label>
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

          <!-- Image & Description -->
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
              <!-- Error message -->
              <p v-if="errorMessage" class="text-red-500 mt-2">{{ errorMessage }}</p>
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

          <!-- Category & Phone -->
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

          <!-- Status -->
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

          <!-- Submit -->
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
  </AuthenticatedLayout>
</template>