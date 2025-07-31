<script setup>
import { ref, defineProps, watch, computed } from 'vue';
import ProfileWithName from './ProfileWithName.vue';
import { router } from '@inertiajs/vue3';

const props = defineProps({
  items: {
    type: Array,
    default: () => []
  }
});

let itemContainer = ref([]);

watch(
  () => props.items,
  (newItem) => {
    itemContainer.value = newItem;
    console.log("items: ", JSON.stringify(props.items, null, 2));
  },
  { immediate: true }
);

const matched = computed(() => {
  return itemContainer.value.flatMap(item => item.matchedLostItems || []);
});
const viewItem = (getId) => {
  router.get(route('viewItemInfoAsAdmin', {id: getId}))
}
</script>

<template>
  <div class="page-container">
    <div class="container my-5">
      <!-- No Matches Message -->
      <div v-if="matched.length === 0" class="text-center py-5">
        <h2 class="text-muted">No Matched Items</h2>
      </div>

      <!-- Matched Items List with Scroll -->
      <div v-else class="scroll-container">
        <div
          v-for="(item, index) in itemContainer"
          :key="index"
          class="card bg-light border-0 mb-4"
        >
          <div class="card-body">
            <div class="row mb-3">
              <div class="col">
                <h5 class="text-secondary lost-text">Lost</h5>
              </div>
              <div class="col">
                <h5 class="text-secondary found-text">Found</h5>
              </div>
            </div>

            <div class="row align-items-center">
              <!-- Lost Item -->
              <div class="col-md-5 text-start" v-if="item.matchedLostItems.length > 0">
                <div class="image-container">
                  <img
                    :src="item.matchedLostItems[0].image_url || 'https://via.placeholder.com/100'"
                    alt="Lost Item"
                    class="mb-2 pointer"
                    @click="viewItem(item.matchedLostItems[0].id)"
                  />
                </div>
                <div class="fw-bold fs-5 mt-3">{{ item.matchedLostItems[0].title }}</div>
                <div class="text-muted small">{{ item.matchedLostItems[0].description }}</div>
                <ProfileWithName
                  :id="item.matchedLostItems[0]?.user.id"
                  :name="item.matchedLostItems[0]?.user.name"
                  :profile="item.matchedLostItems[0]?.user.user_info.profile_pic"
                  class="text-secondary small"
                />
              </div>

              <!-- Arrow Icon -->
              <div class="col-md-2 text-center text-primary">
                <img
                  src="../../../../images/arrow2.png"
                  alt="Arrow Icon"
                  style="max-width: 100px; max-height: 100px;"
                  class="mb-2"
                />
              </div>

              <!-- Found Item -->
              <div class="col-md-5 text-start">
                <div class="image-container">
                  <img
                    :src="item.foundItem.image_url || 'https://via.placeholder.com/100'"
                    alt="Found Item"
                    class="mb-2 pointer"
                     @click="viewItem(item.foundItem.id)"
                  />
                </div>
                <div class="fw-bold fs-5 mt-3">{{ item.foundItem.title }}</div>
                <div class="text-muted small">{{ item.foundItem.description }}</div>
                <ProfileWithName
                  :id="item.foundItem?.user.id"
                  :name="item.foundItem?.user.name"
                  :profile="item.foundItem?.user.user_info.profile_pic"
                  class="text-secondary small"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.page-container {
  height: 100vh;
  overflow-y: auto;
  padding-bottom: 5rem; 
}

.card {
  border-radius: 12px;
}

.image-container {
  width: 320px;
  height: 320px;
  overflow: hidden;
  padding: 0;
}

.image-container img {
  position: relative;
  width: 100%;
  height: 100%;
  transition: 0.5s;
}

.image-container:hover img {
  transform: scale(1.1);
}

.scroll-container {
  padding-right: 8px;
  overflow-x: hidden;
}

.lost-text {
  transform: translateX(30%);
}

.found-text {
  transform: translateX(45%);
}
.pointer{
  cursor: pointer;
}
</style>
