<script setup>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import FilterComponent from "@/Components/user/FilterComponent.vue";
import { Head, useForm } from "@inertiajs/vue3";
import { defineProps, ref, watch, computed } from "vue";
import CategoriesList from "@/Components/user/CategoriesList.vue";
import ItemCardForAdmin from "@/Components/admin/ItemCardForAdmin.vue";
import FIlterByLocation from "@/Components/user/FIlterByLocation.vue";
import LoadingItem from "@/Components/LoadingItem.vue";
const props = defineProps({
  categories: {
    type: Array,
    default: [],
  },
  items: {
    type: Array,
    default: [],
  },
  role: {
    type: String,
    default: ''
  },
  locations: {
    type: Array,
    default: () => []
  },
  currentLocation: {
    type: String,
    default: "Location"
  }
});
const itemNameContainer = ref(props.items.map((item) => item.title));
const categoriesContainer = ref([
  { id: "", name: "All", status: "all" },
  ...props.categories,
]);

const selectedCategory = ref("");
const filterStatus = ref("all");
const searchForm = useForm({ query: "" });
const getItems = ref([...props.items]);
const getLocations = ref([]);
const getCurrentLocation = ref("Location");
let isItemLoading = ref(false);
const getCurrentItemCategory = computed(() => {
  return [...new Set(getItems.value.map(item => item.category))];
});
const filterItems = () => {
  getItems.value = props.items.filter((item) => {
    const category = props.categories.find((cat) => cat.id === item.category_id);
    const categoryName = category ? category.name : "";

    const matchesCategory =
      selectedCategory.value === "" || categoryName === selectedCategory.value;

    const matchesStatus =
      filterStatus.value === "all" || item.status === filterStatus.value;

    const matchesSearch =
      !searchForm.query ||
      item.title.toLowerCase().includes(searchForm.query.toLowerCase());

    return matchesCategory && matchesStatus && matchesSearch;
  });
};
const filterItemsByCategory = (categoryName) => {
  if (categoryName === "All" || categoryName === "") {
    getItems.value = [...props.items];
  } else {
    getItems.value = props.items.filter((item) => item.category === categoryName);
  }
};

watch(
  () => props.locations,
  (newLocations) => {
    getLocations.value = newLocations;
  }, {immediate: true}
)
watch(
  () => props.currentLocation,
  (newLocations) => {
    getCurrentLocation.value = newLocations || 0;
  }, {immediate: true}
)
const handleCategoryChange = (categoryName) => {
  selectedCategory.value = categoryName;
  filterItemsByCategory(categoryName); 
};


const handleFilterChange = (filter) => {
  filterStatus.value = filter;
  filterItems();
};

const handleSearch = () => {
  filterItems();
};
</script>

<template>
  <Head title="Dashboard" />
  <AdminLayout>
    <div class="main-container bg-light">
      <div class="container-fluid mt-4 d-flex flex-row justify-content-between align-items-center">
        <div class="logo d-none d-sm-block d-lg-block">Lost And Found</div>

        <div class="search-bar input-group mb-3">
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
          <datalist id="categories" v-if="itemNameContainer">
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

      <!-- Category & Filter -->
      <CategoriesList
        :categories="categoriesContainer"
        :currentItem="getCurrentItemCategory"
        @categorySelected="handleCategoryChange"
      />

      <div class="d-flex gap-2 align-items-center">
         <div class="w-[15]">
          <FIlterByLocation 
          :locations="getLocations"
          :currentLocation="getCurrentLocation"
          />
         </div>
        <FilterComponent 
        @filterSelected="handleFilterChange" 
        :role="props.role"
        v-model:items="getItems"
        v-model:category="selectedCategory"
        v-model:loading="isItemLoading"
        />
      </div>
      <!-- Items List -->
      <ItemCardForAdmin :items="getItems"/>
    </div>
  </AdminLayout>
</template>

<style scoped>
.main-container {
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
}
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
@media screen and (max-width: 1024px) {
  .main-container .right {
    position: absolute;
    width: 100vw;
    height: 100vh;
    top: 0;
    left: 0;
  }
}
@media screen and (max-width: 800px) {
  .search-bar {
    position: relative;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0 auto;
  }
}
</style>
