<script setup>
import { ref, watch } from "vue";
import { Link, Head, router } from "@inertiajs/vue3";
import AdminLayout from "@/Layouts/AdminLayout.vue";
import { Inertia } from "@inertiajs/inertia";

const props = defineProps({
  item: {
    type: Object,
    default: () => ({}),
  },
  created_by: {
    type: Object,
    default: () => ({}),
  },
  profile_pic: {
    type: String,
    default: "",
  },
});

const data = ref({});
const getProfile = ref("");
const getCreatedBy = ref();
const expanded = ref(false); // for see more / see less toggle

watch(
  () => props.created_by?.id,
  (newItem) => {
    getCreatedBy.value = newItem;
  },
  { immediate: true }
);

watch(
  () => props.item,
  (newItem) => {
    data.value = newItem;
  },
  { immediate: true }
);

watch(
  () => props.profile_pic,
  (newItem) => {
    getProfile.value = newItem;
  },
  { immediate: true }
);

const approve = () => {
  router.post(route("approverequest", { item: data.value?.id }), {
    onSuccess: () => alert("Updated successfully..."),
  });
};

const deny = () => {
  router.visit(route("deny.request.view", { item: data.value?.id }));
};

const f2fVerification = () => {
  router.post(route("f2f.verification", { item: data.value?.id }), {
    onSuccess: () => alert("Face-to-face verification success"),
  });
};

// Helper function to limit description
const getDisplayDescription = (desc) => {
  if (!desc) return "";
  const words = desc.split(" ");
  if (words.length <= 9) return desc;
  if (expanded.value) return desc;
  return words.slice(0, 9).join(" ") + "...";
};
</script>

<template>
  <Head title="View Item Info" />
  <AdminLayout>
    <div class="main-container">
      <div class="container">
        <div class="bg-white rounded-lg shadow-md w-full max-w-3xl p-6">
          <div v-if="Object.keys(data).length > 0">
            <div class="mb-6">
              <img
                :src="data.image_url || '../../../images/noImage.jpg'"
                alt="Item Image"
                class="mx-auto rounded object-cover image-item"
              />
            </div>

            <div class="flex justify-between items-center">
              <div class="d-flex flex-column w-50">
                <h2 class="text-xl font-semibold mb-0 d-block">
                  {{ data?.title || "Unnamed Item" }}
                </h2>

                <p class="description">
                  <span class="fw-semibold">Description: </span>
                  {{ getDisplayDescription(data?.description) }}
                  <span
                    v-if="data?.description && data.description.split(' ').length > 9"
                    class="see-more"
                    @click="expanded = !expanded"
                  >
                    {{ expanded ? "See less" : "See more" }}
                  </span>
                </p>
              </div>

              <Link
                v-if="props.created_by?.id"
                :href="route('viewUserAsAdmin', { id: props.created_by.id })"
                class="text-decoration-none d-flex align-items-center justify-content-end gap-2 w-50"
              >
                <img
                  :src="
                    getProfile
                      ? `/storage/${getProfile}`
                      : '../../../images/noImage.jpg'
                  "
                  alt="User"
                  class="profile-pic rounded-full"
                />
                <span class="text-sm font-medium text-gray-700">{{
                  created_by?.name || "Unknown user"
                }}</span>
              </Link>
            </div>

            <div class="text-sm text-gray-700 space-y-1 mt-3">
              <p class="mb-0"><strong>Location:</strong> {{ data.location }}</p>
              <p><strong>Phone number:</strong> {{ data.owner_phone_number || "N/A" }}</p>
              <p v-if="data.category"><strong>Category:</strong> {{ data.category || "N/A" }}</p>
              <p>
                <strong>Status:</strong>
                <span
                  :class="
                    data.status === 'Lost'
                      ? 'text-red-600 font-semibold'
                      : 'text-green-600'
                  "
                  >{{ data.status }}</span
                >
              </p>
            </div>

            <div
              class="container-fluid ps-0 d-flex flex-row align-items-center gap-2 mt-3"
            >
              <button @click="approve" class="btn btn-success">Approve</button>
              <button @click="deny" class="btn btn-warning">Deny</button>
              <button
                @click="f2fVerification"
                title="The system will send notification to the user"
                class="btn btn-success f2f"
              >
                Face to Face Verification
              </button>
            </div>
          </div>
          <div v-else>
            <p>Loading item details...</p>
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
* {
  font-family: "Poppins", sans-serif;
}
.image-item {
  width: 60%;
  max-height: 30%;
  position: relative;
}
.main-container {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: row;
  overflow-y: scroll;
}
.main-container .container {
  position: relative;
  width: 600px;
  max-height: 400px;
}
.container img {
  position: relative;
  width: 100%;
  max-height: 400px;
}
.description {
  font-size: 0.85rem;
  line-height: 1.4;
}
.profile-pic {
  max-width: 35px;
  height: 35px;
  border-radius: 50%;
}
.f2f {
  background: #305644;
}
.see-more {
  color: #007bff;
  cursor: pointer;
  font-weight: 500;
  margin-left: 5px;
}
</style>
