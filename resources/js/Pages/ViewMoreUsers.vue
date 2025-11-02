<script setup>
import PopupForViewMoreUsers from "@/Components/message/PopupForViewMoreUsers.vue";
import ToggleAllOrBlocked from "@/Components/message/ToggleAllOrBlocked.vue";
import { ref, watch, computed, defineProps, onMounted, onBeforeUnmount } from "vue";
import { Head, router } from "@inertiajs/vue3";
import axios from "axios";

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
let offset = ref(0);
const limit = 10;
const isLoading = ref(false);
const isInitialLoading = ref(true);
const hasMore = ref(true);
const loadingStates = ref({}); // For individual action loading states

// Enhanced loading states
watch(
    () => props.users,
    (data) => {
        getUsers.value = data;
        isInitialLoading.value = false;
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
    // Simulate initial loading delay for better UX
    setTimeout(() => {
        isInitialLoading.value = false;
    }, 800);
});
onBeforeUnmount(() => {
    document.removeEventListener("click", handleClickOutside);
});

function goBack() {
    router.get(route('message.index'))
}

async function loadMore() {
    if (isLoading.value || !hasMore.value) return;
    
    offset.value += limit;
    isLoading.value = true;
    
    try {
        const res = await axios.get(`/viewMoreUsers/load-more-users/${offset.value}`);
        const newUsers = res.data.users;
        const newBlocked = res.data.blocked_users;

        if (newUsers.length < limit) {
            hasMore.value = false;
        }

        getUsers.value = [...getUsers.value, ...newUsers];
        
        newBlocked.forEach(id => {
            if (!getBlockedUsers.value.includes(id)) {
                getBlockedUsers.value.push(id);
            }
        });

    } catch (error) {
        console.error('Error loading more users:', error);
    } finally {
        isLoading.value = false;
    }
}

// Set loading state for individual actions
function setActionLoading(userId, loading) {
    loadingStates.value[userId] = loading;
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
                    <button @click="goBack" class="fs-5 me-3 btn btn-light" :disabled="isInitialLoading">
                        <i class="bi bi-caret-left"></i>
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
                        :disabled="isInitialLoading"
                    />
                </div>
            </div>

            <ToggleAllOrBlocked :status="getToggleStatus" :disabled="isInitialLoading" />

            <!-- Enhanced Loading States -->
            <div class="loading-container" v-if="isInitialLoading">
                <!-- Skeleton Loading -->
                <div class="skeleton-loading">
                    <div class="skeleton-header mb-3">
                        <div class="skeleton-line skeleton-title"></div>
                    </div>
                    <div class="skeleton-table">
                        <div class="skeleton-row" v-for="i in 5" :key="i">
                            <div class="skeleton-cell">
                                <div class="skeleton-avatar"></div>
                                <div class="skeleton-text-container">
                                    <div class="skeleton-text skeleton-name"></div>
                                    <div class="skeleton-text skeleton-email"></div>
                                </div>
                            </div>
                            <div class="skeleton-cell">
                                <div class="skeleton-text skeleton-email-full"></div>
                            </div>
                            <div class="skeleton-cell">
                                <div class="skeleton-action"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Scrollable Table -->
            <div class="table-wrapper" v-else>
                <table class="table table-responsive align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Users Name</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="user in filteredUsers" :key="user.id" class="user-row">
                            <td class="d-flex flex-row gap-2 align-items-center">
                                <div class="position-relative">
                                    <img 
                                        :src="user?.user_info?.profile_pic ? `/storage/${user?.user_info?.profile_pic}` : '../../images/profile.jpeg'" 
                                        alt="Profile" 
                                        class="profile-pic"
                                        :class="{ 'loading-image': loadingStates[user.id] }"
                                    />
                                    <div v-if="loadingStates[user.id]" class="loading-overlay">
                                        <div class="spinner-border spinner-border-sm" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                </div>
                                <div :class="{'text-muted': getBlockedUsers.includes(user.id)}">
                                    {{ user.name }}
                                    <span class="text-danger" v-if="getBlockedUsers.includes(user.id)">Blocked</span>
                                </div>
                            </td>
                            <td :class="{'text-muted': getBlockedUsers.includes(user.id)}">{{ user.email }}</td>
                            <td class="ps-4">
                                <div class="action-container position-relative">
                                    <i 
                                        class="bi bi-three-dots action" 
                                        @click="(e) => togglePopup(user.id, e)"
                                        :class="{ 'loading-action': loadingStates[user.id] }"
                                        :disabled="loadingStates[user.id]"
                                    ></i>
                                    <div v-if="loadingStates[user.id]" class="action-loading">
                                        <div class="spinner-border spinner-border-sm" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- For the popup -->
                                <PopupForViewMoreUsers
                                    :show="showPopup"
                                    ref="popupRef"
                                    :id="selectedId"
                                    :position="popupPosition"
                                    :isBlocked="isBlockedValue"
                                    @loading="setActionLoading"
                                />
                            </td>
                        </tr>
                        
                        <!-- Load More Section -->
                        <tr v-if="filteredUsers.length > 0">
                            <td colspan="3" class="text-center border-0">
                                <button 
                                    class="btn btn-outline-primary load-more-btn" 
                                    @click="loadMore" 
                                    :disabled="isLoading || !hasMore"
                                    :class="{ 'loading': isLoading }"
                                >
                                    <span v-if="isLoading" class="d-flex align-items-center justify-content-center">
                                        <div class="spinner-border spinner-border-sm me-2" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                        Loading...
                                    </span>
                                    <span v-else-if="hasMore">
                                        Load More Users
                                    </span>
                                    <span v-else class="text-muted">
                                        No more users to load
                                    </span>
                                </button>
                            </td>
                        </tr>
                        
                        <!-- Empty State -->
                        <tr v-if="filteredUsers.length === 0 && !isInitialLoading">
                            <td colspan="3" class="text-center py-5">
                                <div class="empty-state">
                                    <i class="bi bi-people display-4 text-muted"></i>
                                    <p class="text-muted mt-3">No users found</p>
                                </div>
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
    transition: opacity 0.3s ease;
}
.profile-pic.loading-image {
    opacity: 0.6;
}
.action{
    cursor: pointer;
    transition: all 0.3s ease;
}
.action:disabled,
.action.loading-action {
    opacity: 0.5;
    cursor: not-allowed;
}
.action-container {
    display: inline-block;
}
.action-loading {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

/* Loading overlay for images */
.loading-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.8);
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
}

