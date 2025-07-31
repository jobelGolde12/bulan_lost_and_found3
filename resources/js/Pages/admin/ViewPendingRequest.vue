
<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import PendingCard from '@/Components/admin/PendingCard.vue';
import { defineProps, ref, watch } from 'vue';
import { Head } from '@inertiajs/vue3';
const props = defineProps({
    items: {
        type: Array,
        default: () => [],
    }
})
let getItem = ref([])

watch(
    () => props.items,
    (newVal) => {
        getItem.value = newVal
    },
    {
        immediate: true
    }
)
// console.log("pending item => " + getItem?.user)
</script>
<template>
    <Head title="view pending request" />
    <AdminLayout>
        <div>
            <div class="container ps-2 pt-4">
                <h4 class="text-dark mb-0">Pending Requests...</h4>
                <p class="text-success">Total: {{ getItem.length }}</p>
            </div>
         </div>

         <PendingCard :items="getItem" />
    </AdminLayout>
</template>

<style lang="css" scoped>

</style>