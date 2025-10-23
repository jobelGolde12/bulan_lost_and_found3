<template>
  <div class="dashboard-container">
    <!-- Header Section -->
    <div class="dashboard-header">
      <div class="header-content">
        <h1 class="dashboard-title">Reports Dashboard</h1>
        <p class="dashboard-subtitle">Manage and monitor lost and found items across barangays</p>
      </div>
    </div>

    <!-- Controls Section -->
    <div class="controls-section">
      <!-- Search Bar -->
      <div class="search-container">
        <div class="search-wrapper">
          <i class="bi bi-search search-icon"></i>
          <input
            type="text"
            class="search-input"
            placeholder="Search reports by title, date, barangay..."
            v-model="searchQuery"
          />
          <div class="search-actions">
            <i class="bi bi-funnel-fill filter-icon" @click="toggleAdvancedFilters"></i>
          </div>
        </div>
      </div>

      <!-- Filter Buttons -->
      <div class="filters-container">
        <div class="filter-buttons-group">
          <button
            class="filter-btn"
            :class="{ active: selectedFilter === '' }"
            @click="changeFilter('')"
          >
            <i class="bi bi-grid-3x3-gap-fill"></i>
            <span>All</span>
          </button>
          <button
            class="filter-btn lost"
            :class="{ active: selectedFilter === 'Lost' }"
            @click="changeFilter('Lost')"
          >
            <i class="bi bi-search"></i>
            <span>Lost</span>
          </button>
          <button
            class="filter-btn found"
            :class="{ active: selectedFilter === 'Found' }"
            @click="changeFilter('Found')"
          >
            <i class="bi bi-check-circle"></i>
            <span>Found</span>
          </button>
        </div>

        <!-- Barangay Filters -->
        <div class="barangay-filters" v-if="showAdvancedFilters">
          <button
            class="barangay-filter-btn"
            :class="{ active: barangayFilter === 'mostLost' }"
            @click="toggleBarangayFilter('mostLost')"
          >
            <i class="bi bi-exclamation-triangle"></i>
            <span>Most Lost</span>
          </button>
          <button
            class="barangay-filter-btn"
            :class="{ active: barangayFilter === 'mostFound' }"
            @click="toggleBarangayFilter('mostFound')"
          >
            <i class="bi bi-check-square"></i>
            <span>Most Found</span>
          </button>
          <button
            class="barangay-filter-btn"
            :class="{ active: barangayFilter === '' }"
            @click="toggleBarangayFilter('')"
          >
            <i class="bi bi-x-circle"></i>
            <span>Clear</span>
          </button>
        </div>
      </div>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-cards">
      <div class="stat-card total">
        <div class="stat-icon">
          <i class="bi bi-clipboard-data"></i>
        </div>
        <div class="stat-content">
          <h3>{{ filteredReports.length }}</h3>
          <p>Total Reports</p>
        </div>
      </div>
      <div class="stat-card lost">
        <div class="stat-icon">
          <i class="bi bi-search"></i>
        </div>
        <div class="stat-content">
          <h3>{{ lostCount }}</h3>
          <p>Lost Items</p>
        </div>
      </div>
      <div class="stat-card found">
        <div class="stat-icon">
          <i class="bi bi-check-circle"></i>
        </div>
        <div class="stat-content">
          <h3>{{ foundCount }}</h3>
          <p>Found Items</p>
        </div>
      </div>
      <div class="stat-card barangays">
        <div class="stat-icon">
          <i class="bi bi-geo-alt"></i>
        </div>
        <div class="stat-content">
          <h3>{{ barangayCount }}</h3>
          <p>Barangays</p>
        </div>
      </div>
    </div>

    <!-- Barangay Summary -->
    <div class="summary-section">
      <div class="section-header">
        <h2>Barangay Summary</h2>
        <div class="header-actions">
          <button class="action-btn" @click="exportSummary">
            <i class="bi bi-download"></i>
            Export
          </button>
        </div>
      </div>

      <div class="table-container">
        <table class="modern-table">
          <thead>
            <tr>
              <th @click="sortTable('barangay')" class="sortable">
                <span>Barangay</span>
                <i class="bi bi-arrow-down-up sort-icon"></i>
              </th>
              <th @click="sortTable('Lost')" class="sortable">
                <span>Lost</span>
                <i class="bi bi-arrow-down-up sort-icon"></i>
              </th>
              <th @click="sortTable('Found')" class="sortable">
                <span>Found</span>
                <i class="bi bi-arrow-down-up sort-icon"></i>
              </th>
              <th @click="sortTable('Total')" class="sortable">
                <span>Total</span>
                <i class="bi bi-arrow-down-up sort-icon"></i>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr 
              v-for="(data, barangay) in sortedBarangaySummary" 
              :key="barangay"
              class="table-row"
              @click="viewBarangayDetails(barangay)"
            >
              <td class="barangay-cell">
                <i class="bi bi-geo-alt-fill barangay-icon"></i>
                {{ barangay }}
              </td>
              <td>
                <span class="count-badge lost">{{ data.Lost }}</span>
              </td>
              <td>
                <span class="count-badge found">{{ data.Found }}</span>
              </td>
              <td>
                <span class="count-badge total">{{ data.Total }}</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Empty State -->
      <div v-if="Object.keys(sortedBarangaySummary).length === 0" class="empty-state">
        <i class="bi bi-inbox empty-icon"></i>
        <h3>No reports found</h3>
        <p>Try adjusting your search or filters</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, defineProps, watch } from 'vue';
