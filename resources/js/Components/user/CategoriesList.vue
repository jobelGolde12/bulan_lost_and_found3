<script setup>
import { ref, onMounted } from "vue";

const props = defineProps({
  categories: {
    type: Array,
    default: () => [],
  },
  currentItem: {
    type: Array,
    default: () => [],
  },
});

const emit = defineEmits(["categorySelected"]);

const activeCategory = ref("");
const filteredCategories = ref([]);

const norm = (val) => {
  if (val == null) return null;
  if (typeof val === "string") return val.trim().toLowerCase();
  if (typeof val === "object" && "name" in val) return String(val.name).trim().toLowerCase();
  return null;
};

function buildFilteredCategories() {
  if (!props.currentItem.length) {
    filteredCategories.value = [...props.categories];
    return;
  }

  const currentNames = props.currentItem.map(norm);
  filteredCategories.value = props.categories.filter((cat) => {
    const isAll =
      cat.status === "all" || (cat.name && cat.name.toLowerCase() === "all");
    return isAll || currentNames.includes(norm(cat));
  });
}

onMounted(buildFilteredCategories);

function chooseCategoryFunc(name, id) {
  activeCategory.value = id;
  emit("categorySelected", name);
}
</script>

<template>
  <div class="container-fluid d-flex align-items-center gap-2">
    <div>Categories:</div>
    <div class="category-scroll d-flex gap-2">
      <div
        class="list px-2 py-1 rounded"
        v-for="data in filteredCategories"
        :key="`${data.id}-${data.name}`"
        :class="{ 'bg-secondary text-light': activeCategory === data.id }"
        @click="chooseCategoryFunc(data.name, data.id)"
        :title="data?.description || data.name"
      >
        {{ data.name }}
      </div>
    </div>
  </div>
</template>

<style scoped>
.list {
  background: rgba(0, 0, 0, 0.1);
  cursor: pointer;
}
.list:hover {
  background: rgba(0, 0, 0, 0.2);
}
.category-scroll {
  flex: 1 1 0;
  min-width: 0;
  overflow-x: auto;
}
.category-scroll .list {
  width: auto;
  white-space: nowrap;
}
@media screen and (max-width: 756px) {
  .category-scroll {
    overflow-x: auto;
    white-space: nowrap;
    flex-wrap: nowrap;
    -webkit-overflow-scrolling: touch;
  }
  .category-scroll::-webkit-scrollbar {
    display: none;
  }
}
</style>
