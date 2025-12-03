<script setup>
import { ref } from 'vue'
import { router } from '@inertiajs/vue3'
import ItemCard from '@/Components/ItemCard.vue'
import { Head } from '@inertiajs/inertia-vue3'
import AdminLayout from '@/Layouts/AdminLayout.vue'
const props = defineProps({
  items: Array
})

console.log("Total lost ietms => " + JSON.stringify(props.items))
const viewMode = ref('table')

const goToDetail = (id) => {
  router.get(route('viewLostItem', id))
}
</script>

<template>
    <Head title="total lost item" />
    <AdminLayout>
        <div class="container py-5">
      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Total Lost Items <span class="bg-success text-light number-of-lost-item">{{ props.items?.length }}</span></h2>
        <div>
          <button @click="viewMode = 'table'" class="btn btn-outline-success me-2" :class="{ active: viewMode === 'table' }">
            Table View
          </button>
          <button @click="viewMode = 'card'" class="btn btn-outline-success" :class="{ active: viewMode === 'card' }">
            Card View
          </button>
        </div>
      </div>
  
      <!-- Table View -->
      <div v-if="viewMode === 'table'" class="table-responsive">
        <table class="table table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th>Item</th>
              <th>Description</th>
              <th>Category</th>
              <th>Location</th>
              <!-- <th>Status</th> -->
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in items" :key="item.id" @click="goToDetail(item.id)" style="cursor: pointer;">
              <td>{{ item?.title }}</td>
              <td>{{ item?.description }}</td>
              <td>{{ item?.category || 'N/A' }}</td>
              <td>{{ item?.location }}</td>
              <!-- <td>
                <span :class="['badge', item.status === 'lost' ? 'bg-danger' : 'bg-success']">
                  {{ item.status }}
                </span>
              </td> -->
            </tr>
          </tbody>
        </table>
      </div>
  
      <!-- Card View -->
      <ItemCard v-else :items="items" />
    </div>
    </AdminLayout>
  </template>
  

  <style scoped>
  .btn.active {
    background-color: #198754;
  }
  
  .table-hover tbody tr:hover {
    background-color: #f8f9fa;
    transition: background 0.2s;
  }
  .number-of-lost-item{
    font-size: 1rem;
    padding: .3rem .7rem;
    border-radius: 50%;
    transform: translateY(-30%);
    position: absolute;
  }
  </style>
  