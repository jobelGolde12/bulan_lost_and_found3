<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import { defineProps, ref, watch } from 'vue';
import CustomModal from '@/Components/CustomModal.vue';

const props = defineProps({
    user: {
        type: Object,
        default: () => ({})
    },
    isSelf: {
        type: Boolean,
        default: false
    },
});

let getUser = ref();
const showModal = ref(false);
const modalQuestion = ref('');

watch(
    () => props.user,
    (newItem) => {
        getUser.value = newItem;
    },
    { immediate: true }
);

const message = () => {
    if (props.isSelf) {
        router.get('/chat');
    } else {
        router.get(route('message.viewChat', {id: getUser.value.id}))
    }
};

const handleModalResponse = (response) => {
    if (response) {
        router.get(route('message.viewChat', {id: getUser?.id}));
    }
    showModal.value = false;
};
</script>

<template>
    <Head title="User Profile" />
    <AuthenticatedLayout>
        <div class="user-profile">
            <!-- Header Section -->
            <div class="user-profile__header">
                <div class="user-profile__avatar-container">
                    <img 
                        :src="getUser.user_info?.profile_pic ? `/storage/${getUser.user_info.profile_pic}` : '/images/profile.jpeg'" 
                        :alt="`Profile picture of ${getUser.name}`" 
                        class="user-profile__avatar"
                    >
                    <!-- <div class="user-profile__status-indicator" :class="{'user-profile__status-indicator--self': isSelf}"></div> -->
                </div>
                
                <div class="user-profile__title">
                    <h1 class="user-profile__name">
                        {{ getUser.name ?? 'Unknown User' }}
                    </h1>
                    <span class="user-profile__badge" v-if="isSelf">
                        <i class="bi bi-person-check"></i>
                        You
                    </span>
                </div>
                
                <div class="user-profile__badges">
                    <span class="user-profile__badge user-profile__badge--primary">
                        <i class="bi bi-person-circle"></i>
                        User account
                    </span>
                </div>
            </div>

            <!-- Information Section -->
            <div class="user-profile__content">
                <div class="user-profile__info-card">
                    <h2 class="user-profile__info-title">
                        <i class="bi bi-info-circle"></i>
                        Contact Information
                    </h2>
                    
                    <div class="user-profile__info-grid">
                        <!-- Email -->
                        <div class="info-item">
                            <div class="info-item__icon">
                                <i class="bi bi-envelope-fill"></i>
                            </div>
                            <div class="info-item__content">
                                <label class="info-item__label">Email Address</label>
                                <div 
                                    class="info-item__value"
                                    :class="{'info-item__value--hidden': getUser.permission?.isEmailAllow == false}"
                                >
                                    {{ getUser.email ?? 'Not provided' }}
                                </div>
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="info-item" v-if="getUser?.user_info !== null">
                            <div class="info-item__icon">
                                <i class="bi bi-telephone-fill"></i>
                            </div>
                            <div class="info-item__content">
                                <label class="info-item__label">Phone Number</label>
                                <div 
                                    class="info-item__value"
                                    :class="{'info-item__value--hidden': getUser.permission?.isPhoneAllow == false}"
                                >
                                    {{ getUser.user_info?.contact ?? 'Not provided' }}
                                </div>
                            </div>
                        </div>

                        <!-- Facebook -->
                        <div class="info-item" v-if="getUser?.user_info?.facebook_links">
                            <div class="info-item__icon">
                                <i class="bi bi-facebook"></i>
                            </div>
                            <div class="info-item__content">
                                <label class="info-item__label">Social Media</label>
                                <a 
                                    :href="getUser.user_info.facebook_links" 
                                    target="_blank" 
                                    class="social-link"
                                >
                                    <i class="bi bi-box-arrow-up-right"></i>
                                    Visit Facebook Profile
                                </a>
                            </div>
                        </div>

                        <!-- Empty State -->
                        <div class="info-item info-item--empty" v-if="getUser?.user_info === null">
                            <div class="info-item__icon">
                                <i class="bi bi-exclamation-circle"></i>
                            </div>
                            <div class="info-item__content">
                                <div class="info-item__value info-item__value--muted">
                                    No additional information provided by user
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Actions Section -->
                <div class="user-profile__actions">
                    <div class="actions-container">
                        <button 
                            class="action-btn action-btn--message"
                            @click="message"
                            :title="isSelf ? 'View your chats' : `Message ${getUser.name}`"
                            v-if="!isSelf"
                        >
                            <i class="bi bi-chat-dots-fill"></i>
                            <span>{{  'Message' }}</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Custom Modal -->
        <CustomModal 
            v-if="showModal"
            :name="modalQuestion" 
            :id="getUser.id" 
            @response="handleModalResponse"
        />
    </AuthenticatedLayout>
</template>

<style scoped>
.user-profile {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem 1rem;
    height: 100vh;
    overflow-y: scroll;
}
.user-profile::-webkit-scrollbar{
    display: none;
}
/* Header Styles */
.user-profile__header {
    text-align: center;
    margin-bottom: 3rem;
    padding-bottom: 2rem;
    border-bottom: 1px solid #e2e8f0;
}

