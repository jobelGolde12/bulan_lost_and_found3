<script setup>
import MessageLayout from '@/Layouts/MessageLayout.vue';
import PopupForMessage from '@/Components/message/PopupForMessage.vue';
import { defineProps, onMounted, ref, watch, nextTick, onBeforeUnmount } from 'vue';
import Echo from 'laravel-echo';
import Pusher from 'pusher-js';
import axios from 'axios';

// Setup CSRF Token
const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

// Initialize Pusher and Echo
window.Pusher = Pusher;

window.Echo = new Echo({
  broadcaster: 'pusher',
  key: import.meta.env.VITE_PUSHER_APP_KEY,
  cluster: import.meta.env.VITE_PUSHER_APP_CLUSTER,
  forceTLS: true,
  authEndpoint: '/broadcasting/auth',
  auth: {
    headers: {
      'X-CSRF-TOKEN': csrfToken,
      'X-Requested-With': 'XMLHttpRequest',
    },
  },
});

// Props
const props = defineProps({
  users: {
    type: Object,
    default: () => ({}),
  },
  pinned: {
    type: Array,
    default: () => [],
  },
  message: {
    type: Object,
    default: () => ({}),
  },
  currentUserId: {
    type: Number,
    required: true,
  },
  hasMessages: {
    type: Array,
    default: () => [],
  },
});

// Reactive state
let showPopup = ref(false); 
let popupRef = ref(null);
let getUsers = ref([]);
let getPinnedvalue = ref([]);
let getMessage = ref([]);
let messages = ref([]);
let newMessage = ref('');
let chatBox = ref(null);
let getCurrentUserId = ref(0);
let echoChannel = null;
let getHasMessages = ref([]);

// Watchers
watch(
  () => props.users,
  (newItem) => {
    getUsers.value = newItem;
  },
  { immediate: true }
);

watch(
  () => props.pinned,
  (newItem) => {
    getPinnedvalue.value = newItem;
  },
  { immediate: true }
);

watch(
  () => props.message,
  (newItem) => {
    getMessage.value = newItem;
  },
  { immediate: true }
);

watch(
  () => props.currentUserId,
  (newId) => {
    getCurrentUserId.value = newId;
  },
  { immediate: true }
);
watch(
  () => props.hasMessages,
  (newItem) => {
    getHasMessages.value = newItem;
  },
  { immediate: true }
);
onMounted(() => {
  getPinnedvalue.value = Array.isArray(props.pinned)
    ? props.pinned
    : Object.values(props.pinned);

  if (Array.isArray(props.message.data2)) {
    messages.value = [...props.message.data2];
  }

  nextTick(() => {
    scrollToBottom();
  });

  setupChannel(props.currentUserId);
});

// Function to handle subscriptions
const setupChannel = (receiverId) => {
  if (!receiverId) return;

  if (echoChannel) {
    echoChannel.stopListening('NewMessageSent');
    window.Echo.leave(`private-chat.${receiverId}`);
  }

  echoChannel = window.Echo.private(`chat.${receiverId}`)
    .listen('NewMessageSent', (e) => {
      messages.value.push({
        sender_id: e.sender_id,
        receiver_id: e.receiver_id,
        message: e.message,
        created_at: e.created_at,
        id: e.id,
      });
      scrollToBottom();
    });
};


// Send message
const sendMessage = async () => {
  if (newMessage.value.trim() === '') return;

  const localMessage = {
    sender_id: getCurrentUserId.value,
    receiver_id: props.message.data1.id,
    message: newMessage.value,
    created_at: new Date().toISOString(),
    id: `temp_${Date.now()}`, // Temporary ID
  };

  messages.value.push(localMessage);
  scrollToBottom();

  try {
    const response = await axios.post('/messages/send', {
      receiver_id: props.message.data1.id,
      content: newMessage.value,
    });

    const index = messages.value.findIndex(msg => msg.id === localMessage.id);
    if (index !== -1) {
      messages.value[index] = { ...response.data };
    }
  } catch (error) {
    messages.value = messages.value.filter(msg => msg.id !== localMessage.id);
  }

  newMessage.value = '';
};

