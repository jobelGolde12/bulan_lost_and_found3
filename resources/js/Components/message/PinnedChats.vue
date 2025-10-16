<script setup>
import { defineProps, ref, watch } from 'vue';
import { router } from '@inertiajs/vue3';
import { useSidebarStore } from '@/piniaStore/useSidebarStore';
const props = defineProps({
    pinned: {
        type: Array,
        default: () => []
    },
    active: {
        type: Number,
        default: 0
    }
});

const pinnedChats = ref([]);
const getActiveMessage = ref(0);
const sidebarStore = useSidebarStore()
watch(
    () => props.pinned,
    (data) => {
        pinnedChats.value = data;
        console.log(pinnedChats.value);
    },
    { immediate: true }
);

watch(
    () => props.active,
    (data) => {
        getActiveMessage.value = data;
    },
    { immediate: true }
);

const viewMessageFunc = (id) => {
    router.get(route("message.viewChat", { id }));
};


</script>

<template>
  <div>
    <div class="list mt-2">
      <div
        v-for="chat in pinnedChats"
        :key="chat.id"
        @click="viewMessageFunc(chat.id)"
        class="chat-link d-flex align-items-center mb-2 p-2 rounded text-decoration-none"
        :class="{ active: getActiveMessage === chat.id }"
      >
        <img
          :src="`/storage/${chat.profile_pic}` || '../../../images/profile.jpeg'"
          alt="Profile Picture"
          class="rounded-circle me-2 profile-pic"
        />
        <div class="flex-grow-1">
          <div class="d-flex justify-content-between align-items-center">
            <strong v-if="sidebarStore.isSidebarOpen">{{ chat.name }}</strong>
            <span class="text-muted small mt-2">{{ chat.time }}</span>
          </div>
          <small :class="chat.typing ? 'text-success' : 'text-muted'">
            {{ chat.snippet }}
          </small>
        </div>
      </div>

      <div class="extra-space-at-bottom"></div>
    </div>
  </div>
</template>

<style scoped>
.list {
  overflow-y: scroll;
  height: auto;
  position: relative;
}

.chat-link {
  z-index: 1;
  background-color: transparent;
  color: #333;
  transition: background-color 0.2s;
  cursor: pointer;
}
.chat-link.active {
  background-color: #d1e7dd;
  font-weight: bold;
}
.chat-link:not(.active):hover {
  background-color: #edf5f1;
}
.profile-pic{
    width: 40px;
    height: 40px;
}
.extra-space-at-bottom{
  width: 100%;
  height: 20%;
  position: relative;
}
@media screen and (max-width: 756px){
  .list::-webkit-scrollbar{
    overflow: none;
  }
  .list {
  scrollbar-width: none; 
  -ms-overflow-style: none; 
  }

}
</style>
