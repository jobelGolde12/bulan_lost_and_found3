
<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
  <div>
     <Link :href="route('login')" class="btn btn-light login-btn px-2 py-3"
        >
        <img src="../../../images/guest/undraw_secure-login_m11a.svg" alt="Login Icon">
        <span class="mt-2 d-block">Acess all features</span>
        <span class="fs-5 fw-bold">Login Now!</span>
        </Link
      >
  </div>
</template>


<style scoped>
.login-btn{
  position: absolute;
  bottom: 5%;
  width: 80%;
}

</style>