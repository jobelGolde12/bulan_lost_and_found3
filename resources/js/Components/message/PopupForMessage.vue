<script setup>
import { defineProps, ref, watch, defineExpose } from 'vue';
import { router } from '@inertiajs/vue3';

const props = defineProps({
    show: Boolean,
    id: Number,
});

const isShow = ref(false);
const root = ref(null);
const getId = ref(0);

watch(() => props.show, (val) => {
    isShow.value = val;
}, { immediate: true });
watch(
    () => props.id,
    (data) => {
        getId.value = data;
    }, {immediate: true}
)
defineExpose({ root });

const remove = () => {
  isShow.value = false;
    router.post(route('message.remove', {id: getId.value}), {}, {
        onError: () => alert('Something went wrong, please try again.'),
        onSuccess: () => {
            router.visit(route('message.index')) 
        }
    })
}
const block = () => {
  isShow.value = false;
    router.post(route('message.block', {id: getId.value}), {}, {
        onError: () => alert('Something went wrong, please try again.'),
         onSuccess: () => {
            router.visit(route('message.index')) 
        }
    })
}
const moreUsers = () => {
  router.visit(route('viewMoreUsers.index'));
}
</script>

<template>
  <div ref="root">
    <div v-if="isShow" class="action-container">
      <div class="list">
        <button type="button" class="d-flex align-items-center gap-2 w-100"  @click="block"><i class="bi bi-ban"></i> Block</button>
        <button type="button" class="d-flex align-items-center gap-2 w-100 mt-2" @click="remove"><i class="bi bi-person-x"></i> Remove</button>
        <hr>
        <button type="button" class="d-flex align-items-center gap-2 w-100 mt-2" @click="moreUsers"><i class="bi bi-people"></i> More users</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.action-container {
  position: absolute;
  background: #f5f5f5;
  padding: 0.5rem;
  border-radius: 10px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  width: 15%;
  right: 3%;
  top: 5%;
}
.action-container .list button:hover {
  background: #f0ecec;
}
@media screen and (max-width: 756px){
  .action-container {
    right: 10%;
    top: 5%;
    width: 30%;
  } 
}
</style>
