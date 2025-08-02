<script setup>
import { defineProps, ref, watch } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AdminSettingsLayout from '@/Layouts/settings/AdminSettingsLayout.vue';
import AnnouncementCard from '@/Components/settings/AnnouncementCard.vue';
const props = defineProps({
  ann: {
    type: Array,
    default: () => [],
  },
});

let announcements = ref([]);
let toastMessage = ref('');

watch(
  () => props.ann,
  (newVal) => {
    // Sort announcements by date (newer first)
    announcements.value = [...newVal].sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
  },
  { immediate: true }
);

const selectedAnnouncementId = ref(null);


const deleteAnnouncement = () => {
  if (selectedAnnouncementId.value) {
    router.delete(route('settings.announcement.destroy', { id: selectedAnnouncementId.value }), {
      onSuccess: () => {
        announcements.value = announcements.value.filter(ann => ann.id != selectedAnnouncementId.value);
        setTimeout(() => {
          alert("Deleted successfully...");
        },1000)
      },
    });
  }
};
</script>

<template>
  <Head title="Announcements" />

  <AdminSettingsLayout>
    <div class="main-container">
      <!-- Header -->
      <div class="container-fluid d-flex flex-row justify-content-between align-items-center mb-4">
        <div>
          <h1 class="text-dark fw-light">Announcements</h1>
        </div>
        <div>
          <Link :href="route('settings.addAnnouncementPage')" class="btn btn-success">
            <i class="bi bi-plus-lg me-2"></i>
            New
          </Link>
        </div>
      </div>

      <!-- Announcements Grid -->
      <div class="row announcement-grid" v-if="announcements.length">
        <div
          v-for="announcement in announcements"
          :key="announcement.id"
          class="col-md-6 col-lg-4 mb-4"
        >
         <AnnouncementCard 
         :announcement="announcement"
         :key="announcement.id"
         v-model:selected="selectedAnnouncementId"
         />
        </div>
        <!-- Extra space at the bottom -->
        <div class="bottom-container container"></div>
      </div>

      <!-- No Announcements Message -->
      <div v-else class="text-center py-5">
        <h4>No announcements found.</h4>
      </div>
    </div>
  </AdminSettingsLayout>

  <div
    class="modal fade"
    id="exampleModal"
    tabindex="-1"
    aria-labelledby="exampleModalLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5" id="exampleModalLabel">Delete Announcement</h1>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          Are you sure you want to delete the announcement?
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-bs-dismiss="modal"
            id="liveToastBtn"
          >
            No
          </button>
          <button type="button" class="btn btn-danger" @click="deleteAnnouncement" data-bs-dismiss="modal" id="liveToastBtn">
            Yes
          </button>
        </div>
      </div>
    </div>

    <!-- pasa sa message kung deleted na ang announcement  -->
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header">
      <strong class="me-auto">Notification</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">
      {{ toastMessage }}
    </div>
  </div>
</div>


  </div>
</template>

<style>
body {
  background-color: #f8f9fa;
}

.card {
  transition: transform 0.2s, box-shadow 0.2s;
}


.profile-container {
  width: 45px;
  height: 45px;
  border-radius: 50%;
  overflow: hidden;
}

.profile-container img {
  position: relative;
  width: 90%;
  height: 90%;
  border-radius: inherit;
}

.date {
  font-size: 0.8rem;
}

.bi-trash {
  font-size: 1.2rem;
  cursor: pointer;
}

.btn-link {
  text-decoration: none;
}

.announcement-grid {
  height: 600px;
  overflow-y: scroll;
  padding-right: 15px;
}

.bottom-container {
  width: 100%;
  height: 20%;
}
</style>
