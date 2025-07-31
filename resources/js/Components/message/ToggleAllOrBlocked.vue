<script setup>
import { defineProps, ref, watch } from 'vue';
import { router } from '@inertiajs/vue3';
const props = defineProps({
    status: String
})
const getStatus = ref('all');
watch(
    () => props.status,
    (data) => {
        getStatus.value = data;
        console.log("status: ", getStatus.value)
    },
    { immediate: true }
);

const viewAll = () => {
    router.visit(route('viewMoreUsers.index'));
}
const viewAllBlocked = () => {
    router.visit(route('viewMoreUsers.blocked'));
}
</script>

<template>
     <div>
               <div class="container ps-0 sub-header d-flex flex-row align-items-center gap-1 mb-2">
                <div>
                    <button class="button-all" :class="{'active' : getStatus == 'all'}" @click="viewAll">All</button>
                </div>
                <div>
                    <button class="button-blocked" :class="{'active' : getStatus == 'blocked'}" @click="viewAllBlocked">Blocked</button>
                </div>
            </div>
    </div>
</template>

<style scoped>
button{
    padding: .2rem .5rem;
    border-radius: 5px;
}
 .active{
    background: #ece4e4;
}
</style>