<script setup>
import { ref, watch } from "vue";
import { Link, useForm, Head, router, usePage } from "@inertiajs/vue3";
import CustomModal from "@/Components/CustomModal.vue";
import { Inertia } from "@inertiajs/inertia";
import ViewItemInfoHeader from "@/Components/ViewItemInfoHeader.vue";
import GuestLayout from "@/Layouts/GuestLayout.vue";

const props = defineProps({
  item: {
    type: Object,
    default: () => ({}),
  },
  created_by: {
    type: Object,
    default: () => ({}),
  },
  profile: {
    type: String,
    default: "",
  },
  comments: {
    type: Array,
    default: () => [],
  },
  currentUser: {
    type: Number,
    default: null,
  },
});

const page = usePage();
const currentUserId = ref(null);
const data = ref({});
const getProfile = ref("");
const getComment = ref([]);
const getCreatedBy = ref();
const showModal = ref(false);

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
  () => props.profile,
  (newItem) => {
    getProfile.value = newItem;
  },
  { immediate: true }
);
watch(
  () => props.comments,
  (newItem) => {
    getComment.value = newItem;
  },
  { immediate: true }
);
watch(
  () => props.currentUser,
  (id) => {
    currentUserId.value = id;
  },
  { immediate: true }
);

const commentForm = useForm({
  user_id: String(props.created_by?.id || ""),
  item_id: String(props.item?.id || ""),
  content: "",
});

const addComment = () => {
  commentForm.post(route("comment.store", { item: data?.value?.id }), {
    onSuccess: () => {
      commentForm.reset("content");
    },
    onError: (err) => {
      console.error("an error occurred => ", err);
    },
  });
};

const formatDate = (dateString) => {
  const options = { year: "numeric", month: "long", day: "numeric" };
  return new Date(dateString).toLocaleDateString(undefined, options);
};

const activeActionCommentId = ref(null);

const toggleActionMenu = (commentId) => {
  activeActionCommentId.value =
    activeActionCommentId.value === commentId ? null : commentId;
};

const deleteComment = (getId) => {
  Inertia.delete(route("comment.delete", { id: getId }), {
    onSuccess: () => {
      getComment.value = getComment?.value.filter(
        (comment) => comment.id != getId
      );
    },
    onError: (err) => {
      alert("an error occurred while deleting data => ", err);
    },
  });
};
</script>

<template>
  <Head title="View Item Info" />
  <GuestLayout>
    <div class="main-container">
      <div class="container">
        <div class="bg-white rounded-lg shadow-md w-full max-w-3xl p-6">
          <div v-if="Object.keys(data).length > 0">
            <ViewItemInfoHeader
              :created_by="props.created_by"
              :getProfile="getProfile"
              :data="data"
              :title="data.title"
              :description="data.description"
            />

            <!-- Image with hover button -->
            <div class="image-wrapper mb-6 position-relative w-100">
              <img
                :src="data.image_url"
                alt="Item Image"
                class="rounded "
              />
              <button
                class="btn btn-primary view-full-btn"
                data-bs-toggle="modal"
                data-bs-target="#imageModal"
              >
                View Full Image
              </button>
            </div>

            <!-- Modal -->
            <div
              class="modal fade"
              id="imageModal"
              tabindex="-1"
              aria-labelledby="imageModalLabel"
              aria-hidden="true"
            >
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5" id="imageModalLabel">
                      Full Image View
                    </h1>
                    <button
                      type="button"
                      class="btn-close"
                      data-bs-dismiss="modal"
                      aria-label="Close"
                    ></button>
                  </div>
                  <div class="modal-body text-center">
                    <img
                      :src="data.image_url"
                      alt="Full Image"
                      class="img-fluid rounded"
                       style="object-fit: contain;"
                    />
                  </div>
                  <div class="modal-footer">
                    <button
                      type="button"
                      class="btn btn-secondary"
                      data-bs-dismiss="modal"
                    >
                      Close
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <div class="text-end date">
              {{ formatDate(data.reported_at) }}
            </div>

            <div class="text-sm text-gray-700 space-y-1 d-none d-lg-block">
              <p class="mb-0">
                <strong>Location:</strong> {{ data.location }}
              </p>
              <p>
                <strong>Phone number:</strong>
                {{ data.owner_phone_number || "NA" }}
              </p>
              <p v-if="data.category">
                <strong>Category:</strong> {{ data.category || "NA" }}
              </p>
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

            <div class="text-sm text-gray-700 space-y-1 d-block d-lg-none">
              <p class="mb-0">
                <i class="bi bi-geo-alt-fill me-2"></i>{{ data.location }}
              </p>
              <p>
                <i class="bi bi-telephone-fill me-2"></i>
                {{ data.owner_phone_number || "NA" }}
              </p>
              <p v-if="data.category">
                <i class="bi bi-bookmark-fill me-2"></i
                >{{ data.category || "NA" }}
              </p>
              <p>
                <i class="bi bi-info-circle-fill me-2"></i
                ><span
                  :class="
                    data.status === 'Lost'
                      ? 'text-red-600 font-semibold'
                      : 'text-green-600'
                  "
                  >{{ data.status }}</span
                >
              </p>
            </div>

            <!-- Comment section -->
            <div class="container-fluid comment-main-container">
              <form
                @submit.prevent="addComment"
                class="form d-flex flex-row gap-4 align-items-center"
              >
                <div class="mt-2">
                  <img
                    src="../../../../images/profile.jpeg"
                    alt="User"
                    class="profile-pic-in-comment"
                    style="width: 45px; transform: translateY(8%);"
                  />
                </div>

                <div class="w-100 mt-3 d-flex flex-row gap-1">
                  <input
                    type="text"
                    class="form-control w-100 py-2"
                    placeholder="Login to add a comment"
                    disabled
                  />
                  <button class="btn btn-success" type="submit" disabled>
                    Post
                  </button>
                </div>
              </form>

              <div
                class="container my-3 px-0 mx-0 comment-container d-flex flex-column gap-2"
                v-if="getComment"
              >
                <div
                  class="comment p-3 rounded"
                  v-for="data in getComment"
                  :key="data.id"
                >
                  <div
                    class="d-flex flex-row justify-content-between align-items-center"
                  >
                    <div class="profile-in-comment">
                      <img
                        src="../../../../images/profile.jpeg"
                        alt=""
                      />
                    </div>
                    <div class="date d-flex align-items-center gap-2">
                      <p class="d-inline-block">
                        {{ formatDate(data.created_at) || "No date available" }}
                      </p>
                      <i
                        class="bi bi-three-dots-vertical d-inline-block action-in-comment"
                        v-if="data?.user_id === currentUserId"
                        @click="toggleActionMenu(data.id)"
                      ></i>
                    </div>

                    <div
                      class="action-container rounded py-2 px-4"
                      v-if="activeActionCommentId === data.id"
                    >
                      <div @click="deleteComment(data.id)" class="text-dark">
                        Delete
                      </div>
                    </div>
                  </div>

                  <div class="content-container mt-4">
                    {{ data.content || "None" }}
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div v-else>
            <p>Loading item details...</p>
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<style scoped>
@import "../../../../css/viewItemInfo.css";

.image-wrapper {
  position: relative;
  display: inline-block;
  overflow: hidden;
}

.view-full-btn {
  position: absolute;
  bottom: 10px;
  right: 10px;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.image-wrapper:hover .view-full-btn {
  opacity: 1;
}

.image-item {
  transition: transform 0.3s ease;
  cursor: pointer;
}

.image-wrapper:hover .image-item {
  transform: scale(1.02);
}
</style>