// Scroll to the bottom of the chat
const scrollToBottom = () => {
  nextTick(() => {
    if (chatBox.value) {
      chatBox.value.scrollTop = chatBox.value.scrollHeight;
    }
  });
};

// Show popup, yung para sa delete tas block
const togglePopup = () => {
  showPopup.value = !showPopup.value; 
};
// Kapag nag click sa iba ma close ang popup 
function handleClickOutside(event) {
   if (popupRef.value && !popupRef.value.$el.contains(event.target)) {
    showPopup.value = false;
  }
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});
onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside);
});
const closePopup = () => {
  showPopup.value = false;
}

</script>

<template>
<MessageLayout 
:users="getUsers" 
:getPinned="getPinnedvalue" 
:activeMessage="getMessage?.data1?.id" 
:currentUserId="getCurrentUserId"
:hasMessages="getHasMessages"
>
  <div class="d-flex vh-100">
    <div class="flex-fill d-flex flex-column">
      <div class="d-flex align-items-center justify-content-between p-3 border-bottom bg-white" v-if="getMessage?.data1?.name">
        <div class="d-flex align-items-center">
          <img v-if="getMessage?.data1?.user_info?.profile_pic"
                :src="`/storage/${getMessage?.data1?.user_info?.profile_pic}` || '../../images/profile.jpeg'"
                class="rounded-circle me-2" width="41" height="40" style="max-height: 42px; min-height: 40px; max-width: 40px;" />
          <div>
            <span class="d-block fw-semibold username">{{ getMessage?.data1?.name }}</span>
            <small class="text-success online-text">Online</small>
          </div>
        </div>
        <i class="bi bi-three-dots-vertical fs-5 d-flex action1" @click.stop="togglePopup"></i>
      </div>

      <div ref="chatBox" class="flex-fill overflow-auto p-4 bg-light">
        <div v-for="(msg, index) in messages" :key="index"
              :class="['d-flex mb-2', msg.sender_id === getCurrentUserId ? 'justify-content-end' : 'justify-content-start']">

          <img v-if="msg.sender_id !== getCurrentUserId"
                :src="`/storage/${getMessage?.data1?.user_info?.profile_pic}` || '../../images/profile.jpeg'"
                class=" me-2 profile" width="40" height="40" />
          <div :class="{'text-start': msg.sender_id === getCurrentUserId}">
            <div :class="['message-bubble', msg.sender_id === getCurrentUserId ? 'bg-success text-white' : 'bg-white']">
              {{ msg.message }}
            </div>
            <small class="text-muted">{{ new Date(msg.created_at).toLocaleTimeString() }}</small>
          </div>
        </div>
      </div>

      <div class="p-3 border-top bg-white" v-if="getMessage?.data1?.name">
        <div class="input-group">
          <input
            type="text"
            v-model="newMessage"
            @keyup.enter="sendMessage"
            class="form-control"
            placeholder="Type a message..." />
          <button class="btn btn-success" @click="sendMessage">
            Send <i class="bi bi-send ms-1"></i>
          </button>
        </div>
      </div>
    </div>

    <!-- For the popup (togglePopup) -->
     <PopupForMessage :show="showPopup" ref="popupRef" :id="getMessage?.data1?.id"/>
    <div class="container-fluid d-flex flex-column gap-3 justify-content-center align-items-center fs-4" v-if="!getMessage?.data1?.name">
      <img src="../../images/message/select-message.svg" alt="Select message" class="img-fluid" 
      style="max-width: 300px;"/>
      No message selected
    </div>
  </div>
</MessageLayout>
</template>

<style scoped>
.list-group-item.active {
  background-color: #d1e7dd !important;
  border-color: #d1e7dd;
}
.username {
  transform: translateY(25%);
}
.message-bubble {
  width: auto;
  max-width: 600px;
  padding: 0.5rem 0.75rem;
  border-radius: 15px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  word-wrap: break-word;
}
.profile{
  width: 42px;
  height: 42px;
  border-radius: 50%;
}
</style>
