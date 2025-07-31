<script setup>
import { router, usePage, Head, Link } from "@inertiajs/vue3";
import { ref, watch, computed, defineProps } from "vue";
import AdminLayout from "@/Layouts/AdminLayout.vue";

const props = defineProps({
    users: Object,
});

let getUsers = ref([]);
let searchQuery = ref("");
let sortOption = ref("");
let userName = usePage().props?.auth?.user.name;

watch(
    () => props.users,
    (newItem) => {
        getUsers.value = newItem;
    },
    { immediate: true }
);

const filteredUsers = computed(() => {
    let filtered = getUsers.value;

    if (searchQuery.value.trim() !== "") {
        filtered = filtered.filter(user =>
            user.name.toLowerCase().includes(searchQuery.value.toLowerCase())
        );
    }

    if (sortOption.value === "name") {
        filtered = [...filtered].sort((a, b) => a.name.localeCompare(b.name));
    } else if (sortOption.value === "role") {
        filtered = [...filtered].sort((a, b) => a.role.localeCompare(b.role));
    }

    return filtered;
});

function viewUser(userId) {
    router.visit(route('viewUserAsAdmin', {id: userId}));
}
</script>

<template>
    <Head title="view users" />
    <AdminLayout>
        <div class="p-4 rounded users-container d-flex flex-row justify-content-center align-items-center pt-3">
            <div class="container rounded">
                <!-- Header -->
                <div class="header-container container-fluid py-3 d-flex justify-content-between mb-3">
                    <div class="w-50">
                        <h2 class="fw-bold all-users-text">All users</h2>
                    </div>
                    <!-- Search -->
                    <div class="input-group d-flex justify-content-end search-container">
                        <span class="input-group-text">
                            <i class="bi bi-search"></i>
                        </span>
                        <input
                            type="text"
                            class="form-control search"
                            placeholder="Search by name..."
                            v-model="searchQuery"
                        />
                    </div>
                </div>

                <!-- Sort -->
                <div class="container-fluid d-flex justify-content-end mb-3">
                    <select class="form-select w-auto" v-model="sortOption">
                        <option value="" disabled>Sort by</option>
                        <option value="name">Name (A-Z)</option>
                        <option value="role">Role</option>
                    </select>
                </div>

                <!-- Scrollable Table -->
                <div class="table-wrapper">
                    <table class="table table-responsive align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Users Name</th>
                                <th>Role</th>
                                <th>Phone Number</th>
                                <th>Email</th>
                                <th>ID</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="user in filteredUsers" :key="user.id">
                                <td>
                                    {{ user.name }}
                                    <span v-if="user.name === userName" class="bg-success text-light p-1 rounded">Me</span>
                                </td>
                                <td :class="{'text-success' : user.role === 'admin'}">{{ user.role }}</td>
                                <td>{{ user.info?.contact ?? "N/A" }}</td>
                                <td>{{ user.email }}</td>
                                <td>{{ user.id }}</td>
                                <td>
                                    <Link class="btn btn-success" :href="route('profile')" v-if="user.role === 'admin'">View</Link>
                                    <button class="btn btn-success" 
                                    @click="viewUser(user.id)" 
                                    :class="{'disabled': user.name === userName}"
                                    v-else
                                    >
                                        View
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>

<style scoped>
.search {
    max-width: 35%;
    right: 0;
}
.users-container .container {
    background: #ffffff;
}
.users-container .container{
    padding: 2.5rem;
}
.all-users-text{
    font-size: 1.9rem;
}
/* Scroll wrapper */
.table-wrapper {
    max-height: 400px;
    overflow-y: auto;
}
.header-container{
    flex-direction: row;
    align-items: start;
}
@media screen and (max-width: 576px){
    .all-users-text{
        font-size: 1.2rem;
    }
    .users-container .container{
    padding: 1rem;
    }
    .header-container{
        flex-direction: column;
    align-items: start;
    }
    .search-container{
        position: relative;
        width: 100%;
    }
    .search-container .search{
        position: absolute;
        min-width: 100%;
    }
}
</style>
