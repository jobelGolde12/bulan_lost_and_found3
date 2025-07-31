<script setup>
import { Head, Link } from '@inertiajs/vue3';
import AdminSettingsLayout from '@/Layouts/settings/AdminSettingsLayout.vue';
import { defineProps, ref, watch } from 'vue';
import TrashLayout from '@/Layouts/TrashLayout.vue';
import AnnouncementTrashedTable from '@/Components/settings/AnnouncementTrashedTable.vue';

const props = defineProps({
    trashedAnnouncements: {
        type: Object,
        default: () => ({})
    }
})

let getTrashed = ref([]);
watch(
    () => props.trashedAnnouncements,
    (newItem) => {
        getTrashed.value = Array.isArray(newItem) ? newItem : [];
    },
    { immediate: true }
)
</script>

<template>
<div>
    <Head title="View Announcement Trashed" />
    <AdminSettingsLayout>
        <TrashLayout>
        <div class="main-container p-4">
            <div v-if="getTrashed.length > 0">
                    <AnnouncementTrashedTable :data="getTrashed"/>
            </div>
            <div v-else class="container mt-5 text-center">
                <p class="text-muted">No trashed announcements found.</p>
            </div>
        </div>
        </TrashLayout>
    </AdminSettingsLayout>
</div>
</template>

<style scoped>
.main-container {
    width: 100%;
}
</style>
