<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Head, useForm } from '@inertiajs/vue3';
import { ref, defineProps, watch } from 'vue';
import FindMatchCard from '@/Components/admin/dashboard/FindMatchCard.vue';

const props = defineProps({
  matches: {
    type: Object,
    default: () => ({})
  },
  allItems: Array
});

let selectedFilter = ref('');
let dateValue = ref('');
let itemNameContainer = ref([]);
let itemContainer = ref([]);
const searchForm = useForm({ query: "" });


watch(
  () => props.matches,
  (newMatches) => {
    itemContainer.value = newMatches;
    itemNameContainer.value = newMatches.map(match => match.foundItem.title).filter(Boolean);
  },
  { immediate: true }
);

const filterFunc = () => {
  // optional filtering logic here
};

const sortDateFunc = () => {
  if (!dateValue.value) return;

  itemContainer.value.sort((a, b) => {
    const dateA = new Date(a.foundItem.reported_at);
    const dateB = new Date(b.foundItem.reported_at);

    return dateValue.value === 'date_asc' ? dateA - dateB : dateB - dateA;
  });
};

const handleSearch = () => {
  const query = searchForm.query.toLowerCase();
  itemContainer.value = props.matches.filter(match => {
    const fields = [
      match.foundItem.title,
      match.foundItem.description,
      match.foundItem.location,
      match.foundItem.category,
    ];

    return fields.some(field => field && field.toLowerCase().includes(query));
  });
};
</script>

<template>
  <Head title="Find match" />
  <div>
    <AdminLayout>
      <div class="container-fluid mt-3 d-flex flex-row justify-content-between align-items-center">
        <div class="d-flex flex-row gap-2">
          <!-- Sort by date  -->
          <select
            name="filter"
            id="filter"
            class="form-control bg-light mt-2 date-select"
            v-model="dateValue"
            @change="sortDateFunc"
          >
            <option disabled value="">Sort by date</option>
            <option value="date_asc">Ascending</option>
            <option value="date_desc">Descending</option>
          </select>
        </div>

        <div class="search-bar input-group mt-2">
          <input
            type="text"
            class="bg-light"
            placeholder="Search..."
            aria-label="Search"
            list="categories"
            style="outline: none"
            v-model="searchForm.query"
            @keyup.enter="handleSearch"
          />
          <datalist id="categories" v-if="itemNameContainer.length > 0">
            <option
              :value="data"
              v-for="(data, index) in itemNameContainer"
              :key="index"
            ></option>
          </datalist>
          <button class="btn btn-dark" type="button" @click="handleSearch">
            <i class="bi bi-search"></i>
          </button>
        </div>
      </div>

      <div class="container-fluid">
        <div>
          <FindMatchCard :items="itemContainer" />
        </div>
      </div>
    </AdminLayout>
  </div>
</template>

<style scoped>
.search-bar {
  position: relative;
  width: 30%;
}
.search-bar input {
  position: relative;
  width: 80%;
  padding: 0.5rem 1rem;
  border: 0.5px solid rgba(0, 0, 0, 0.2);
  border-radius: 5px 0 0 5px;
}
.search-bar input:focus,
.search-bar input:hover {
  outline: 1px solid rgba(0, 0, 0, 0.5);
}
.date-select {
  min-width: 150px;
}
.filter-item {
  min-width: 90px;
}
</style>
