<script setup>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import { useForm } from "@inertiajs/inertia-vue3";
import { usePage, Head } from "@inertiajs/vue3";
import { computed, defineProps, onMounted, ref } from "vue";

const props = defineProps({
  categories: {
    type: Object,
    default: {},
  },
  locations: {
    type: Array,
    default: [],
  },
});

const user = usePage().props.auth?.user;
const getCategories = ref([]);
const form = useForm({
  name: "",
  image: null,
  description: "",
  category: "",
  location: "",
  user_id: user.id,
  owner_phone_number: "",
  status: "found",
});

const locations = computed(() => props.locations);

onMounted(() => {
  getCategories.value = props.categories;
});

const handleFileDrop = (event) => {
  event.preventDefault();
  const file = event.dataTransfer.files[0];
  if (file) {
    form.image = file;
    updateDragState(false);
  }
};

const handleFileChange = (event) => {
  const file = event.target.files[0];
  if (file) {
    form.image = file;
    updateDragState(false);
  }
};

const preventDefault = (event) => {
  event.preventDefault();
  updateDragState(true);
};

const dragState = ref(false);
const updateDragState = (isDragging) => {
  dragState.value = isDragging;
};

const submitForm = () => {
  form.post(route("addItem"), {
    onSuccess: () => alert("Submitted!"),
    onError: (errors) => console.log("error: " + errors),
  });
};
</script>

<template>
  <Head title="Report Found Item" />
  <AdminLayout>
    <div class="main-container">
      <h1 class="text-3xl font-light text-center mt-6">Report Found Item</h1>

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
              />
            </div>
            <div>
              <label class="text-gray-600 block mb-2">Location</label>
              <select
                class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400"
                v-model="form.location"
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
                  @change="handleFileChange"
                />
                <button
                  type="button"
                  class="text-blue-500 underline"
                  @click="$el.querySelector('input[type=file]').click()"
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

          <button
            type="submit"
            class="w-100 btn btn-dark py-3"
          >
            Submit
          </button>
        </form>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.main-container {
  width: 100%;
  height: 100%;
  overflow-x: hidden;
}
</style>
