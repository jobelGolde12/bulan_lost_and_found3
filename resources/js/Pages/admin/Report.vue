
<script setup>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import {useForm} from "@inertiajs/vue3";
import { usePage, Head } from "@inertiajs/vue3";
import { computed, ref } from "vue";
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
});

const user = usePage().props.auth?.user;

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

const preventDefault = (e) => {
  e.preventDefault();
  dragState.value = true;
};

const updateDragState = (state) => {
  dragState.value = state;
};

const handleFileDrop = (e) => {
  e.preventDefault();
  updateDragState(false);
  const files = e.dataTransfer.files;
  if (files.length) {
    form.image = files[0];
  }
};

const handleFileChange = (e) => {
  const files = e.target.files;
  if (files.length) {
    form.image = files[0];
  }
};

const triggerFileInput = () => {
  fileInput.value.click();
};

const submitForm = () => {
  isSubmitting.value = true;

  form.transform((data) => {
  const formData = new FormData();
  for (const key in data) {
    if (key === 'image' && !data[key]) continue; 
    // Kapag wara in provide c user na image eh continue nalang para maging null sa backend para ma butangan default na image
    formData.append(key, data[key]);
  }
  return formData;
}).post(route("addItem"), {
    onSuccess: () => {
    isSubmitting.value = false;
      alert("Submitted!");
      // setTimeout(() => {
      //   isSubmitting.value = false;
      // }, 3000);
    },
    onError: (e) => {
       isSubmitting.value = false;
       console.error("An error while posting item: ", e)
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
</style>


<template>
  <Head title="Report Item" />
  <AdminLayout>
    <div class="main-container">
      <h1 class="text-3xl font-light text-center mt-6">Report Item</h1>

      <div class="container mx-auto px-6 py-8">
        <form @submit.prevent="submitForm" class="form space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="text-gray-600 block mb-2">Item Name</label>
              <input
                type="text"
                placeholder="e.g., Wallet"
                class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                v-model="form.name"
                required
              />
            </div>
            <div>
              <label class="text-gray-600 block mb-2">Location</label>
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
            </div>
            <div>
              <label class="text-gray-600 block mb-2">Item Description</label>
              <textarea
                placeholder="e.g., Brown wallet with initials, found in Zone 3."
                class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                v-model="form.description"
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
                  :value="data.name"
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

  <!-- <LoadingComponent v-if="isSubmitting" /> -->
</template>