import { router } from '@inertiajs/vue3';

const props = defineProps({
  items: {
    type: Array,
    default: () => [],
  },
});

const reports = ref([]);
const selectedFilter = ref('');
const searchQuery = ref('');
const barangayFilter = ref('');
const showAdvancedFilters = ref(false);
const sortField = ref('barangay');
const sortDirection = ref('asc');


// Utility functions
const getBarangay = (location) => {
  if (!location) return 'Unknown';
  const match = location.match(/^(.+?)(?:\s\([^(]*\))?$/);
  if (match && match[1]) {
    return match[1].trim();
  }
  return location.trim();
};

// Watch for props update
watch(
  () => props.items,
  (data) => {
    reports.value = data.map(item => ({
      ...item,
      barangay: getBarangay(item.location),
    }));
    console.log("items: ", reports.value);
  },
  { immediate: true }
);



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

// Filter logic
const changeFilter = (status) => {
  selectedFilter.value = status;
};

const toggleBarangayFilter = (filter) => {
  barangayFilter.value = barangayFilter.value === filter ? '' : filter;
};

const toggleAdvancedFilters = () => {
  showAdvancedFilters.value = !showAdvancedFilters.value;
};

const sortTable = (field) => {
  if (sortField.value === field) {
    sortDirection.value = sortDirection.value === 'asc' ? 'desc' : 'asc';
  } else {
    sortField.value = field;
    sortDirection.value = 'asc';
  }
};

// Computed properties
const filteredReports = computed(() => {
  const query = searchQuery.value.toLowerCase();
  let filtered = reports.value.filter((item) => {
    const matchesStatus = !selectedFilter.value || item.status === selectedFilter.value;
    const matchesSearch =
      item?.title?.toLowerCase().includes(query) ||
      formatDate(item?.created_at)?.toLowerCase().includes(query) ||
      item?.status?.toLowerCase().includes(query) ||
      item?.barangay?.toLowerCase().includes(query);
    
    return matchesStatus && matchesSearch;
  });

  // Apply barangay filter
  if (barangayFilter.value) {
    const barangayData = barangaySummary.value;
    const sortedBarangays = Object.entries(barangayData)
      .sort(([, a], [, b]) => {
        if (barangayFilter.value === 'mostLost') {
          return b.Lost - a.Lost;
        } else if (barangayFilter.value === 'mostFound') {
          return b.Found - a.Found;
        }
        return 0;
      })
      .slice(0, 5)
      .map(([barangay]) => barangay);

    filtered = filtered.filter(item => sortedBarangays.includes(item.barangay));
  }

  return filtered;
});

const barangaySummary = computed(() => {
  const summary = {};
  filteredReports.value.forEach((item) => {
    const barangay = item.barangay || 'Unknown';
    if (!summary[barangay]) {
      summary[barangay] = { Lost: 0, Found: 0, Total: 0 };
    }
    if (item.status === 'Lost') summary[barangay].Lost++;
    if (item.status === 'Found') summary[barangay].Found++;
    summary[barangay].Total++;
  });
  return summary;
});

const sortedBarangaySummary = computed(() => {
  const entries = Object.entries(barangaySummary.value);
  
  return entries.sort(([aKey, aVal], [bKey, bVal]) => {
    let aCompare, bCompare;
    
    if (sortField.value === 'barangay') {
      aCompare = aKey.toLowerCase();
      bCompare = bKey.toLowerCase();
    } else {
      aCompare = aVal[sortField.value];
      bCompare = bVal[sortField.value];
    }
    
    if (sortDirection.value === 'asc') {
      return aCompare < bCompare ? -1 : aCompare > bCompare ? 1 : 0;
    } else {
      return aCompare > bCompare ? -1 : aCompare < bCompare ? 1 : 0;
    }
  }).reduce((acc, [key, value]) => {
    acc[key] = value;
    return acc;
  }, {});
});

// Statistics
const lostCount = computed(() => filteredReports.value.filter(item => item.status === 'Lost').length);
const foundCount = computed(() => filteredReports.value.filter(item => item.status === 'Found').length);
const barangayCount = computed(() => Object.keys(barangaySummary.value).length);

// Methods
const getBarangayStatus = (data) => {
  if (data.Lost > data.Found) return 'high-risk';
  if (data.Found > data.Lost) return 'positive';
  return 'neutral';
};

const viewBarangayDetails = (barangay) => {
  // Navigate to barangay-specific view
  console.log('View details for:', barangay);
};

const exportSummary = () => {
  // Export functionality
  console.log('Export summary');
};

const navigateTo = (id) => {
  router.visit(route('viewItemInfoAsAdmin', { item: id }));
};
</script>

<style scoped>
.dashboard-container {
  width: 100%;
  background: #f8fafc;
  height: auto;
  overflow: hidden;
  margin-top: 2rem;
}

.dashboard-header {
  margin-bottom: 2rem;
}

.dashboard-title {
  font-size: 2.5rem;
  font-weight: 800;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  margin-bottom: 0.5rem;
}

.dashboard-subtitle {
  color: #64748b;
  font-size: 1.1rem;
}

/* Controls Section */
.controls-section {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
  margin-bottom: 2rem;
}

.search-container {
  margin-bottom: 1.5rem;
}

.search-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  background: #f8fafc;
  border-radius: 15px;
  padding: 0.75rem 1rem;
  border: 2px solid #e2e8f0;
  transition: all 0.3s ease;
}

