

<script setup>
import AdminSettingsLayout from '@/Layouts/settings/AdminSettingsLayout.vue';
import { defineProps } from 'vue';
import { Head } from '@inertiajs/vue3';
const props = defineProps({
    hasUnread: {
        type: Boolean,
        default: false
    }
});
</script>

<template>
    <AdminSettingsLayout :hasUnread="hasUnread">
        <Head title="Settings" />

        <div class="container-fluid d-flex flex-column justify-content-center align-items-center">
            <div>
                <img src="../../../../images/settings/undraw_welcome_nk8k.svg" 
                alt="Settings image"
                class="icon"
                >
            </div>
            <div class="text-center">
                Start to click the options on the left sidebar <br> to manage your account settings.
            </div>
        </div>
    </AdminSettingsLayout>
</template>


<style scoped>
.icon {
    width: 300px;
    height: 300px;
}
</style>