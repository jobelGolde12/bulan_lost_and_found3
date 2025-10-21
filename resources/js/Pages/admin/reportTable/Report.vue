<script setup>
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';
import { router } from '@inertiajs/vue3';

const items = ref([]);
const currentPage = ref(1);
const hasMore = ref(true);
const isLoading = ref(false);
const observer = ref(null);
const selectedFilter = ref('');
const searchQuery = ref('');

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
    if (reset) items.value = fetched;
    else items.value.push(...fetched);

    hasMore.value = !!response.data.next_page_url;
    currentPage.value = response.data.current_page;
  } catch (error) {
    console.error('Error fetching items:', error);
  } finally {
    isLoading.value = false;
  }
};

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
  if (diffYears >= 1) return `Unsolved (${diffYears} year${diffYears > 1 ? 's' : ''} ago)`;
  return `${diffYears} year${diffYears > 1 ? 's' : ''} ago`;
};

const changeFilter = async (status) => {
  selectedFilter.value = status;
  await fetchItems(1, true);
};

const filteredReports = computed(() => {
  const query = searchQuery.value.toLowerCase();
  return items.value.filter((item) => {
    const titleMatch = item?.title?.toLowerCase().includes(query);
    const dateMatch = formatDate(item?.created_at)?.toLowerCase().includes(query);
    const statusMatch = item?.status?.toLowerCase().includes(query);
    return titleMatch || dateMatch || statusMatch;
  });
});

const navigateTo = (id) => {
  router.visit(route('viewItemInfoAsAdmin', { item: id }));
};

onMounted(async () => {
  await fetchItems();
  setupObserver();
});
</script>

<template>
  <div class="container-fluid mt-5 px-0">
    <div class="card border-0 shadow-sm">
      <div class="card-body">
        <!-- Header -->
        <div class="header-container d-flex flex-wrap justify-content-between align-items-center mb-3">
          <h5 class="card-title mb-2 mb-md-0">Reports</h5>

          <!-- Filter Buttons -->
          <div class="filter-buttons d-flex flex-wrap justify-content-center gap-2">
            <button
              v-for="status in ['Lost', 'Found', 'Resolved', 'Unsolved']"
              :key="status"
              class="btn filter-btn d-flex align-items-center gap-1"
              :class="selectedFilter === status ? 'btn-primary' : 'btn-outline-secondary'"
              @click="changeFilter(status)"
            >
              <i
                v-if="status === 'Lost'"
                class="bi bi-exclamation-triangle-fill"
              ></i>
              <i
                v-else-if="status === 'Found'"
                class="bi bi-check-circle-fill"
              ></i>
              <i
                v-else-if="status === 'Resolved'"
                class="bi bi-flag-fill"
              ></i>
              <i
                v-else-if="status === 'Unsolved'"
                class="bi bi-question-circle-fill"
              ></i>
              <span class="filter-text">{{ status }}</span>
            </button>
          </div>

          <!-- Search -->
          <div class="search-container mt-2 mt-md-0">
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
          <table class="table table-hover">
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

          <div v-if="isLoading" class="text-center py-3 text-muted">Loading...</div>
          <div id="scroll-trigger" class="py-3"></div>
        </div>

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

/* Filter Buttons */
.filter-buttons .btn {
  border-radius: 20px;
  font-size: 0.95rem;
  transition: all 0.3s ease;
}

.filter-buttons .btn i {
  font-size: 1rem;
}

.filter-buttons .btn:hover {
  transform: translateY(-2px);
}

/* Search box */
.search {
  width: 20vw;
  min-width: 200px;
}

.header-container {
  gap: 10px;
}

/* 🌐 RESPONSIVE DESIGN */

/* Medium devices (≤992px) */
@media (max-width: 992px) {
  .header-container {
    flex-direction: column;
    align-items: stretch;
  }

  .search-container {
    width: 100%;
  }

  .search {
    width: 100%;
  }

  .filter-buttons {
    justify-content: space-between;
    width: 100%;
  }
}

/* Small devices (≤768px) */
@media (max-width: 768px) {
  .filter-buttons {
    justify-content: center;
    flex-wrap: wrap;
  }

  /* Hide text, show icons only */
  .filter-text {
    display: none;
  }

  .filter-buttons .btn {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    justify-content: center;
  }

  .filter-buttons .btn i {
    font-size: 1.4rem;
  }

  .search {
    width: 100%;
  }
}

/* Extra small (≤480px) */
@media (max-width: 480px) {
  .filter-buttons .btn {
    width: 45px;
    height: 45px;
  }

  .filter-buttons {
    gap: 6px;
  }

  .table-container {
    max-height: none;
    overflow-x: auto;
  }

  .table thead {
    display: none;
  }

  .table tr {
    display: block;
    margin-bottom: 0.75rem;
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 0.5rem;
  }

  .table td {
    display: flex;
    justify-content: space-between;
    padding: 0.5rem;
  }
}
</style>