/* Load more button styles */
.load-more-btn {
    transition: all 0.3s ease;
    min-width: 160px;
}
.load-more-btn:disabled {
    opacity: 0.6;
}
.load-more-btn.loading {
    background-color: #f8f9fa;
    border-color: #dee2e6;
}

/* Skeleton Loading Styles */
.skeleton-loading {
    padding: 1rem 0;
}
.skeleton-row {
    display: flex;
    align-items: center;
    padding: 1rem 0;
    border-bottom: 1px solid #e9ecef;
}
.skeleton-cell {
    flex: 1;
    padding: 0 0.75rem;
    display: flex;
    align-items: center;
}
.skeleton-avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: loading 1.5s infinite;
    margin-right: 12px;
}
.skeleton-text-container {
    flex: 1;
}
.skeleton-text {
    height: 12px;
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: loading 1.5s infinite;
    border-radius: 4px;
    margin-bottom: 8px;
}
.skeleton-name {
    width: 120px;
}
.skeleton-email {
    width: 180px;
}
.skeleton-email-full {
    width: 200px;
    height: 14px;
}
.skeleton-action {
    width: 24px;
    height: 24px;
    border-radius: 4px;
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: loading 1.5s infinite;
}
.skeleton-header {
    display: flex;
    align-items: center;
    padding: 0 0.75rem;
}
.skeleton-title {
    height: 24px;
    width: 150px;
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: loading 1.5s infinite;
    border-radius: 4px;
}

@keyframes loading {
    0% {
        background-position: 200% 0;
    }
    100% {
        background-position: -200% 0;
    }
}

/* Empty state styles */
.empty-state {
    opacity: 0.7;
    transition: opacity 0.3s ease;
}

/* User row transitions */
.user-row {
    transition: all 0.3s ease;
}
.user-row:hover {
    background-color: #f8f9fa;
}

/* Responsive design */
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
    .skeleton-avatar {
        width: 40px;
        height: 40px;
    }
    .skeleton-name {
        width: 80px;
    }
    .skeleton-email {
        width: 120px;
    }
}
</style>