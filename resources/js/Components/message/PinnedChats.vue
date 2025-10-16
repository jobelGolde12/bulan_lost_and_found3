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
  },
  hasMessages: {
    type: Array,
    default: () => []
  },
});

const pinnedChats = ref([]);
const getActiveMessage = ref(0);
const sidebarStore = useSidebarStore();

watch(
  () => [props.pinned, props.hasMessages],
  ([pinned, hasMessages]) => {
    if (!Array.isArray(pinned)) {
      pinnedChats.value = [];
      return;
    }
    console.log("has messages:", hasMessages);  
    // Extract all sender IDs from hasMessages
    const senderIds = (Array.isArray(hasMessages) ? hasMessages : [])
      .map(m => m?.sender_id)
      .filter(id => id !== undefined && id !== null);

    // 1️⃣ Members who have messages
    const withMessages = pinned.filter(chat => senderIds.includes(chat.id));

    // 2️⃣ Members who don’t have messages (exclude duplicates)
    const withoutMessages = pinned.filter(chat => !senderIds.includes(chat.id));

    // 3️⃣ Combine without duplicates
    const combined = [...withMessages, ...withoutMessages].filter(
      (chat, index, self) => index === self.findIndex(c => c.id === chat.id)
    );

    pinnedChats.value = combined;
  },
  { immediate: true, deep: true }
);

watch(
  () => props.active,
  (data) => {
    getActiveMessage.value = data;
  },
  { immediate: true }
);

const viewMessageFunc = (id) => {
  router.get(route('message.viewChat', { id }));
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
          :src="chat?.profile_pic ? `/storage/${chat.profile_pic}` : '/images/profile.jpeg'"
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
  max-height: 60vh;
  overflow-y: auto;
  position: relative;
  padding-right: 6px;
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
.profile-pic {
  width: 40px;
  height: 40px;
  object-fit: cover;
}
.extra-space-at-bottom {
  width: 100%;
  height: 1rem;
}
@media screen and (max-width: 756px) {
  .list::-webkit-scrollbar {
    display: none;
  }
  .list {
    scrollbar-width: none;
    -ms-overflow-style: none;
  }
}
</style>
