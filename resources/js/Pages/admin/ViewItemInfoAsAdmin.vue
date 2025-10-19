<script setup>
import { ref, watch } from "vue";
import { Link, useForm, Head, router, usePage } from "@inertiajs/vue3";
import ViewItemInfoForAdminHeader from "@/Components/admin/ViewItemInfoForAdminHeader.vue";
import downloadAsPDF from "@/Components/admin/item/downloadAsPDF.vue";
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

const currentUserId = ref(null);
const data = ref({});
const getProfile = ref("");
const getComment = ref([]);
const getCreatedBy = ref();
let isHovered = ref(false);
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
    console.log("comments: ", getComment.value)

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
      // getComment.value.push(commentForm.content);
      commentForm.reset("content");
    },
    onError: () => {
      alert("Something went wrong, please try again.");
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
      alert("An error occurred while deleting data => ", err);
    },
  });
  getComment.value = getComment?.value.filter((comment) => comment.id != getId);
};

//  Loading overlay state
const isLoading = ref(false);
const loadingMessage = ref("Generating PDF, please wait...");

//  Ref to child
const pdfRef = ref(null);

const handleDownload = async () => {
  try {
    isLoading.value = true;
    await pdfRef.value.downloadPdf(); // call child component method
  } catch (e) {
    console.error(e);
    alert("PDF download failed!");
  } finally {
    isLoading.value = false;
  }
};

const getProfileImage = (profilePic) => {
  const defaultImage = '../../../images/profile.jpeg';

  // If no profile picture, use default
  if (!profilePic) return defaultImage;

  // If it's a full URL (starts with http), use it directly
  if (profilePic.startsWith('http://') || profilePic.startsWith('https://')) {
    return profilePic;
  }

  // Otherwise, assume it's stored in /storage
  return `/storage/${profilePic}`;
};

</script>

