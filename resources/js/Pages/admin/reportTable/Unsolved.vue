<script setup>
import { defineProps, ref, watch, computed } from 'vue';
import { router } from '@inertiajs/vue3';

const props = defineProps({
  unSolved: {
    type: Array,
    default: () => [],
  },
});

const formatDate = (dateString) => {
  if (!dateString) return 'N/A';
  const options = { year: 'numeric', month: 'long', day: 'numeric' };
  return new Date(dateString).toLocaleDateString(undefined, options);
};

const getDuration = (dateString) => {
  if (!dateString) return 'N/A';
  
  const created = new Date(dateString);
  const now = new Date();
  const diffMs = now - created;
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));

  if (diffDays < 1) return "Today";
  if (diffDays === 1) return "1 day ago";
  if (diffDays < 7) return `${diffDays} days ago`;

  const diffWeeks = Math.floor(diffDays / 7);
  if (diffWeeks < 4) return `${diffWeeks} week${diffWeeks > 1 ? "s" : ""} ago`;

  const diffMonths = Math.floor(diffDays / 30);
  if (diffMonths < 12) return `${diffMonths} month${diffMonths > 1 ? "s" : ""} ago`;

  const diffYears = Math.floor(diffDays / 365);
  return `${diffYears} year${diffYears > 1 ? "s" : ""} ago`;
};

let getUnSolved = ref([]);
let searchQuery = ref('');

watch(
  () => props.unSolved,
  (newItems) => {
    getUnSolved.value = newItems || [];
    console.log('Unsolved items received:', getUnSolved.value);
  },
  { immediate: true }
);

const filteredReports = computed(() => {
  const query = searchQuery.value.toLowerCase();
  const oneYearAgo = new Date();
  oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);

  // Filter items that are one year or older
  const oneYearOrOlderItems = getUnSolved.value.filter((item) => {
    if (!item?.created_at) return false;
    
    const createdAt = new Date(item.created_at);
    const isOneYearOrOlder = createdAt <= oneYearAgo;
    
    return isOneYearOrOlder;
  });

  // Then apply search filter
  return oneYearOrOlderItems.filter((item) => {
    const titleMatch = item?.title?.toLowerCase().includes(query);
    const dateMatch = formatDate(item?.created_at)?.toLowerCase().includes(query);
    const statusMatch = item?.status?.toLowerCase().includes(query);
    
    return titleMatch || dateMatch || statusMatch;
  });
});

const navigateTo = (id) => {
  router.visit(route('viewItemInfoAsAdmin', { item: id }));
};
</script>

<template>
  <div class="container-fluid mt-5 px-0">
    <div class="card border-0">
      <div class="card-body">
        <div class="header-container d-flex mb-3 container-fluid justify-content-between">
          <h5 class="card-title">All <span class="text-warning">Unsolved</span> Reports</h5>
          <div class="search-container">
            <input
              v-model="searchQuery"
              type="text"
              class="form-control search"
              placeholder="Search by name, date, or status..."
            />
          </div>
        </div>

        <div class="table-container">
          <table class="table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Status</th>
                <th>Date</th>
                <th>Since</th>
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
                <td>
                  <span :class="`badge ${item.status === 'Lost' ? 'bg-danger' : 'bg-success'}`">
                    {{ item.status || 'N/A' }}
                  </span>
                </td>
                <td>{{ formatDate(item.created_at) }}</td>
                <td>{{ getDuration(item.created_at) }}</td>
              </tr>
              <tr v-if="filteredReports.length === 0">
                <td colspan="4" class="text-center text-muted">
                  No Unsolved Reports older than 1 year.
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        
        <!-- Summary Info -->
        <div class="mt-3 text-muted small">
          Showing {{ filteredReports.length }} items that are 1 year or older and not claimed
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.table-container {
  max-height: 50vh;
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

.table th,
.table td {
  white-space: nowrap;
  text-align: left;
  padding: 0.5rem;
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
  width: 30vw;
}
.header-container {
  flex-direction: row;
  align-items: center;
}
@media screen and (max-width: 768px) {
  .card h5 {
    font-size: 1rem;
  }
  .header-container {
    flex-direction: column;
    text-align: left;
    align-items: start;
  }
  .search-container {
    width: 100%;
    position: relative;
  }
  .card .search {
    width: 70%;
  }
}
</style>