<script setup>
import TrashLayout from '@/Layouts/TrashLayout.vue';
import { defineProps, ref, watch } from 'vue';
import UserSettingsLayout from '@/Layouts/UserSettingsLayout.vue';
import NotificationTrashedTable from '@/Components/settings/NotificationTrashedTable.vue';
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
        getNotifications.value = newData;
    },
    {immediate: true}
)

</script>

<template>
    <div>
        <UserSettingsLayout>
            <div class="container">
                <h5 class="fw-light">Notification userTrashed</h5>
                <NotificationTrashedTable :data="getNotifications"/>
            </div>
        </UserSettingsLayout>
    </div>
</template>


<style lang="css" scoped>

</style>