<script setup>
import FilterComponent from "@/Components/user/FilterComponent.vue";
import { Head, useForm } from "@inertiajs/vue3";
import { defineProps, ref, computed, defineEmits, onMounted } from "vue";
import CategoriesList from "@/Components/user/CategoriesList.vue";
import Itemcard from "@/Components/guest/Itemcard.vue";
import GuestLayout from "@/Layouts/GuestLayout.vue";
const props = defineProps({
  categories: {
    type: Array,
    default: [],
  },
  items: {
    type: Array,
    default: [],
  },
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
  <GuestLayout>
    <div class="main-container bg-light">
      <div class="container-fluid mt-4 d-flex flex-row justify-content-between align-items-center">
        <div class="logo d-none d-sm-block d-lg-block fs-5 fw-bold">Lost And Found</div>

        <div class="search-bar input-group mb-3 d-flex justify-content-end">
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
          <button class="btn btn-dark px-3" type="button" @click="handleSearch">
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

      <FilterComponent @filterSelected="handleFilterChange" />

      <!-- Items List -->
      <Itemcard :items="getItems" />

      <div class="container" v-if="getItems.length === 0">
        <h1 class="text-dark text-center text-muted">No item found...</h1>
      </div>
    </div>
  </GuestLayout>
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
  width: 50%;
  right: 0;
}
.search-bar input {
  position: relative;
  width: 80%;
  padding: 0.5rem 1rem;
  border: 0.5px solid rgba(0, 0, 0, 0.2);
  border-radius: 30px 0 0 30px;
  
}
.search-bar button{
  border-radius: 0 30px 30px 0;
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
