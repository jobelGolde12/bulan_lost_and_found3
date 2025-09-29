
<script setup>
import { defineProps } from 'vue';

const props = defineProps({
    item: {
        type: Object,
        default: () => ({})
    }
});
const formatDate = (dateString) => {
    const options = { year: "numeric", month: "long", day: "numeric" };
    return new Date(dateString).toLocaleDateString(undefined, options);
};
</script>

<template>
  <div class="container px-0" style="height: auto;">

    <div class="mb-6">
          <p class="text-center status fw-bolder" :class="item.status === 'Lost' ? 'text-red-600 font-semibold' : 'text-green-600'">{{ item.status }}</p>
          <img
            :src="item.image_url"
            alt="Item Image"
            class=" rounded object-cover image-item mx-auto"
          />
        </div>
        <div class="text-start date">
          <div class="fs-4 fw-bold">{{ item.title }}</div>
          <div class="text-md mb-2">{{ item.description }}</div>
          <i class="bi bi-calendar text-sm"></i> {{ formatDate(item.reported_at) }}
        </div>


     <div class="text-sm text-gray-700 space-y-1 d-none d-lg-block ">
          <p class="mb-0"><i class="bi bi-ma"></i>  {{ item.location }}</p>
          <p><i class="bi bi-telephone"></i>  {{ item.owner_phone_number || 'NA' }}</p>
          <p v-if="item.category"><strong>Category:</strong> {{ item.category  || "NA"}}</p>
        </div>

        <div class="text-sm text-gray-700 space-y-1 d-block d-lg-none">
          <p class="mb-0"><i class="bi bi-geo-alt-fill me-2"></i>{{ item.location }}</p>
          <p><i class="bi bi-telephone-fill me-2"></i> {{ item.owner_phone_number || 'NA' }}</p>
          <p v-if="item.category"><i class="bi bi-bookmark-fill me-2"></i>{{ item.category  || "NA"}}</p>
          <p><i class="bi bi-info-circle-fill me-2"></i><span :class="item.status === 'Lost' ? 'text-red-600 font-semibold' : 'text-green-600'">{{ item.status }}</span></p>
        </div>
  </div>
</template>


<style scoped>
.image-item{
    width: 400px;
    height: 300px;
}
.status{
    font-size: 4rem;
}
</style>