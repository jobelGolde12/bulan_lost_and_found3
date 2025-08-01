<script setup>
import { Link } from '@inertiajs/vue3';
import { defineProps, ref, watch } from 'vue';
const props = defineProps({
    modifyWidth: {
        type: Boolean,
        default: true,
    }
})
const getModifyWith = ref(true);
watch(
    () => props.modifyWidth,
    (newBool) => {
        getModifyWith.value = newBool;
    },
    {immediate: true}
)
</script>
<template>
    <div>
            <div class="container button-container">
                <Link :href="route('logout')" class="btn btn-dark text-decoration-none w-100" method="post">
                    <span v-if="!getModifyWith">
                        <i class="bi bi-caret-left"></i>
                    </span>
                    <span v-else>Logout</span>
                </Link>
            </div>
    </div>
</template>


<style scoped>
.button-container{
    position: relative;
    bottom: -10rem;
}
</style>