<template>
  <Head title="View Item Info" />
  <AdminLayout>
    <div class="main-container">
      <div class="container">
        <div class="bg-white rounded-lg shadow-md w-full max-w-3xl p-6">
          <div v-if="Object.keys(data).length > 0">
            <ViewItemInfoForAdminHeader
              :id="props?.created_by?.id || null"
              :item_id="props?.item.id"
              :name="props?.created_by.name"
              :title="data?.title"
              :description="data?.description"
              :profile="getProfile"
            />
      <div
          class="relative mb-6"
          @mouseenter="isHovered = true"
          @mouseleave="isHovered = false"
        >
          <img
            :src="data.image_url"
            alt="Item Image"
            class="rounded object-cover image-item"
          />
          <button
            v-if="isHovered"
            class="absolute inset-0 bg-black bg-opacity-50 text-white font-semibold transition-opacity duration-300 flex items-center justify-center rounded"
            data-bs-toggle="modal" data-bs-target="#fullView"
          >
            Full View
          </button>
        </div>
            <div class="text-end date">
              {{ formatDate(data.reported_at) }}
            </div>

                      <div class="text-sm text-gray-700 space-y-1 d-none d-lg-block">
              <p class="mb-0">
                <i class="bi bi-geo-alt-fill me-2 text-dark"></i>{{ data.location }}
              </p>
              <p>
                <i class="bi bi-telephone-fill me-2 text-dark"></i>{{ data.owner_phone_number || "NA" }}
              </p>
              <p v-if="data.category">
                <i class="bi bi-tags-fill me-2 text-dark"></i>{{ data.category || "NA" }}
              </p>
              <p>
                <i
                  class="bi me-2"
                  :class="data.status === 'Lost' ? 'bi-x-circle-fill text-danger' : 'bi-check-circle-fill text-success'"
                ></i>
                <span
                  :class="data.status === 'Lost' ? 'text-red-600 font-semibold' : 'text-green-600'"
                >
                  {{ data.status }}
                </span>
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
                <i class="bi bi-bookmark-fill me-2"></i>{{ data.category || "NA" }}
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
            <div class="comments-section mt-4">
  <!-- Comment Form -->
  <form @submit.prevent="addComment" class="comment-form">
    <div class="comment-form__header">
      <div class="comment-form__avatar">
        <img
          :src="getProfile == 'NA' ? '../../../images/profile.jpeg' : `/storage/${getProfile}`"
          alt="Your profile picture"
          class="comment-form__avatar-img"
        />
      </div>
      <div class="comment-form__input-group">
        <input
          type="text"
          class="comment-form__input"
          v-model="commentForm.content"
          placeholder="Write a comment..."
          maxlength="500"
        />
        <button class="comment-form__submit" type="submit" :disabled="!commentForm.content.trim()">
          <i class="bi bi-send-fill"></i>
          <span>Post</span>
        </button>
      </div>
    </div>
  </form>

      <!-- Comments List -->
      <div class="comments-list" v-if="getComment && getComment.length > 0">
        <div
          class="comment-card"
          v-for="data in getComment"
          :key="data.id"
        >
          <div class="comment-card__header">
            <div class="comment-card__user">
              <img
                :src="getProfileImage(data?.user_info?.profile_pic)"
                alt="User profile"
                class="comment-card__avatar"
              />
            </div>
            
            <div class="comment-card__meta">
              <time class="comment-card__date">
                {{ formatDate(data.created_at) || "No date available" }}
              </time>
              
              <div class="comment-card__actions" v-if="data?.user_id == currentUserId">
                <button
                  class="comment-card__action-btn"
                  @click="toggleActionMenu(data.id)"
                  :aria-expanded="activeActionCommentId === data.id"
                  aria-label="Comment options"
                >
                  <i class="bi bi-three-dots-vertical"></i>
                </button>
                
                <!-- Action Dropdown -->
                <div
                  class="comment-card__dropdown"
                  v-if="activeActionCommentId === data.id"
                  v-click-outside="closeActionMenu"
                >
                  <button
                    class="comment-card__dropdown-item comment-card__dropdown-item--delete"
                    @click="deleteComment(data.id)"
                  >
                    <i class="bi bi-trash"></i>
                    <span>Delete Comment</span>
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div class="comment-card__content">
            <p class="comment-card__text">
              {{ data.content || "No content" }}
            </p>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div class="comments-empty" v-else-if="getComment">
        <div class="comments-empty__icon">
          <i class="bi bi-chat-left"></i>
        </div>
        <p class="comments-empty__text">No comments yet</p>
        <p class="comments-empty__subtext">Be the first to share your thoughts!</p>
      </div>
    </div>
          </div>
          <div v-else>
            <p>Loading item details...</p>
          </div>

          <!-- PDF Modal -->
          <div
            class="modal fade"
            id="downloadAsPDF"
            tabindex="-1"
            aria-labelledby="addNewMemberLabel"
            aria-hidden="true"
          >
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-body">
                  <downloadAsPDF ref="pdfRef" :item="data" />
                </div>
                <div class="modal-footer">
                  <button
                    type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal"
                  >
                    Cancel
                  </button>
                  <button
                    type="button"
                    class="btn btn-primary"
                    @click="handleDownload"
                  >
                    Download now
                  </button>
                </div>
              </div>
            </div>
          </div>
          <!-- End PDF Modal -->
        </div>
      </div>
    </div>

    <!-- Loading Overlay -->
    <div v-if="isLoading" class="loading-overlay">
      <div class="loading-box">
        <div class="spinner"></div>
        <p>{{ loadingMessage }}</p>
      </div>
    </div>



          <!-- Full view of image Modal -->
          <div class="modal fade" id="fullView" tabindex="-1" aria-labelledby="fullViewLabel" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="fullView">Full image</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <img :src="data.image_url" 
                  alt="Image"
                  class="mx-auto"
                  >
                </div>
              </div>
            </div>
          </div>


  </AdminLayout>
</template>

<style scoped>
@import "../../../css/viewItemInfo.css";
@import "../../../css/admin/viewInfo.css";
@import '../../../css/items/comment.css';
</style>
