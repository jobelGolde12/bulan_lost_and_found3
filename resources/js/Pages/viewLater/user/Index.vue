<script setup>
import UserSettingsLayout from '@/Layouts/UserSettingsLayout.vue';
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
        <UserSettingsLayout>
             <Head title="My saved items" />
             <div class="container mt-4">
                <h5 class="text-muted">My Saved Items</h5>
                <ItemCard :items="getItems" />
             </div>
        </UserSettingsLayout>
  </div>
</template>



<style>

</style>