.search-wrapper:focus-within {
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.search-icon {
  color: #64748b;
  margin-right: 0.75rem;
  font-size: 1.1rem;
}

.search-input {
  flex: 1;
  border: none;
  background: none;
  outline: none;
  font-size: 1rem;
  color: #2d3748;
}

.search-input::placeholder {
  color: #94a3b8;
}

.filter-icon {
  color: #64748b;
  cursor: pointer;
  padding: 0.5rem;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.filter-icon:hover {
  background: #e2e8f0;
  color: #667eea;
}

/* Filter Buttons */
.filters-container {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.filter-buttons-group {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.filter-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  background: white;
  color: #64748b;
  font-weight: 600;
  transition: all 0.3s ease;
  cursor: pointer;
}

.filter-btn:hover {
  border-color: #667eea;
  color: #667eea;
  transform: translateY(-2px);
}

.filter-btn.active {
  background: #667eea;
  border-color: #667eea;
  color: white;
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
}

.filter-btn.lost.active {
  background: #f56565;
  border-color: #f56565;
}

.filter-btn.found.active {
  background: #48bb78;
  border-color: #48bb78;
}

.barangay-filters {
  display: flex;
  gap: 0.75rem;
  flex-wrap: wrap;
  padding-top: 1rem;
  border-top: 1px solid #e2e8f0;
}

.barangay-filter-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  background: #f8fafc;
  color: #64748b;
  font-size: 0.875rem;
  transition: all 0.3s ease;
  cursor: pointer;
}

.barangay-filter-btn:hover {
  background: #e2e8f0;
}

.barangay-filter-btn.active {
  background: #667eea;
  border-color: #667eea;
  color: white;
}

/* Statistics Cards */
.stats-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.stat-card {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  display: flex;
  align-items: center;
  gap: 1.5rem;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  border-left: 4px solid #667eea;
}

.stat-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
}

.stat-card.lost {
  border-left-color: #f56565;
}

.stat-card.found {
  border-left-color: #48bb78;
}

.stat-card.barangays {
  border-left-color: #ed8936;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 15px;
  background: linear-gradient(135deg, #667eea, #764ba2);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.5rem;
}

.stat-card.lost .stat-icon {
  background: linear-gradient(135deg, #f56565, #ed8936);
}

.stat-card.found .stat-icon {
  background: linear-gradient(135deg, #48bb78, #38a169);
}

.stat-card.barangays .stat-icon {
  background: linear-gradient(135deg, #ed8936, #dd6b20);
}

.stat-content h3 {
  font-size: 2.5rem;
  font-weight: 800;
  margin: 0;
  color: #2d3748;
}

.stat-content p {
  margin: 0;
  color: #64748b;
  font-weight: 600;
}

/* Summary Section */
.summary-section {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
}

.section-header h2 {
  font-size: 1.75rem;
  font-weight: 700;
  color: #2d3748;
  margin: 0;
}

.action-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 12px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.action-btn:hover {
  background: #5a67d8;
  transform: translateY(-2px);
}

/* Table Styles */
.table-container {
  overflow-x: auto;
}

.modern-table {
  width: 100%;
  border-collapse: collapse;
}

.modern-table th {
  background: #f8fafc;
  padding: 1rem;
  text-align: left;
  font-weight: 600;
  color: #64748b;
  border-bottom: 2px solid #e2e8f0;
}

.modern-table td {
  padding: 1rem;
  border-bottom: 1px solid #e2e8f0;
}

.sortable {
  cursor: pointer;
  transition: all 0.3s ease;
  user-select: none;
}

.sortable:hover {
  background: #e2e8f0;
}

.sort-icon {
  margin-left: 0.5rem;
  font-size: 0.875rem;
}

.table-row {
  transition: all 0.3s ease;
  cursor: pointer;
}

.table-row:hover {
  background: #f8fafc;
  transform: scale(1.01);
}

.barangay-cell {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-weight: 600;
  color: #2d3748;
}

.barangay-icon {
  color: #667eea;
}

.count-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-weight: 600;
  font-size: 0.875rem;
}

.count-badge.lost {
  background: #fed7d7;
  color: #c53030;
}

.count-badge.found {
  background: #c6f6d5;
  color: #276749;
}

.count-badge.total {
  background: #e2e8f0;
  color: #4a5568;
}

.status-indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
}

.status-indicator.high-risk {
  background: #f56565;
}

.status-indicator.positive {
  background: #48bb78;
}

.status-indicator.neutral {
  background: #e2e8f0;
}

/* Empty State */
.empty-state {
  text-align: center;
  padding: 4rem 2rem;
  color: #64748b;
}

.empty-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
  opacity: 0.5;
}

.empty-state h3 {
  margin: 0 0 0.5rem 0;
  color: #4a5568;
}

/* Responsive Design */
@media (max-width: 768px) {
  .dashboard-container {
    padding: 1rem;
  }
  
  .dashboard-title {
    font-size: 2rem;
  }
  
  .controls-section {
    padding: 1.5rem;
  }
  
  .filter-buttons-group {
    flex-direction: column;
  }
  
  .stats-cards {
    grid-template-columns: 1fr;
  }
  
  .section-header {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
}

@media (max-width: 480px) {
  .stat-card {
    flex-direction: column;
    text-align: center;
    padding: 1.5rem;
  }
  
  .modern-table {
    font-size: 0.875rem;
  }
  
  .modern-table th,
  .modern-table td {
    padding: 0.75rem 0.5rem;
  }
}
</style>