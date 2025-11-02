<script setup>
import { computed, ref } from "vue";
import { Link } from "@inertiajs/vue3";

const props = defineProps({
  items: {
    type: Array,
    default: [],
  },
});

const itemContainer = computed(() => props.items);

// Track expanded descriptions per item
const expanded = ref({});

const toggleExpand = (id) => {
  expanded.value[id] = !expanded.value[id];
};

// Helper function to limit description
const getDisplayDescription = (desc, id) => {
  if (!desc) return "";
  const words = desc.split(" ");
  if (words.length <= 9) return desc;
  if (expanded.value[id]) return desc;
  return words.slice(0, 9).join(" ") + "...";
};
</script>

<template>
  <div
    class="card-container container-fluid d-flex flex-row flex-wrap mt-4 gap-3 justify-content-center"
    v-if="itemContainer"
  >
    <div class="card bg-light" v-for="data in itemContainer" :key="data.id">
      <Link
        :href="route('view.pending', { item: data?.id })"
        class="text-decoration-none"
      >
        <div class="image-container">
          <img
            :src="data.image_url"
            class="card-img-top"
            alt="Item image"
            v-if="data.image_url"
          />
        </div>
      </Link>

      <div class="card-body">
        <div class="d-flex flex-column gap-0 m-0 p-0">
          <h5 class="card-title text-dark mb-0 fw-bolder">{{ data.title }}</h5>

          <p class="card-text text-muted m-0">
            {{ getDisplayDescription(data.description, data.id) }}
            <span
              v-if="data.description && data.description.split(' ').length > 9"
              class="see-more"
              @click="toggleExpand(data.id)"
            >
              {{ expanded[data.id] ? "See less" : "See more" }}
            </span>
          </p>

          <p class="text-success m-0">{{ data.category || "null" }}</p>
        </div>

        <div
          class="container-fluid bottom d-flex flex-row justify-content-between align-items-center px-0 pt-2"
        >
          <div class="left">
            <Link
              :href="route('view.userAsUser', { id: data?.user.id })"
              class="ps-0 d-flex flex-row gap-2 align-items-center text-dark text-decoration-none"
            >
              <div>
                <img
                  :src="`/storage/${data.user?.user_info?.profile_pic}` || '../../images/profile.jpeg'"
                  alt="profile"
                  class="default-profile"
                />
              </div>
              <div class="owner_name">{{ data.user?.name || "user" }}</div>
            </Link>
          </div>
        </div>
      </div>
    </div>

    <div class="container text-center" v-if="itemContainer.length === 0">
      No Item.
    </div>

    <div class="container-bottom mt-5"></div>
  </div>
</template>

<style scoped>
.card-container {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow-y: scroll;
  overflow-x: hidden;
  padding-bottom: 2rem;
}

.card {
  border-radius: 8px;
  max-width: 18rem;
  width: 100%;
  min-height: 300px;
  padding: 15px;
  background-color: white;
  cursor: pointer;
  border: none;
}

.card .card-body .bottom {
  position: relative;
  bottom: 0;
}

.image-container {
  width: 100%;
  height: 200px;
  overflow: hidden;
  border-radius: 8px;
}

.image-container .card-img-top {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: top;
  transition: 0.5s;
}

.image-container .card-img-top:hover {
  transform: scale(1.1);
  filter: brightness(0.8);
}

.card-body {
  padding: 10px 0;
}

.container-bottom {
  width: 100%;
  height: 200px;
}

.default-profile {
  width: 30px;
  height: 30px;
  border-radius: 50%;
}

.see-more {
  color: #007bff;
  cursor: pointer;
  font-weight: 500;
  margin-left: 5px;
}

@media (max-width: 768px) {
  .card {
    max-width: 100%;
  }
}
</style>
