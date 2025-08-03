<script setup>
import { ref, watch } from "vue";
import { Link, useForm, Head, router, usePage } from "@inertiajs/vue3";
import CustomModal from "@/Components/CustomModal.vue";
import ViewItemInfoForAdminHeader from "@/Components/admin/ViewItemInfoForAdminHeader.vue";
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
    default: ''
  },
  comments: {
    type: Array,
    default: () => []
  },
  currentUser: {
    type: Number,
    default: null
  }
});

const page = usePage();
const currentUserId = ref(null);
const data = ref({});
const getProfile = ref('')
const getComment = ref([]);
const getCreatedBy = ref();

watch(
  () => props.created_by?.id,
  (newItem) => {
    getCreatedBy.value = newItem;
  },
  {immediate: true}
)
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
  {immediate: true}
)
watch(
  () => props.comments,
  (newItem) => {
    getComment.value = newItem;
  },
  {immediate: true}
)

watch(
  () => props.currentUser,
  (id) => {
    currentUserId.value = id;
  },
  {immediate: true}
)

const commentForm = useForm({
  user_id: String(props.created_by?.id || ''),
  item_id: String(props.item?.id || ''),
  content: ''
});
const addComment = () => {
  commentForm.post(route('comment.store', {item : data?.value?.id}), {
    onSuccess: () => {
      commentForm.reset('content'); 
    },
    onError: () => {
      alert("Something went wrong, please try again.")
    }
  });
};
const formatDate = (dateString) => {
  const options = { year: "numeric", month: "long", day: "numeric" };
  return new Date(dateString).toLocaleDateString(undefined, options);
};


const activeActionCommentId = ref(null);

const toggleActionMenu = (commentId) => {
  activeActionCommentId.value = activeActionCommentId.value === commentId ? null : commentId;
};


const deleteComment = (getId) => {
  Inertia.delete(route('comment.delete', {id: getId}), {
    onSuccess: () => {
      getComment.value = getComment?.value.filter(comment => comment.id != getId);
    },
    onError: (err) => {
      alert("an error occured while deleting data => ", err)
    }
  })
      getComment.value = getComment?.value.filter(comment => comment.id != getId);
}
</script> 

<template>
  <Head title="View Item Info" />
  <AdminLayout>
      <div class="main-container">
        <div class="container">
    <div class="bg-white rounded-lg shadow-md w-full max-w-3xl p-6">
      <div v-if="Object.keys(data).length > 0">
       
        <ViewItemInfoForAdminHeader 
        :id="props?.created_by.id"
        :item_id="props?.item.id"
        :name="props?.created_by.name"
        :title="data?.title"
        :description="data?.description"
        :profile="getProfile"
        />

        <div class="mb-6">
          <img
            :src="data.image_url"
            alt="Item Image"
            class=" rounded object-cover image-item"
          />
        </div>
        <div class="text-end date">
          {{ formatDate(data.reported_at) }}
        </div>
        
        <div class="text-sm text-gray-700 space-y-1 d-none d-lg-block ">
          <p class="mb-0"><strong>Location:</strong> {{ data.location }}</p>
          <p><strong>Phone number:</strong> {{ data.owner_phone_number || 'NA' }}</p>
          <p v-if="data.category"><strong>Category:</strong> {{ data.category  || "NA"}}</p>
          <p><strong>Status:</strong> <span :class="data.status === 'Lost' ? 'text-red-600 font-semibold' : 'text-green-600'">{{ data.status }}</span></p>
        </div>

        <div class="text-sm text-gray-700 space-y-1 d-block d-lg-none">
          <p class="mb-0"><i class="bi bi-geo-alt-fill me-2"></i>{{ data.location }}</p>
          <p><i class="bi bi-telephone-fill me-2"></i> {{ data.owner_phone_number || 'NA' }}</p>
          <p v-if="data.category"><i class="bi bi-bookmark-fill me-2"></i>{{ data.category  || "NA"}}</p>
          <p><i class="bi bi-info-circle-fill me-2"></i><span :class="data.status === 'Lost' ? 'text-red-600 font-semibold' : 'text-green-600'">{{ data.status }}</span></p>
        </div>

        <!-- Comment section  -->
        <div class="container-fluid comment-main-container">
         <form @submit.prevent="addComment" class="form d-flex flex-row gap-4 align-items-center">
          <div class="mt-2">
           <img
              :src="getProfile == 'NA' ? '../../../images/profile.jpeg' : `/storage/${getProfile}`"
              alt="User"
              class="profile-pic rounded-full"
            />
          </div>

          <div class="w-100 mt-3 d-flex flex-row gap-1">
            <input type="text" class="form-control w-100 py-2" v-model="commentForm.content">
            <button class="btn btn-success" type="submit">post</button>
          </div>
         </form>

         <div class="container my-3 px-0 mx-0 comment-container d-flex flex-column gap-2" v-if="getComment">
            <div class="comment p-3 rounded" v-for="data in getComment" :key="data.id">
              <div class="d-flex flex-row justify-content-between align-items-center">
                <div class="">
                  <img src="../../../images/profile.jpeg" alt=""
                  class="profile-in-comment2"
                  >
                </div>
                <div class="date d-flex align-items-center gap-2">
                  <p class="d-inline-block">{{ formatDate(data.created_at) || "No date available"}}</p>
                  <i class="bi bi-three-dots-vertical d-inline-block action-in-comment" 
                  v-if="data?.user_id == currentUserId"
                   @click="toggleActionMenu(data.id)"
                  ></i>
                </div>

                <div class="action-container rounded py-2 px-4 "
                v-if="activeActionCommentId === data.id"
                >
                  <div @click="deleteComment(data.id)" class="text-dark">Delete </div>
                </div>
              </div>

              <div class="content-container mt-4">
                {{ data.content || 'None' }}
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
</AdminLayout>  
</template>
<style scoped>
@import "../../../css/viewItemInfo.css";
.profile-in-comment2{
  position: relative;
  width: 45px;
  min-width: 45px;
  height: 45px;
}
</style>