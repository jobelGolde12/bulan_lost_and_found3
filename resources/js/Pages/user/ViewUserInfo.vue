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

watch(
    () => props.user,
    (newItem) => {
        getUser.value = newItem;
        console.log("user => ", getUser.value)
    },
    { immediate: true }
);

</script>

<template>
    <Head title="view user" />
    <AuthenticatedLayout>
        <div class="user-container d-flex container-fluid flex-row justify-content-center align-items-center">
            <div class="container px-5 pt-3">
                <img :src="`/storage/${getUser.user_info?.profile_pic}` || '../../../images/profile.jpeg'" 
                alt="Profile pic" class="profile rounded">
                <div class="name text-start text-dark fs-3 fw-bold">
                    {{ getUser.name ?? 'user' }} 
                    <span class="bg-secondary text-light rounded px-2 ms-1 you-text" v-if="props.isSelf">You</span>
                </div>

                <div class="name text-start text-dark fw-light">
                    <span class="fw-semibold">Email: </span>
                     <span :class="{'hide' : getUser.permission?.isEmailAllow == false}">{{ getUser.email ?? 'N/A' }}</span>
                </div>

                <div v-if="getUser?.user_info !== null" class="name text-start text-dark fw-light">
                    <span class="fw-semibold">Phone number: </span> 
                     <span :class="{'hide' : getUser.permission?.isPhoneAllow == false}">{{ getUser.user_info?.contact ?? 'N/A' }}</span>
                </div>

                <div v-if="getUser?.user_info === null" class="text-danger">
                    No other information provided
                </div>
                <br>

                <div class="d-flex gap-2">
                    <button class="btn btn-success">Message</button>
                    <a 
                    :href="getUser.user_info?.facebook_links" 
                    class="btn btn-primary" 
                    v-if="getUser.user_info?.facebook_links"
                    >
                        <i class="bi bi-facebook me-2"></i>
                        Visit on Facebook
                    </a>
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
.profile{
    margin: auto;
    width: 250px;
    height: 270px;

}
.you-text{
    position: absolute;
    font-size: 1rem;
    font-weight: 400;
    transform: translateY(-30%);
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