<script setup>
import { ref, onMounted, watch, computed } from 'vue';
import axios from 'axios';
import { router } from '@inertiajs/vue3';

// Reactive data
const items = ref([]);
const currentPage = ref(1);
const hasMore = ref(true);
const isLoading = ref(false);
const observer = ref(null);
const selectedFilter = ref('');
const searchQuery = ref('');

// Fetch data with pagination
const fetchItems = async (page = 1, reset = false) => {
  if (isLoading.value) return;
  isLoading.value = true;

  try {
    const response = await axios.get(route('admin.items'), {
      params: {
        page,
        status: selectedFilter.value || null,
      },
    });

    const fetched = response.data.data || [];

    if (reset) {
      items.value = fetched;
    } else {
      items.value.push(...fetched);
    }

    hasMore.value = !!response.data.next_page_url;
    currentPage.value = response.data.current_page;
  } catch (error) {
    console.error('Error fetching items:', error);
  } finally {
    isLoading.value = false;
  }
};

// Infinite scroll observer
const setupObserver = () => {
  const target = document.querySelector('#scroll-trigger');
  if (!target) return;

  observer.value = new IntersectionObserver(
    async (entries) => {
      if (entries[0].isIntersecting && hasMore.value && !isLoading.value) {
        await fetchItems(currentPage.value + 1);
      }
    },
    { threshold: 0.1 }
  );

  observer.value.observe(target);
};

// Utils
const formatDate = (dateString) => {
  if (!dateString) return 'N/A';
  const options = { year: 'numeric', month: 'long', day: 'numeric' };
  return new Date(dateString).toLocaleDateString(undefined, options);
};

const getDuration = (dateString) => {
  const created = new Date(dateString);
  const now = new Date();
  const diffDays = Math.floor((now - created) / (1000 * 60 * 60 * 24));

  if (diffDays < 1) return 'Today';
  if (diffDays === 1) return '1 day ago';
  if (diffDays < 7) return `${diffDays} days ago`;
  const diffWeeks = Math.floor(diffDays / 7);
  if (diffWeeks < 4) return `${diffWeeks} week${diffWeeks > 1 ? 's' : ''} ago`;
  const diffMonths = Math.floor(diffDays / 30);
  if (diffMonths < 12) return `${diffMonths} month${diffMonths > 1 ? 's' : ''} ago`;
  const diffYears = Math.floor(diffDays / 365);

  // Mark unsolved if >= 1 year
  if (diffYears >= 1) return `Unsolved (${diffYears} year${diffYears > 1 ? 's' : ''} ago)`;
  return `${diffYears} year${diffYears > 1 ? 's' : ''} ago`;
};

// Filter change
const changeFilter = async (status) => {
    // console.log("status: ", status)
    // if(status == 'Resolved'){
    //     selectedFilter.value = 'Claimed';
    // }
  selectedFilter.value = status;
  await fetchItems(1, true);
};

// Search
const filteredReports = computed(() => {
  const query = searchQuery.value.toLowerCase();
  return items.value.filter((item) => {
    const titleMatch = item?.title?.toLowerCase().includes(query);
    const dateMatch = formatDate(item?.created_at)?.toLowerCase().includes(query);
    const statusMatch = item?.status?.toLowerCase().includes(query);
    return titleMatch || dateMatch || statusMatch;
  });
});

// Navigate to item view
const navigateTo = (id) => {
  router.visit(route('viewItemInfoAsAdmin', { item: id }));
};

// Lifecycle
onMounted(async () => {
  await fetchItems();
  setupObserver();
});
</script>

<template>
  <div class="container-fluid mt-5 px-0">
    <div class="card border-0">
      <div class="card-body">
        <div class="header-container d-flex mb-3 container-fluid justify-content-between align-items-center">
          <h5 class="card-title">Reports</h5>

          <!-- Filter Buttons -->
          <div class="d-flex gap-2">
            <button
              v-for="status in ['Lost', 'Found', 'Resolved', 'Unsolved']"
              :key="status"
              class="btn"
              :class="selectedFilter === status ? 'btn-primary' : 'btn-outline-secondary'"
              @click="changeFilter(status)"
            >
              {{ status }}
            </button>
          </div>

          <!-- Search -->
          <div class="search-container">
            <input
              v-model="searchQuery"
              type="text"
              class="form-control search"
              placeholder="Search by name, date, or status..."
            />
          </div>
        </div>

        <!-- Table -->
        <div class="table-container">
          <table class="table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Date</th>
                <th>Since</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(item, index) in filteredReports"
                :key="item.id || index"
                @click="navigateTo(item.id)"
                class="clickable-row"
              >
                <td>{{ item.title || 'N/A' }}</td>
                <td>{{ formatDate(item.created_at) }}</td>
                <td>{{ getDuration(item.created_at) }}</td>
                <td>
                  <span
                    class="badge"
                    :class="{
                      'text-primary': item.status === 'Claimed',
                      'text-danger': item.status === 'Lost',
                      'text-success': item.status === 'Found',
                      'text-secondary': !item.status
                    }"
                  >
                    <span v-if="item.status === 'Claimed'" class="text-primary">Resolved</span>
                    <span v-else>{{ item.status || 'N/A' }}</span>
                  </span>
                </td>
              </tr>
              <tr v-if="filteredReports.length === 0">
                <td colspan="4" class="text-center text-muted">No Record Found.</td>
              </tr>
            </tbody>
          </table>

          <!-- Loading Indicator -->
          <div v-if="isLoading" class="text-center py-3 text-muted">Loading...</div>

          <!-- Infinite scroll trigger -->
          <div id="scroll-trigger" class="py-3"></div>
        </div>

        <!-- Summary -->
        <div class="mt-3 text-muted small">
          Showing {{ filteredReports.length }} items in record.
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.table-container {
  max-height: 60vh;
  overflow-y: auto;
}
.table {
  width: 100%;
  border-collapse: collapse;
  background-color: #fff;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
.table thead th {
  background-color: #f8f9fa;
  color: #333;
  border-bottom: 2px solid #dee2e6;
  padding: 0.75rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
.clickable-row {
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.3s ease;
  border-bottom: 1px solid #ddd;
}
.clickable-row:hover {
  background-color: #f0f0f0 !important;
  transform: translateY(-2px);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
.search {
  width: 20vw;
}
.header-container {
  flex-wrap: wrap;
  gap: 10px;
}
.btn {
  border-radius: 20px;
}
</style>
