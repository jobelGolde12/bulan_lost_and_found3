<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { defineProps, watch, ref } from 'vue';
import { Head } from '@inertiajs/vue3';
import ItemCard from '@/Components/ItemCard.vue';
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
        <AuthenticatedLayout>
             <Head title="My saved items" />
             <div class="container mt-4">
                <h5 class="text-muted">My Saved Items</h5>
                <ItemCard :items="getItems" />
             </div>
        </AuthenticatedLayout>
  </div>
</template>



<style>

</style>