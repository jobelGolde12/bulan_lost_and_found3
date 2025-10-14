<script setup>
import { defineProps, ref, watch, computed } from 'vue';
import { router } from '@inertiajs/vue3'; 
const props = defineProps({
  reports: {
    type: Array,
    default: () => [],
  },
});

const formatDate = (dateString) => {
  const options = { year: 'numeric', month: 'long', day: 'numeric' };
  return new Date(dateString).toLocaleDateString(undefined, options);
};

let getReports = ref([]);
let searchQuery = ref(''); // Track the search query

watch(
  () => props.reports,
  (newItem) => {
    getReports.value = newItem;
  },
  { immediate: true }
);

// Filtered reports based on the search query
const filteredReports = computed(() => {
  const query = searchQuery.value.toLowerCase();
  return getReports?.value.filter((item) =>
    item?.title?.toLowerCase().includes(query) ||
    item?.category?.toLowerCase().includes(query) ||
    item?.status?.toLowerCase().includes(query)
  );
});

const navigateTo = (id) => {
  router.visit(route('viewItemInfoAsAdmin', { item: id }));
};
</script>

<template>
  <div>
    <div class="container-fluid mt-5 px-0">
      <div class="card border-0">
        <div class="card-body">
          <div class="header-container d-flex mb-3 container-fluid justify-content-between">
            <div>
               <h5 class="card-title">Recent Lost & Found Reports</h5>
            </div>
              <div class="search-container">
                <input
                  v-model="searchQuery"
                  type="text"
                  class="form-control search"
                  placeholder="Search by item name, category, or status"
                />
              </div>
          </div>
          <div class="table-container">
            <table class="table">
              <thead>
                <tr>
                  <th> Name</th>
                  <th>Date</th>
                  <th>Category</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="(item, index) in filteredReports"
                  :key="index"
                  @click="navigateTo(item.id)"
                  class="clickable-row"
                >
                  <td>{{ item.title }}</td>
                  <td>{{ formatDate(item.created_at) || 'N/A' }}</td>
                  <td>{{ item.category }}</td>
                  <td
                    class="fw-semibold"
                    :class="{ 'text-danger': item.status === 'Lost' }"
                  >
                    {{ item.status }}
                  </td>
                </tr>
                <tr v-if="filteredReports.length === 0">
                  <td colspan="4" class="text-center text-muted">No recent reports available this month.</td>
                </tr>
              </tbody>
            </table>
          </div>
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
}
.table th,
.table td {
  white-space: nowrap;
  text-align: left;
  padding: 0.5rem;
}
.clickable-row {
  cursor: pointer;
  transition: background-color 0.2s ease;
}
.clickable-row:hover {
  background-color: #f9f9f9;
}
.search{
  width: 30vw;
}
.header-container{
  flex-direction: row;
  align-items: center;
}
@media screen and (max-width: 768px){
  .card h5{
    font-size: 1rem;
  }
  .header-container{
  flex-direction: column;
  text-align: left;
  align-items: start;
}
.search-container{
  width: 100%;
  position: relative;
}
.card .search{
  width: 70%;
}
}

</style>
