<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import { defineProps, ref, watch } from 'vue';

const props = defineProps({
    user: {
        type: Object,
        default: () => ({})
    },
});
let getUser = ref();
const showModal = ref(false);
const modalQuestion = ref('Are you sure you want to delete the user?');

watch(
    () => props.user,
    (newItem) => {
        getUser.value = newItem;
    },
    { immediate: true }
);

const deleteFunc = (value) => {
    if (confirm('Are you sure you want to delete this user?')) {
        router.delete(route('userTrashed.delete', {id: props.user?.id}), 
    {}, 
    {
        onSuccess: () => {alert('User deleted.')},
        onError: () => alert("Please try again.")
    }
); 
    }
};
</script>

<template>
    <Head title="view user" />
    <AdminLayout>
        <div class="user-container d-flex container-fluid flex-row justify-content-center align-items-center">
            <div class="container px-5 pt-3">
                <img :src="getUser?.user_info?.profile_pic ? `/storage/${getUser.user_info.profile_pic}` : '/images/profile.jpeg'" alt="Profile Picture" class="profile rounded">

                <div class="name text-start text-dark fs-3 fw-bold">
                    {{ getUser.name ?? 'user' }}
                </div>

                <div class="name text-start text-dark fw-light">
                    <span class="fw-semibold me-2"><i class="bi bi-envelope"></i></span>
                     <span :class="{'hide' : getUser.permission?.isEmailAllow == false}">{{ getUser.email ?? 'N/A' }}</span>
                </div>

                <div v-if="getUser?.user_info !== null" class="name text-start text-dark fw-light">
                    <span class="fw-semibold me-2"><i class="bi bi-telephone"></i></span>
                     <span :class="{'hide' : getUser.permission?.isPhoneAllow == false}">{{ getUser.user_info?.contact ?? 'N/A' }}</span>
                </div>

                <div v-if="getUser?.user_info?.facebook_links !== null" class="name text-start text-dark fw-light mt-1">
                    <a :href="getUser?.user_info?.facebook_links" target="_blank" class="facebook-link">
                        <i class="bi bi-facebook"></i> Visit Facebook Page
                    </a>
                </div>

                <div v-if="getUser?.user_info === null" class="text-danger">
                    No other information provided
                </div>
                <br>

                <hr style="width: 20%;">
                <div class="d-flex gap-2">
                    <Link :href="route('message.viewChat', {id: getUser?.id})" class="btn btn-success" title="Message">
                    <i class="bi bi-chat-dots"></i>
                    </Link>
                    <button class="btn btn-warning" @click="deleteFunc" title="delete user">
                        <i class="bi bi-trash"></i>
                    </button>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>

<style scoped>
.profile{
    margin: auto;
    width: 250px;
    height: 270px;

}
.facebook-link {
      display: inline-flex;
      align-items: center;
      text-decoration: none;
      background-color: #1877F2;
      color: white;
      padding: 8px 12px;
      border-radius: 6px;
      font-size: 16px;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }

    .facebook-link:hover {
      background-color: #145DBF;
    }

    .facebook-link i {
      margin-right: 8px;
      font-size: 20px;
    }
    .hide {
    position: relative;
    color: transparent;
    text-shadow: 0 0 5px rgba(0,0,0,0.5);
    user-select: none;
    pointer-events: none;
}

.hide::after {
    content: attr(data-mask) " ";
    position: absolute;
    top: 50%;
    left: 0;
    width: 100%;
    border-top: 1px solid #555;
    transform: translateY(-50%);
}

.hide::before {
    content: '';
    position: absolute;
    inset: 0;
    background: repeating-linear-gradient(
        45deg,
        rgba(0, 0, 0, 0.15),
        rgba(0, 0, 0, 0.15) 2px,
        transparent 2px,
        transparent 4px
    );
    pointer-events: none;
}
</style>