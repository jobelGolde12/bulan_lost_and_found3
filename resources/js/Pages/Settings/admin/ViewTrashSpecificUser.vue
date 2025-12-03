<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import { defineProps, ref, watch } from 'vue';
import CustomModal from '@/Components/CustomModal.vue';

const props = defineProps({
    user: {
        type: Object,
        default: () => ({})
    },
    info: {
        type: Object,
        default: () => ({})
    },
});

let getUser = ref({});
let getInfo = ref({});
watch(
    () => props.user,
    (newItem) => {
        getUser.value = newItem;
    },
    { immediate: true }
);

watch(
    () => props.info,
    (newItem) => {
        getInfo.value = newItem;
    },
    { immediate: true }
);

</script>

<template>
    <Head title="view user" />
    <AdminLayout>
        <div class="user-container d-flex container-fluid flex-row justify-content-center align-items-center">
            <div class="container px-5 pt-3" v-if="getUser">
                <img v-if="getInfo !== null && getInfo.profile_pic" :src="getUser.user_info?.profile_pic" alt="Profile pic" class="profile">
                <img v-if="!getInfo.profile_pic" src="../../../../images/profile.jpeg" alt="Profile pic" class="profile">
                <div class="name text-start text-dark fs-3 fw-bold">
                    {{ getUser?.name ?? 'user' }}
                </div>
                <div class="name text-start text-dark fw-light">
                    <span class="fw-semibold">Email:</span> {{ getUser?.email ?? 'N/A' }}
                </div>

                <div v-if="getUser?.user_info !== null" class="name text-start text-dark fw-light">
                    <span class="fw-semibold">Phone number:</span> {{ getUser?.user_info?.contact ?? 'N/A' }}
                </div>

                <div v-if="getUser?.user_info !== null" class="name text-start text-dark fw-light">
                    <span class="fw-semibold">Facebook:</span> {{ getUser?.user_info?.facebook_links ?? 'N/A' }}
                </div>

                <div v-if="getUser?.user_info === null" class="text-danger">
                    No other information provided
                </div>
                <br>
             <Link :href="route('userTrashed.index')" class="btn btn-success">Back</Link>   
            </div>

            <div class="container text-center text-muted mt-5" v-else>
                <p>Can't find user info's</p>
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
</style>