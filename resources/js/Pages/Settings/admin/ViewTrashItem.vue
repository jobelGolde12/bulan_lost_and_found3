<script setup>
import { Head, Link } from "@inertiajs/vue3";
import AdminSettingsLayout from "@/Layouts/settings/AdminSettingsLayout.vue";
import { defineProps, ref, watch } from "vue";

const props = defineProps({
    trashedItem: {
        type: Object,
        default: () => ({}),
    },
});

let getItem = ref({});
watch(
    () => props.trashedItem,
    (newItem) => {
        getItem.value = newItem;
    },
    { immediate: true }
);

const formatDate = (dateString) => {
    const options = { year: "numeric", month: "long", day: "numeric" };
    return new Date(dateString).toLocaleDateString(undefined, options);
};
</script>

<template>
    <div>
        <Head title="View Item" />
        <AdminSettingsLayout>
            <div class="flex flex-col items-center justify-center p-4 md:p-8">
                <div
                    class="grid w-full max-w-4xl grid-cols-1 gap-6 p-6 bg-white border rounded-lg shadow-md md:grid-cols-2"
                >
                    <!-- Image Section -->
                    <div class="flex items-center justify-center">
                        <img
                            v-if="getItem?.image_url"
                            :src="getItem.image_url"
                            alt="Item image"
                            class="object-cover w-full max-w-xs rounded-lg shadow-md"
                        />
                        <img
                            v-else
                            src="../../../../images/noImage.jpg"
                            alt="No image available"
                            class="object-cover w-full max-w-xs rounded-lg shadow-md"
                        />
                    </div>

                    <!-- Description Section -->
                    <div>
                        <h1 class="text-2xl font-semibold text-gray-800">
                            {{ getItem.title || "No name provided" }}
                        </h1>
                        <p class="mt-4 text-gray-600">
                            <strong>Description:</strong>
                            {{ getItem.description || "No description added" }}
                        </p>
                        <p class="mt-2 text-gray-600">
                            <strong>Status:</strong>
                            <span
                                :class="{
                                    'text-red-500': getItem.status === 'Lost',
                                    'text-green-500': getItem.status === 'Found',
                                }"
                            >
                                {{ getItem.status }}
                            </span>
                        </p>
                        <p class="mt-2 text-gray-600">
                            <strong>Location:</strong>
                            {{ getItem.location || "No location added" }}
                        </p>
                        <p v-if="getItem.category" class="mt-2 text-gray-600">
                            <strong>Category:</strong> {{ getItem.category }}
                        </p>
                        <p class="mt-2 text-gray-600">
                            <strong>Created at:</strong>
                            {{ formatDate(getItem.created_at) }}
                        </p>

                        <Link
                            :href="route('trash.trashItemRoute')"
                            class=" text-decoration-none inline-block px-4 py-2 mt-6 text-sm font-medium text-white bg-gray-800 rounded-lg hover:bg-gray-700"
                        >
                            Back
                        </Link>
                    </div>
                </div>
            </div>
        </AdminSettingsLayout>
    </div>
</template>

<style scoped>
/* Optional additional styling */
</style>
