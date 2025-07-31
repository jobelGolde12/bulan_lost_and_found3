<script setup>
import { Head } from "@inertiajs/vue3";
import AdminSettingsLayout from "@/Layouts/settings/AdminSettingsLayout.vue";
import NotificationCard from "@/Components/NotificationCard.vue";
import { defineProps, ref, watch } from "vue";

const props = defineProps({
    notification: {
        type: Array,
        default: () => [],
    },
});

const getData = ref([]);
watch(
    () => props.notification,
    (i) => {
        getData.value = i;
    },
    { immediate: true }
);
</script>

<template>
    <div>
        <Head title="Notifications" />
        <AdminSettingsLayout>
            <div class="container ms-0"><h1>Notifications</h1></div>
            <div class="container ms-0" v-if="getData.length > 0">
                <NotificationCard :notification="getData" />
            </div>
            <div class="container mt-5 text-center text-muted" v-else>
                <p>No notification.</p>
            </div>
        </AdminSettingsLayout>
    </div>
</template>
