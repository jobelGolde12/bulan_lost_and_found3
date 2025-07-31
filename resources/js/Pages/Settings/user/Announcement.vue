<script setup>
import { defineProps, ref, watch } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import UserSettingsLayout from '@/Layouts/UserSettingsLayout.vue';
const props = defineProps({
  ann: {
    type: Array,
    default: () => [],
  },
});

let announcements = ref([]);
watch(
  () => props.ann,
  (newVal) => {
    // Sort announcements by date (newer first)
    announcements.value = [...newVal].sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
  },
  { immediate: true }
);

const formatDate = (date, locale = 'en-US', options = {}) => {
  const defaultOptions = { year: 'numeric', month: 'long', day: 'numeric' };
  const finalOptions = { ...defaultOptions, ...options };
  const dateObj = new Date(date);

  if (isNaN(dateObj)) {
    return 'Invalid date';
  }

  return new Intl.DateTimeFormat(locale, finalOptions).format(dateObj);
};

const selectedAnnouncementId = ref(null);

const openDeleteModal = (id) => {
  selectedAnnouncementId.value = id;
};

// const showToast = (message) => {
//   toastMessage.value = message;
//   const toastElement = document.getElementById('liveToast');
//   const toast = new bootstrap.Toast(toastElement);
//   toast.show();
// };


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

  <UserSettingsLayout>
    <div class="main-container">
      <h1 class="text-dark fw-light mb-4">Announcements</h1>


      <!-- Announcements Grid -->
      <div class="row announcement-grid" v-if="announcements.length">
        <div
          v-for="announcement in announcements"
          :key="announcement.id"
          class="col-md-6 col-lg-4 mb-4"
        >
          <div class="card h-100 shadow-sm rounded">
            <div class="card-body d-flex flex-column">
              <div class="container-fluid p-0 d-flex flex-row justify-content-between align-items-center">
                <div>
                  <h5 class="card-title text-dark fw-light mb-0 fs-3">{{ announcement.title }}</h5>
                </div>
                <div>
                  <button
                    class="btn btn-link p-0 text-dark"
                    data-bs-toggle="modal"
                    data-bs-target="#exampleModal"
                    @click="openDeleteModal(announcement.id)"
                    aria-label="Delete announcement"
                  >
                    <i class="bi bi-trash"></i>
                  </button>
                </div>
              </div>
              <p class="card-text text-muted date">{{ formatDate(announcement.created_at) }}</p>
              <p class="card-text">{{ announcement.content }}</p>
              <div class="mt-auto d-flex flex-row justify-content-between align-items-center">
                <div class="profile-container" v-if="announcement?.userProfile?.profile_pic">
                  <img :src="announcement?.userProfile?.profile_pic" alt="Profile" />
                </div>
                <div class="profile-container" v-else>
                  <img src="../../../../images/profile.jpeg" alt="Profile" />
                </div>
                <div>
                  <div class="name">{{ announcement?.user.name || 'user' }}</div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- Extra space at the bottom -->
        <div class="bottom-container container"></div>
      </div>

      <!-- No Announcements Message -->
      <div v-else class="text-center py-5">
        <h4>No announcements found.</h4>
      </div>
    </div>
  </UserSettingsLayout>

  <!-- Bootstrap Modal -->
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
  width: 100%;
  height: 100%;
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
