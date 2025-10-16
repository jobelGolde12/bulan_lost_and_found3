<script setup>
import { defineProps, ref, watch } from 'vue';
import { router } from '@inertiajs/vue3';
import { useSidebarStore } from '@/piniaStore/useSidebarStore';

const props = defineProps({
  pinned: { type: Array, default: () => [] },
  users: { type: Array, default: () => [] },
  active: { type: Number, default: 0 },
  hasMessages: { type: Array, default: () => [] },
});
console.log("users prop:", props.users);
const pinnedChats = ref([]);
const remainingUsers = ref([]);
const getActiveMessage = ref(0);
const sidebarStore = useSidebarStore();

/** Helper - build message map keyed by sender_id */
function buildMessageMap(messages = []) {
  const map = new Map();

  (Array.isArray(messages) ? messages : []).forEach(m => {
    const id = Number(m?.sender_id);
    if (!id) return;
    const existing = map.get(id);
    const isUnread = !m.read_at;
    if (!existing) {
      map.set(id, { latestMessage: m, unread: isUnread });
    } else {
      if (isUnread) existing.unread = true;
      const newTime = new Date(m.created_at || 0).getTime();
      const oldTime = new Date(existing.latestMessage?.created_at || 0).getTime();
      if (newTime >= oldTime) existing.latestMessage = m;
    }
  });

  return map;
}

watch(
  () => [props.pinned, props.users, props.hasMessages],
  ([pinned, users, hasMessages]) => {
    const messageMap = buildMessageMap(hasMessages);
    const unread = [];
    const withMessages = [];
    const withoutMessages = [];
    const bottomUsers = [];

    const added = new Set();

    // --- 1. Pinned users
    for (const chat of pinned) {
      const info = messageMap.get(Number(chat.id));
      if (info?.unread) {
        unread.push({
          ...chat,
          snippet: info.latestMessage?.message || '',
          time: info.latestMessage?.created_at || '',
          _unread: true,
        });
      } else if (info) {
        withMessages.push({
          ...chat,
          snippet: info.latestMessage?.message || '',
          time: info.latestMessage?.created_at || '',
          _unread: false,
        });
      } else {
        withoutMessages.push({
          ...chat,
          snippet: '',
          time: '',
          _unread: false,
        });
      }
      added.add(Number(chat.id));
    }

    // --- 2. Remaining users (not pinned or already in hasMessages)
    for (const user of users) {
      const id = Number(user.id);
      if (!id || added.has(id)) continue;
      const info = messageMap.get(id);
      if (info) continue; // skip users already with messages
      bottomUsers.push({
        id,
        name: user.name, // ✅ only include name, not entire object
      });
      added.add(id);
    }

    // --- Final combined order
    pinnedChats.value = [...unread, ...withMessages, ...withoutMessages];
    remainingUsers.value = bottomUsers;
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

      <!-- 🔹 Chats (pinned/unread/withMessages/withoutMessages) -->
      <div
        v-for="chat in pinnedChats"
        :key="'chat-' + chat.id"
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
            <strong v-if="sidebarStore.isSidebarOpen" :class="{ 'fw-bolder': chat._unread }">
              {{ chat.name }}
              <small v-if="chat._unread" class="unread bg-success"></small>
            </strong>
            <span class="text-muted small mt-2" v-if="chat._unread">{{ formatTime(chat.time) }}</span>
          </div>
          <small :class="chat._unread ? 'text-dark fw-semibold' : 'text-muted'">
            {{ chat.snippet }}
          </small>
        </div>
      </div>

      <!-- 🔹 Remaining users (bottom of list, no duplicates, only name) -->
      <div
        v-for="user in remainingUsers"
        :key="'user-' + user.id"
        class="chat-link d-flex align-items-center mb-2 p-2 rounded text-decoration-none"
      >
        <img
          src="/images/profile.jpeg"
          alt="Profile Picture"
          class="rounded-circle me-2 profile-pic"
        />
        <div class="flex-grow-1">
          <strong v-if="sidebarStore.isSidebarOpen">{{ user?.name?.name || 'user' }}</strong>
        </div>
      </div>

      <div class="extra-space-at-bottom"></div>
    </div>
  </div>
</template>

<script>
function formatTime(val) {
  if (!val) return '';
  try {
    const d = new Date(val);
    if (isNaN(d)) return val;
    const now = new Date();
    if (d.toDateString() === now.toDateString()) {
      return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    }
    return d.toLocaleDateString();
  } catch {
    return val;
  }
}
</script>

<style scoped>
.list {
  max-height: 70vh;
  overflow-y: auto;
  position: relative;
  padding-right: 6px;
}
.chat-link {
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
.unread {
  width: 12px !important;
  height: 12px;
  border-radius: 50%;
  display: inline-block;
  transform: translate(-2px, -8px);
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
