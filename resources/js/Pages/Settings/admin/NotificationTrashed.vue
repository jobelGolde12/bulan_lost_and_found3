<script setup>
import TrashLayout from '@/Layouts/TrashLayout.vue';
import { defineProps, ref, watch } from 'vue';
import AdminSettingsLayout from '@/Layouts/settings/AdminSettingsLayout.vue';
import NotificationTrashedTable from '@/Components/settings/NotificationTrashedTable.vue';
import { Head } from '@inertiajs/vue3';
const props = defineProps({
    notifications: {
        type: Array,
        default: () => []
    }
})
let getNotifications = ref([]);
watch(
    () => props.notifications,
    (newData) => {
        getNotifications.value = Array.isArray(newData) ? newData : [newData];
    },
    {immediate: true}
)

</script>

<template>
    <div>
        <Head title="Notification trashed" />
        <AdminSettingsLayout>
            <TrashLayout >
            <div class="container" v-if="getNotifications.length > 0">
                <NotificationTrashedTable :data="getNotifications" />
            </div>
            <div class="container text-center mt-5" v-else>
                <p class="text-muted">No trashed notification.</p>
            </div>
            </TrashLayout>
        </AdminSettingsLayout>
    </div>
</template>


<style lang="css" scoped>

</style>