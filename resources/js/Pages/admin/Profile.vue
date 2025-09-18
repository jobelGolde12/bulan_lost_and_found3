
<script setup>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import OffcanvasForProfile from "@/Components/admin/OffcanvasForProfile.vue";
import { Head, usePage, Link } from "@inertiajs/vue3";
import { computed, defineProps, onMounted, ref, watch } from "vue";
const user = usePage().props.auth.user;
const props = defineProps({
  userInfo: {
    type: Object,
    default: () => ({})
  },
  permission: {
    type: Object,
    default: () => ({}),
  },
});
let getUserInfo = ref([])
watch(
  () => props.userInfo,
  (newItem) => {
    getUserInfo.value = newItem;
  },
  {immediate: true}
)

</script>
<template>
  <Head title="My profile" />
  <AdminLayout>
    <OffcanvasForProfile :permission="props.permission"/>
    <div class="main-container1">
      <div
        class="container-fluid d-flex flex-column justify-content-center align-items-center pt-5 gap-2"
      >
        <div class="profile-pic shadow-sm">
          <img
          :src="getUserInfo?.profile_pic ? `/storage/${getUserInfo.profile_pic}` : `../../../images/profile.jpeg`"
          alt="Profile pic"
        />
        </div>

        <div>
          <div class="name fs-2 text-center mb-0">{{ user.name }}</div>
          <div class="bio text-muted text-center">
            {{ getUserInfo.bio || '' }}
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

    

          <!-- Extra space at the bottom  -->
          <div class="container space mt-5"></div>

    </div>
  </AdminLayout>
</template>

<style lang="css" scoped>
.main-container1 {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow-x: hidden;
  overflow-y: scroll;
  padding: 0 2rem;
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
.space{
  min-height: 150px;
}
</style>