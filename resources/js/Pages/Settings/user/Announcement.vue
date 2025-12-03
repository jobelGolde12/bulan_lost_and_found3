<script setup>
import { defineProps, ref, watch } from 'vue';
import { Head, Link, router } from '@inertiajs/vue3';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import AnnouncementCard from '@/Components/settings/AnnouncementCard.vue';

const props = defineProps({
  ann: {
    type: Array,
    default: () => [],
  },
});

let announcements = ref([]);
let toastMessage = ref('');
let selectedAnnouncementId = ref(null);

// Add sorting and filtering variables
const sortOrder = ref("latest"); // latest | oldest
const filterStatus = ref("all"); // all | viewed | unviewed

// Apply both filtering and sorting
const applyFiltersAndSorting = () => {
  let data = [...props.ann];

  // Apply status filter
  if (filterStatus.value === "viewed") {
    data = data.filter(ann => ann.read_status === 1);
  } else if (filterStatus.value === "unviewed") {
    data = data.filter(ann => ann.read_status === 0);
  }

  // Apply date sorting
  data.sort((a, b) => {
    const dateA = new Date(a.created_at);
    const dateB = new Date(b.created_at);
    return sortOrder.value === "latest" ? dateB - dateA : dateA - dateB;
  });

  announcements.value = data;
};

// Toggle sort order between latest and oldest
const toggleSortOrder = () => {
  sortOrder.value = sortOrder.value === "latest" ? "oldest" : "latest";
  applyFiltersAndSorting();
};

// Cycle through filter status: all → unviewed → viewed → all
const toggleFilter = () => {
  if (filterStatus.value === "all") {
    filterStatus.value = "unviewed";
  } else if (filterStatus.value === "unviewed") {
    filterStatus.value = "viewed";
  } else {
    filterStatus.value = "all";
  }
  applyFiltersAndSorting();
};

watch(
  () => props.ann,
  () => {
    applyFiltersAndSorting();
  },
  { immediate: true }
);

const deleteAnnouncement = () => {
  if (selectedAnnouncementId.value) {
    router.delete(route('settings.announcement.destroy', { id: selectedAnnouncementId.value }), {
      onSuccess: () => {
        announcements.value = announcements.value.filter(ann => ann.id != selectedAnnouncementId.value);
        setTimeout(() => {
          alert("Deleted successfully...");
        }, 1000);
      },
    });
  }
};
</script>

<template>
  <Head title="Announcements" />

  <AuthenticatedLayout>
    <div class="main-container bg-light container-fluid py-4">
      <!-- Header -->
      <div class="header-container d-flex flex-wrap justify-content-between align-items-center mb-4">
        <h1 class="text-dark fw-light mb-3 mb-md-0">Announcements</h1>

        <div class="d-flex flex-wrap align-items-center gap-3">
          <!-- Sort Button -->
          <div
            class="sort-btn text-dark fs-6 pointer d-flex align-items-center"
            @click="toggleSortOrder"
            title="Sort announcements"
          >
            <i class="bi bi-sort-down me-2"></i>
            <span>{{ sortOrder === "latest" ? "Latest → Oldest" : "Oldest → Latest" }}</span>
          </div>
        </div>
      </div>

      <!-- Announcements Grid -->
      <div class="row d-flex flex-row mx-auto announcement-grid g-3" v-if="announcements.length">
        <div
          v-for="announcement in announcements"
          :key="announcement.id"
          class="col-12 col-6 "
        >
          <AnnouncementCard
            :announcement="announcement"
            v-model:selected="selectedAnnouncementId"
          />
        </div>
      </div>

      <!-- No Announcements Message -->
      <div v-else class="text-center py-5">
        <h4>No announcements found.</h4>
        <p class="text-muted" v-if="filterStatus !== 'all'">
          Try changing your filter settings.
        </p>
      </div>
    </div>
  </AuthenticatedLayout>

  <!-- Delete Confirmation Modal -->
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
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            No
          </button>
          <button
            type="button"
            class="btn btn-danger"
            @click="deleteAnnouncement"
            data-bs-dismiss="modal"
          >
            Yes
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
body {
  background-color: #f8f9fa;
}

.main-container {
  overflow-y: scroll;
  overflow-x: none;
  height: 100vh;
  width: 100%;
}
.main-container::-webkit-scrollbar {
  /* width: 6px; */
  display: block;
}
/* Header */
.header-container {
  border-bottom: 1px solid #eaeaea;
  padding-bottom: 1rem;
}

.sort-btn {
  transition: color 0.2s;
}

.sort-btn:hover {
  color: #007bff;
}

.pointer {
  cursor: pointer;
}

/* Announcement Grid */
.announcement-grid {
  width: 60%;
  height: 100vh;
  scrollbar-width: thin;
  scrollbar-color: #cbd5e0 #f1f1f1;
}

.announcement-grid::-webkit-scrollbar {
  /* width: 6px; */
  display: none;
}

.announcement-grid::-webkit-scrollbar-thumb {
  background-color: #cbd5e0;
  border-radius: 3px;
}

.announcement-grid::-webkit-scrollbar-track {
  background-color: #f1f1f1;
}

/* Responsive Design */
@media (max-width: 992px) {
  .main-container {
    padding: 1.5rem;
  }
}

@media (max-width: 768px) {
  .header-container {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }

  .announcement-grid {
    max-height: none;
    overflow-y: visible;
  }

  .sort-btn span {
    font-size: 0.85rem;
  }

  .btn.btn-success {
    width: 100%;
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .main-container {
    padding: 1rem;
  }

  .sort-btn {
    font-size: 0.9rem;
  }

  h1 {
    font-size: 1.5rem;
  }
}
</style>
