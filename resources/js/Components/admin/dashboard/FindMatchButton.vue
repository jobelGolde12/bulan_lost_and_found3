<script setup>
import { Link } from '@inertiajs/vue3';
</script>

<template>
    <div class="container-fluid d-flex flex-row justify-content-center align-items-center">
        <Link title="Find match items" :href="route('findMatch.index')" class="btn btn-success rounded-pill d-block">
            <i class="bi bi-magic me-1"></i>
            <span class="d-none d-lg-inline">Find match</span>
        </Link>
    </div>
</template>
<style scoped>
.btn{
    transform: translateX(-50%);
}
@media screen and (max-width: 768px){
    .btn{
    transform: translateX(100%);
}
}
</style>