<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineProps, watch, ref } from 'vue';
import { Head } from '@inertiajs/vue3';
import ItemCardForAdmin from '@/Components/admin/ItemCardForAdmin.vue';
const props = defineProps({
    items: {
        type: Array,
        default: () => []
    }
})
const getItems = ref([]);
watch(
    () => props.items,
    (data) => {
        getItems.value = data;
        console.table(props.items)
    }, {immediate: true}
)
</script>

<template>
  <div>
        <AdminLayout>
             <Head title="My saved items" />
             <div class="container mt-4">
                <h5 class="text-muted">My Saved Items</h5>
                <ItemCardForAdmin :items="getItems" />
             </div>
        </AdminLayout>
  </div>
</template>



<style>

</style>