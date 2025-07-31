<script setup>
import { Link } from "@inertiajs/vue3";
import { ref } from "vue";
import { toggleRoute } from "@/piniaStore/ToggleSettingsRoute";
import { usePage } from "@inertiajs/vue3";

const role = usePage().props.auth.user?.role;
const currentRoute = usePage().url;
let selectedRoute = toggleRoute();
const changeRouteName = (text) => {
    selectedRoute.updateText(text);
};
</script>
<template>
    <div class="main-container">
        <h2 class="my-3 route-name">Settings > Trash > {{ selectedRoute.text }}</h2>

        <div class="container-fluid d-flex flex-row align-items-center gap-2">
            <Link
                :href="route('trash.trashItemRoute')"
                @click="changeRouteName('Items')"
                class="list px-2 py-1 rounded text-decoration-none text-dark"
                :class="{'bg-secondary text-light': currentRoute == '/trash/index'}"
                >Items</Link
            >
            <Link
                :href="route('announcementTrashed.index')"
                @click="changeRouteName('Announcements')"
                class="list px-2 py-1 rounded text-decoration-none text-dark"
                >Announcements</Link
            >
            <Link
                :href="route('notificationTrashed.index')"
                @click="changeRouteName('Notifications')"
                class="list px-2 py-1 rounded text-decoration-none text-dark"
                >Notifications</Link
            >
            <Link
                :href="route('userTrashed.index')"
                @click="changeRouteName('Users')"
                class="list px-2 py-1 rounded text-decoration-none text-dark"
                >Users</Link
            >
        </div>
        <main>
            <slot />
        </main>
    </div>
</template>
<style lang="css" scoped>
.main-container {
    width: 100%;
    height: 100%;
}
.list {
    background: rgba(0, 0, 0, 0.1);
    cursor: pointer;
}
.list:hover {
    background: rgba(0, 0, 0, 0.2);
}
.route-name{
    font-size: 1.7rem;
}
@media screen and (max-width: 768px){
.route-name{
    font-size: 1.4rem;
}
}
</style>