.user-profile__avatar-container {
    position: relative;
    display: inline-block;
    margin-bottom: 1.5rem;
}

.user-profile__avatar {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    border: 4px solid #ffffff;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.user-profile__avatar:hover {
    transform: scale(1.05);
}

.user-profile__status-indicator {
    position: absolute;
    bottom: 12px;
    right: 12px;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: #10b981;
    border: 3px solid #ffffff;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.user-profile__status-indicator--self {
    background: #3b82f6;
}

.user-profile__title {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 1rem;
    flex-wrap: wrap;
    margin-bottom: 1rem;
}

.user-profile__name {
    font-size: 2.25rem;
    font-weight: 700;
    color: #1f2937;
    margin: 0;
    line-height: 1.2;
}

.user-profile__badges {
    display: flex;
    justify-content: center;
    gap: 0.75rem;
    flex-wrap: wrap;
}

.user-profile__badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.875rem;
    font-weight: 500;
    background: #10b981;
    color: white;
}

.user-profile__badge--primary {
    background: #eff6ff;
    color: #2563eb;
    border: 1px solid #dbeafe;
}

/* Content Styles */
.user-profile__content {
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

.user-profile__info-card {
    background: #ffffff;
    border-radius: 16px;
    padding: 2rem;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    border: 1px solid #f1f5f9;
}

.user-profile__info-title {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
    margin: 0 0 1.5rem 0;
}

.user-profile__info-title i {
    color: #6366f1;
}

.user-profile__info-grid {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

/* Info Item Styles */
.info-item {
    display: flex;
    align-items: flex-start;
    gap: 1rem;
    padding: 1rem;
    border-radius: 12px;
    transition: background-color 0.2s ease;
}

.info-item:hover {
    background: #f8fafc;
}

.info-item__icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    border-radius: 10px;
    background: #eff6ff;
    color: #3b82f6;
    flex-shrink: 0;
}

.info-item__content {
    flex: 1;
    min-width: 0;
}

.info-item__label {
    display: block;
    font-size: 0.875rem;
    font-weight: 500;
    color: #6b7280;
    margin-bottom: 0.25rem;
}

.info-item__value {
    font-size: 1rem;
    font-weight: 500;
    color: #1f2937;
    word-break: break-word;
}

.info-item__value--muted {
    color: #9ca3af;
    font-style: italic;
}

.info-item__value--hidden {
    position: relative;
    color: transparent;
    background: linear-gradient(45deg, #e5e7eb 25%, #d1d5db 25%, #d1d5db 50%, #e5e7eb 50%, #e5e7eb 75%, #d1d5db 75%);
    background-size: 8px 8px;
    border-radius: 4px;
    padding: 0.25rem 0.5rem;
    user-select: none;
}

.info-item__value--hidden::before {
    content: "Hidden by user privacy settings";
    position: absolute;
    left: 0.5rem;
    top: 50%;
    transform: translateY(-50%);
    color: #6b7280;
    font-size: 0.875rem;
    font-style: italic;
}

.info-item--empty {
    background: #fef3f2;
    border: 1px solid #fecaca;
}

.info-item--empty .info-item__icon {
    background: #fef2f2;
    color: #dc2626;
}

/* Social Link Styles */
.social-link {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1rem;
    background: #1877f2;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 500;
    transition: all 0.2s ease;
    border: 1px solid #1877f2;
}

.social-link:hover {
    background: #1664d9;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(24, 119, 242, 0.3);
    color: white;
}

/* Actions Styles */
.user-profile__actions {
    display: flex;
    justify-content: center;
}

.actions-container {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.action-btn {
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.875rem 1.5rem;
    border: none;
    border-radius: 12px;
    font-weight: 600;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 0.95rem;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.action-btn--message {
    background: #10b981;
    color: white;
}

.action-btn--message:hover {
    background: #059669;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(16, 185, 129, 0.3);
}

.action-btn--facebook {
    background: #1877f2;
    color: white;
}

.action-btn--facebook:hover {
    background: #1664d9;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(24, 119, 242, 0.3);
}

/* Responsive Design */
@media (max-width: 768px) {
    .user-profile {
        padding: 1rem 0.5rem;
    }
    
    .user-profile__header {
        margin-bottom: 2rem;
        padding-bottom: 1.5rem;
    }
    
    .user-profile__avatar {
        width: 120px;
        height: 120px;
    }
    
    .user-profile__name {
        font-size: 1.75rem;
    }
    
    .user-profile__info-card {
        padding: 1.5rem;
    }
    
    .actions-container {
        flex-direction: column;
        width: 100%;
    }
    
    .action-btn {
        justify-content: center;
        width: 100%;
    }
    
    .info-item {
        flex-direction: column;
        text-align: center;
        gap: 0.75rem;
    }
    
    .info-item__icon {
        align-self: center;
    }
    
    .user-profile__title {
        flex-direction: column;
        gap: 0.5rem;
    }
}

@media (max-width: 480px) {
    .user-profile__avatar {
        width: 100px;
        height: 100px;
    }
    
    .user-profile__name {
        font-size: 1.5rem;
    }
    
    .user-profile__info-card {
        padding: 1rem;
    }
}
</style>