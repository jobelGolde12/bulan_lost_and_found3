<script setup>
import { usePage, router, Head } from "@inertiajs/vue3";
import { ref, defineProps, watch } from "vue";
import AdminSettingsLayout from "@/Layouts/settings/AdminSettingsLayout.vue";
import TrashLayout from "@/Layouts/TrashLayout.vue";

const props = defineProps({
    items: {
        type: Array,
        default: () => [],
    },
    hasUnread: {
        type: Boolean,
        default: false
    }
});

const trashedItems = ref([]);
watch(
    () => props.items,
    (newItem) => {
        trashedItems.value = newItem;
    },
    { immediate: true }
);

const restoreItem = (getId) => {
    if (confirm("Are you sure you want to restore this item?")) {
        router.post(route("trash.restore", { id: getId }), {
            onSuccess: () => {
                trashedItems.value = trashedItems.value.filter(
                    (item) => item.id !== id
                );
            },
        });
    }
};

const deleteItem = (getId) => {
    if (confirm("Are you sure you want to permanently delete this item?")) {
        router.delete(route("trash.deleteItem", { id: getId }), {
            onSuccess: () => {
                trashedItems.value = trashedItems.value.filter(
                    (item) => item.id !== id
                );
            },
        });
    }
};

const viewItem = (getId) => {
    router.visit(route("viewTrashItem", { id: getId }));
};
</script>

<template>
    <Head title="Trash" />
    <AdminSettingsLayout :hasUnread="hasUnread">
        <TrashLayout>
            <div class="container mt-4">
                <div v-if="trashedItems.length === 0" class="text-center">
                    <img
                        src="../../../../images/no-data.svg"
                        alt="No Data"
                        class="w-50 mb-3 no-data-img"
                    />
                    <p>No trashed items available.</p>
                </div>

                <div v-else>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Category</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in trashedItems" :key="item.id">
                                    <td>{{ item.title }}</td>
                                    <td>{{ item.description }}</td>
                                    <td>{{ item.category }}</td>
                                    <td>
                                        <button
                                            @click="viewItem(item.id)"
                                            class="btn btn-info btn-sm me-1"
                                        >
                                            <i class="bi bi-eye d-block d-lg-none"></i>
                                            <span class="d-none d-lg-block">View</span>
                                        </button>
                                        <button
                                            @click="restoreItem(item.id)"
                                            class="btn btn-primary btn-sm me-1"
                                        >
                                             <i class="bi bi-arrow-counterclockwise d-block d-lg-none"></i>
                                             <span class="d-none d-lg-block">Restore</span>
                                        </button>
                                        <button
                                            @click="deleteItem(item.id)"
                                            class="btn btn-danger btn-sm"
                                        >
                                            <i class="bi bi-trash d-block d-lg-none"></i>
                                            <span class="d-none d-lg-block">Delete</span>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </TrashLayout>
    </AdminSettingsLayout>
</template>

<style scoped>
.no-data-img {
    width: 300px;
    height: 300px;
    margin: auto;
}
</style>
