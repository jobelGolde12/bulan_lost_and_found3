<script setup>
import { router } from '@inertiajs/vue3';
import {Link} from '@inertiajs/vue3';
</script>

<template>
    <div>
        <Link
            :href="route('dashboard')"
            class="back ms-0 fs-5 text-decoration-none text-light bg-success p-3"
        >
            <i class="bi bi-caret-left-fill me-2"></i>Back
        </Link>
    </div>
</template>

<style scoped>
.back {
    position: absolute;
    bottom: 0;
    cursor: pointer;
    width: 90%;
    border-radius: 10px 10px 0 0;
}
.back:hover{
  font-weight: bolder;
}
@keyframes jello {
  0% {
    transform: none;
  }
  11.1% {
    transform: none;
  }
  22.2% {
    transform: skewX(-12.5deg) skewY(-12.5deg);
  }
  33.3% {
    transform: skewX(6.25deg) skewY(6.25deg);
  }
  44.4% {
    transform: skewX(-3.125deg) skewY(-3.125deg);
  }
  55.5% {
    transform: skewX(1.5625deg) skewY(1.5625deg);
  }
  66.6% {
    transform: skewX(-0.78125deg) skewY(-0.78125deg);
  }
  77.7% {
    transform: skewX(0.390625deg) skewY(0.390625deg);
  }
  88.8% {
    transform: skewX(-0.1953125deg) skewY(-0.1953125deg);
  }
  100% {
    transform: none;
  }
}

</style>
