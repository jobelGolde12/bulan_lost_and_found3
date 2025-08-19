<script setup>
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import OffcanvasForUserProfile from "@/Components/user/OffcanvasForUserProfile.vue";
import { Head, usePage, Link } from "@inertiajs/vue3";
import { defineProps, onMounted, ref } from "vue";

const user = usePage().props.auth.user;

const props = defineProps({
  items: {
    type: Array,
    default: () => [],
  },
  userInfo: {
    type: Object,
    default: () => ({}),
  },
  permission: {
    type: Object,
    default: () => ({}),
  },
});

let itemsContainer = ref([]);
const getUserInfo = ref({});

onMounted(() => {
  itemsContainer.value = props.items;
  getUserInfo.value = props.userInfo;
});
</script>

<template>
  <Head title="My profile" />
  <AuthenticatedLayout>
    <OffcanvasForUserProfile :permission="props.permission" />

    <div class="main-container1 pb-5">
      <div
        class="container-fluid d-flex flex-column justify-content-center align-items-center pt-5 gap-2"
      >
        <div class="profile-pic shadow-sm">
          <img
            v-if="getUserInfo?.profile_pic"
            :src="`/storage/${getUserInfo.profile_pic}` || '../../../../images/profile.jpeg'"
            alt="Profile pic"
          />
        </div>

        <div>
          <div class="d-flex flex-column gap-0">
            <div class="name fs-2 text-center">{{ user.name }}</div>
            <div
              class="text-success text-sm text-center"
              style="transform: translateY(-50%)"
            >
              user
            </div>
          </div>
          <div class="bio text-muted text-start">
            {{ getUserInfo?.bio || '' }}
          </div>
        </div>
      </div>

      <div class="container">
        <div class="name text-start text-dark fw-light">
          <span class="fw-semibold me-2"><i class="bi bi-envelope"></i></span>
          {{ user.email ?? 'N/A' }}
        </div>

        <div class="name text-start text-dark fw-light">
          <span class="fw-semibold me-2"><i class="bi bi-telephone"></i></span>
          {{ getUserInfo?.contact ?? 'No phone provided.' }}
        </div>
      </div>

      <div class="container" v-if="itemsContainer.length">
        <h3 class="text-muted fw-light mt-5">My Items</h3>
        <table class="table table-responsive">
          <thead>
            <tr>
              <th>Name</th>
              <th>Description</th>
              <th>Status</th>
              <th class="text-end pe-2">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in itemsContainer" :key="item.id">
              <td class="bg-light">{{ item.title }}</td>
              <td class="bg-light">{{ item.description }}</td>
              <td class="bg-light">{{ item.status }}</td>
              <td class="text-end bg-light">
                <Link
                  :href="route('viewItem', { id: item.id })"
                  class="btn btn-primary ms-0"
                >
                  View
                </Link>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div v-else>
        <h1 class="text-dark fw-lighter text-center">No item posted</h1>
      </div>
    </div>
  </AuthenticatedLayout>
</template>

<style lang="css" scoped>
.main-container1 {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 0 2rem;
  margin-bottom: 5rem;
}
.profile-pic {
  position: relative;
  width: 180px;
  height: 180px;
  border-radius: 50%;
  left: 0%;
  overflow: hidden;
}
.profile-pic img {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: inherit;
  transition: 0.5s;
}
.profile-pic img:hover {
  transform: scale(1.1);
  filter: brightness(0.8);
}
</style>
