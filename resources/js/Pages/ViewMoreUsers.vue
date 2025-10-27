<script setup>
import PopupForViewMoreUsers from "@/Components/message/PopupForViewMoreUsers.vue";
import ToggleAllOrBlocked from "@/Components/message/ToggleAllOrBlocked.vue";
import { ref, watch, computed, defineProps, onMounted, onBeforeUnmount } from "vue";
import { Head, router } from "@inertiajs/vue3";

const props = defineProps({
    users: Array,
    blocked_users: Array,
    toggleStatus: String,
});

let getUsers = ref([]);
const getBlockedUsers = ref([]);
let searchQuery = ref("");
let sortOption = ref("");
const showPopup = ref(false);
const popupRef = ref(null);
const selectedId = ref(0);
const popupPosition = ref({ top: 0, left: 0 });
const isBlockedValue = ref(false);
const getToggleStatus = ref('all');
watch(
    () => props.users,
    (data) => {
        getUsers.value = data;
    },
    { immediate: true }
);
watch(
    () => props.blocked_users,
    (data) => {
        getBlockedUsers.value = data;
    },
    { immediate: true }
);
watch(
    () => props.toggleStatus,
    (data) => {
        getToggleStatus.value = data;
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

function togglePopup(id, event) {
    const iconRect = event.target.getBoundingClientRect();
    popupPosition.value = {
        top: iconRect.top + window.scrollY + iconRect.height,
        left: iconRect.left + window.scrollX,
    };
    if(getBlockedUsers.value.includes(id)){
        isBlockedValue.value = true;
    }else{
        isBlockedValue.value = false;
    }
    selectedId.value = id;
    showPopup.value = true;
}

function handleClickOutside(event) {
    const popupElement = popupRef.value?.root;
    const isInsidePopup = popupElement?.contains(event.target);
    const isInsideTrigger = event.target.classList.contains("action");

    if (!isInsidePopup && !isInsideTrigger) {
        showPopup.value = false;
    }
}

onMounted(() => {
    document.addEventListener("click", handleClickOutside);
});
onBeforeUnmount(() => {
    document.removeEventListener("click", handleClickOutside);
});
function goBack() {
    router.get(route('message.index'))
}
</script>

<template>
    <Head title="view more users" />
    <div class="p-4 rounded users-container d-flex flex-row justify-content-center align-items-center pt-3">
        <div class="container rounded">
            <!-- Header -->
            <div class="header-container container-fluid py-3 d-flex justify-content-between mb-3">
                <div class="w-50">
                    <h2 class="fw-bold all-users-text" v-if="toggleStatus == 'all'">All users</h2>
                    <h2 class="fw-bold all-users-text" v-else>Blocked users</h2>
                </div>
                <!-- Search -->
                <div class="input-group d-flex justify-content-end search-container">
                    <button @click="goBack" class="fs-5 me-3 btn btn-light">
                        <i class="bi bi-caret-left  "></i>
                        Go Back
                    </button>
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

            <ToggleAllOrBlocked :status="getToggleStatus"/>

            <!-- Scrollable Table -->
            <div class="table-wrapper">
                <table class="table table-responsive align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Users Name</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="user in filteredUsers" :key="user.id">
                            <td class="d-flex flex-row gap-2 align-items-center">
                                <div>
                                    <img :src="user?.user_info?.profile_pic ? `/storage/${user?.user_info?.profile_pic}` : '../../images/profile.jpeg'" alt="Profile" class="profile-pic" />
                                </div>
                                <div :class="{'text-muted': getBlockedUsers.includes(user.id)}">
                                    {{ user.name }}
                                <span class="text-danger" v-if="getBlockedUsers.includes(user.id)">Blocked</span>
                                </div>
                            </td>
                            <td :class="{'text-muted': getBlockedUsers.includes(user.id)}">{{ user.email }}</td>
                            <td class="ps-4">
                                <i class="bi bi-three-dots action" @click="(e) => togglePopup(user.id, e)"></i>

                                <!-- For the popup -->
                                <PopupForViewMoreUsers
                                    :show="showPopup"
                                    ref="popupRef"
                                    :id="selectedId"
                                    :position="popupPosition"
                                    :isBlocked="isBlockedValue"
                                />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
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
.profile-pic{
    position: relative;
    width: 50px;
    height: 50px;
    border-radius: 50%;
}
.action{
    cursor: pointer;
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
