<script setup>
import { defineProps, ref, onMounted, onBeforeUnmount } from 'vue';
import { Link, router, usePage } from '@inertiajs/vue3';
import downloadAsPDF from './admin/item/downloadAsPDF.vue';

const page = usePage();

const props = defineProps({
  created_by: Object,
  getProfile: String,
  data: Object,
  title: String,
  description: String
});
// Popup state
const showPopup = ref(false);
const popupRef = ref(null);
const iconRef = ref(null);

// Toggle popup
const togglePopup = () => {
  showPopup.value = !showPopup.value;
};

// Handle outside click to close popup
const handleClickOutside = (event) => {
  if (
    popupRef.value &&
    !popupRef.value.contains(event.target) &&
    iconRef.value &&
    !iconRef.value.contains(event.target)
  ) {
    showPopup.value = false;
  }
};

onMounted(() => {
  document.addEventListener("click", handleClickOutside);
});
onBeforeUnmount(() => {
  document.removeEventListener("click", handleClickOutside);
});
const isLoading = ref(false);
const loadingMessage = ref("Generating PDF, please wait...");

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
const forceDelete = () => {
  if(confirm("Are you sure you want to delete this item? ")){
      router.delete(route('forceDeleteItem', {id: props?.data?.id}), {}, {
    onSuccess: () => alert('Item deleted.'),
    onError: () => alert('An error occurred, please try again.')
  });
  }

};
</script>

<template>
  <div>
    <div class="container-fluid d-column flex-row align-items-center px-0">
      <div class="mb-2 container-fluid px-0 d-flex flex-row justify-content-between align-items-center">

        <!-- Profile -->
        <div>
          <Link
            :href="route('view.userAsUser', { id: props.created_by?.id })"
            class="text-decoration-none d-flex align-items-center gap-2"
          >
            <img
              :src="props.getProfile == 'NA' ? '../../images/profile.jpeg' : `/storage/${props.getProfile}`"
              alt="User"
              class="profile-pic"
            />
            <span class="text-sm font-medium text-gray-700">{{ props.created_by?.name }}</span>
          </Link>
        </div>

        <!-- ⋮ Popup Actions -->
        <div ref="iconRef" class="position-relative">
          <i class="bi bi-three-dots-vertical action" @click="togglePopup"></i>

          <!-- Popup -->
          <div
            v-if="showPopup"
            ref="popupRef"
            class="position-absolute bg-white border shadow-sm rounded d-flex flex-column"
            style="right: 0; top: 100%; z-index: 999; min-width: 180px;"
          >
            <Link
              :href="route('message.admin')"
              class="button text-decoration-none text-dark"
            >
              Contact Admin
            </Link>

            <button class="button" data-bs-toggle="modal" data-bs-target="#downloadAsPDF">
              Download as PDF
            </button>
            <button 
            class="button" 
            @click="forceDelete" 
            title="Note! only if the user didn't follow the privacy and policy."
            v-if="page.props.auth?.user.id === props.created_by?.id"
            >Delete Post</button>
          </div>
        </div>
      </div>

      <!-- Title & Description -->
      <div class="flex justify-between items-center mb-4 header">
        <div class="d-flex flex-column">
          <h2 class="text-xl font-semibold mb-0">{{ props.title || 'Unnamed Item' }}</h2>
          <p class="description">{{ props.description || 'No description' }}</p>
        </div>
      </div>


      <!-- Download as pdf  -->
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
                  <downloadAsPDF ref="pdfRef" :item="props?.data" />
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

    </div>
  </div>
</template>

<style scoped>
.description {
  font-size: 0.8rem;
}

.profile-pic {
  max-width: 35px;
  min-width: 35px;
  height: 35px;
  border-radius: 50%;
}

.action {
  cursor: pointer;
}

.button {
  text-align: left;
  padding: .5rem 1rem;
  background: transparent;
  border: none;
  width: 100%;
}

.button:hover {
  background: #e9e3e3;
}
</style>
