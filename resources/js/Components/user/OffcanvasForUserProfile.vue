<script setup>
import { Link } from "@inertiajs/vue3";
import MyPermission from "@/Components/MyPermission.vue";
import { defineProps } from "vue";

const props = defineProps({
    permission: {
        type: Object,
        default: () => ({})
    }
})
</script>

<template>
    <div>
        <div
            class="container-fluid d-flex flex-row justify-content-end px-5 pt-3"
        >
            <a
                class="btn btn-light bi bi-person-lines-fill fs-5"
                data-bs-toggle="offcanvas"
                href="#offcanvasExample"
                role="button"
                aria-controls="offcanvasExample"
            ></a>
        </div>
        <div
            class="offcanvas offcanvas-end"
            tabindex="-1"
            id="offcanvasExample"
            aria-labelledby="offcanvasExampleLabel"
        >
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasExampleLabel">
                    Profile settings
                </h5>
                <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="offcanvas"
                    aria-label="Close"
                ></button>
            </div>
            <div class="offcanvas-body">
                <div
                    class="container d-flex flex-column gap-2 justify-content-start"
                >
                    <Link
                        :href="route('profile.edit')"
                        class="px-2 py-1 text-start rounded text-decoration-none text-dark"
                        >
                        <i class="bi bi-pencil me-2"></i>
                        Edit profile
                    </Link>
                    <Link
                        :href="route('logout')"
                        method="POST"
                        class="px-2 py-1 text-start rounded"
                        >
                        <i class="bi bi-escape me-2"></i>
                        Logout
                    </Link>

                    <Link
                        :href="route('viewLater.view')"
                        class="px-2 py-1 text-start rounded text-decoration-none text-dark"
                        >
                        <i class="bi bi-bookmark me-2"></i>
                        Saved
                    </Link>

                    <MyPermission :permission="props.permission"/>

                </div>
            </div>
        </div>
    </div>
</template>
<style lang="css" scoped></style>
