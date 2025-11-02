<script setup>
import MessageLayout from '@/Layouts/MessageLayout.vue';
import PopupForMessage from '@/Components/message/PopupForMessage.vue';
import { defineProps, onMounted, ref, watch, nextTick, onBeforeUnmount } from 'vue';
import Echo from 'laravel-echo';
import Pusher from 'pusher-js';
import axios from 'axios';
import { router } from '@inertiajs/vue3';
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
let isLoadingOlder = ref(false);
let hasMoreMessages = ref(true);

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
      sortMessages();
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
  sortMessages();
  scrollToBottom();

  try {
    const response = await axios.post('/messages/send', {
      receiver_id: props.message.data1.id,
      content: newMessage.value,
    });

    const index = messages.value.findIndex(msg => msg.id === localMessage.id);
    if (index !== -1) {
      messages.value[index] = { ...response.data };
      sortMessages();
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
const loadOlderMessages = async () => {
  if (isLoadingOlder.value || !hasMoreMessages.value) return;

  const firstMessage = messages.value[0];
  if (!firstMessage) return;
  
  isLoadingOlder.value = true;
  const prevHeight = chatBox.value.scrollHeight;

  try {
    const res = await axios.post('/messages/load-older', {
      other_user_id: props.message.data1.id,
      last_message_id: firstMessage.id
    });

    if (res.data.length === 0) {
      hasMoreMessages.value = false;
    } else {
      messages.value = [...res.data, ...messages.value];
      sortMessages();
      await nextTick();
      chatBox.value.scrollTop = chatBox.value.scrollHeight - prevHeight;
    }
  } finally {
    isLoadingOlder.value = false;
  }
};

const deleteMessage = async (id) => {
  try {
    await axios.delete('/messages/delete', {
      data: { message_id: id }
    });

    messages.value = messages.value.filter(msg => msg.id !== id);
    sortMessages();
  } catch (err) {
    console.error("Delete failed", err);
  }
};


onMounted(() => {
  document.addEventListener('click', handleClickOutside);
  chatBox.value.addEventListener("scroll", () => {
    if (chatBox.value.scrollTop === 0) {
      loadOlderMessages();
    }
  });
});
onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside);
});
const toggleDeleteMenu = (msg) => {
  messages.value.forEach(m => {
    if (m !== msg) m.showDelete = false;
  });

  msg.showDelete = !msg.showDelete;
};

// Hide dropdown on outside click
const hideAllDropdowns = (event) => {
  messages.value.forEach(m => {
    if (m.showDelete) m.showDelete = false;
  });
};
const sortMessages = () => {
  messages.value.sort((a, b) =>
    new Date(a.created_at) - new Date(b.created_at)
  );
};

let isChannelInitialized = false;

onMounted(() => {
  // Init messages & UI setup
  getPinnedvalue.value = Array.isArray(props.pinned)
    ? props.pinned
    : Object.values(props.pinned);

  if (Array.isArray(props.message.data2)) {
    messages.value = [...props.message.data2];
  }

  nextTick(scrollToBottom);

  // ✅ Setup channel once only
  if (!isChannelInitialized) {
    setupChannel(props.currentUserId);
    isChannelInitialized = true;
  }

  document.addEventListener('click', handleClickOutside);
  document.addEventListener("click", hideAllDropdowns);

  if (chatBox.value) {
    chatBox.value.addEventListener("scroll", () => {
      if (chatBox.value.scrollTop === 0) {
        loadOlderMessages();
      }
    });
  }
});

onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside);
  document.removeEventListener("click", hideAllDropdowns);

  if (echoChannel) {
    echoChannel.stopListening('NewMessageSent');
    window.Echo.leave(`chat.${props.currentUserId}`);
  }
});
const moreUsers = () => {
  router.visit(route('viewMoreUsers.index'));
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
            <!-- <small class="text-success online-text">Online</small> -->
          </div>
        </div>
        <i class="bi bi-three-dots-vertical fs-5 d-flex action1" @click.stop="togglePopup"></i>
      </div>

      <div ref="chatBox" class="flex-fill overflow-auto p-4 bg-light">
        <div v-for="(msg) in messages" :key="msg.id"
  class="d-flex mb-2 position-relative"
  :class="msg.sender_id === getCurrentUserId ? 'justify-content-end' : 'justify-content-start'"
>
  <div
    class="message-container"
    :class="msg.sender_id === getCurrentUserId ? 'text-start' : ''"
    @mouseenter="msg.showMenu = true"
    @mouseleave="msg.showMenu = false"
  >
    <!-- Three dots menu - only show for your messages -->
    <i v-if="msg.sender_id === getCurrentUserId"
       class="bi bi-three-dots-vertical message-menu-icon"
       @click.stop="toggleDeleteMenu(msg)"
    ></i>

    <div
      class="message-bubble"
      :class="[
        msg.sender_id === getCurrentUserId
          ? 'bg-success text-white current_user'
          : 'bg-white chat_with'
      ]"
    >
      {{ msg.message }}
    </div>

    <small class="text-muted">{{ new Date(msg.created_at).toLocaleTimeString() }}</small>

    <!-- Dropdown Delete -->
    <div
      v-if="msg.showDelete"
      class="dropdown-delete"
      @click.stop="deleteMessage(msg.id)"
    >
      Delete
    </div>
  </div>
</div>


      </div>

          <div class="p-3 border-top bg-white" v-if="getMessage?.data1?.name">
        <div class="d-flex align-items-end gap-2">
          <textarea
            v-model="newMessage"
            @input="e => { 
              e.target.style.height = 'auto'; 
              e.target.style.height = e.target.scrollHeight + 'px'; 
            }"
            @keyup.enter.exact.prevent="sendMessage"
            class="form-control flex-grow-1 auto-resize-textarea"
            rows="1"
            placeholder="Type a message..."
          ></textarea>
          <button class="btn btn-success" @click="sendMessage">
            Send <i class="bi bi-send ms-1"></i>
          </button>
        </div>
    </div>

    </div>

    <!-- For the popup (togglePopup) -->
     <PopupForMessage :show="showPopup" ref="popupRef" :id="getMessage?.data1?.id"/>

    <div class="container-fluid" v-if="!getMessage?.data1?.name">
        <div class="empty-state-container d-flex flex-column justify-content-center align-items-center position-relative">
            <!-- Floating background elements -->
            <div class="floating-elements">
                <div class="floating-element"></div>
                <div class="floating-element"></div>
                <div class="floating-element"></div>
            </div>
            
            <!-- Main illustration -->
            <img src="https://cdn.jsdelivr.net/gh/twitter/twemoji@latest/assets/svg/1f4ac.svg" 
                 alt="Select message" 
                 class="empty-state-illustration pulse-animation">
            
            <!-- Text content -->
            <h2 class="empty-state-title">No Message Selected</h2>
            <p class="empty-state-subtitle">
                Select a conversation from the list or start a new one to begin messaging.
            </p>
            
            <!-- Action button -->
            <button type="button" class="action-button text-dark" @click="moreUsers">
                <i class="bi bi-people-fill"></i>
                Find More Users
            </button>
        </div>
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
  transform: translateY(0%);
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
.message-container {
  position: relative;
  max-width: 70%;
  display: flex;
  flex-direction: column;
}

.message-menu-icon {
  position: absolute;
  left: -20px;  /* Always left */
  top: 8px;
  font-size: 16px;
  cursor: pointer;
  opacity: 0;
  transition: opacity 0.15s;
}

.message-container:hover .message-menu-icon {
  opacity: 1;
}

.dropdown-delete {
  position: absolute;
  left: -75px; /* Dropdown also left */
  top: 35px;
  background: #ffffff;
  border: 1px solid #ddd;
  padding: 6px 12px;
  border-radius: 6px;
  cursor: pointer;
  white-space: nowrap;
  box-shadow: 0 2px 6px rgba(0,0,0,0.15);
  font-size: 14px;
  z-index: 200;
}

.dropdown-delete:hover {
  background: #f8d7da;
}

.current_user {
  background: #007f5f;
  color: #fff;
  border-bottom-right-radius: 4px;
  align-self: flex-end;
  box-shadow: 0px 2px 6px rgba(0, 128, 0, 0.2);
}

/* ✅ Other user's messages */
.chat_with {
  background: #ffffff;
  color: #111;
  border-bottom-left-radius: 4px;
  align-self: flex-start;
  box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.08);
}

/*  Make bubble slightly pop when hovered */
.message-bubble:hover {
  transform: scale(1.01);
}

/*  Three-dot icon positioning */
.message-menu-icon {
  position: absolute;
  top: 8px;
  left: -28px; /* stays always left */
  font-size: 16px;
  cursor: pointer;
  opacity: 0;
  transition: opacity 0.2s ease;
}
.auto-resize-textarea {
  resize: none;
  overflow: hidden;
  min-height: 40px;
  max-height: 200px;
  line-height: 1.5;
  transition: height 0.2s ease;
}

 .empty-state-container {
            min-height: 70vh;
            padding: 2rem 1rem;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
        }
        
        .empty-state-container:hover {
            box-shadow: var(--hover-shadow);
        }
        
        .empty-state-illustration {
            max-width: 280px;
            filter: drop-shadow(0 10px 15px rgba(0, 0, 0, 0.1));
            transition: var(--transition);
        }
        
        .empty-state-illustration:hover {
            transform: translateY(-5px);
            filter: drop-shadow(0 15px 20px rgba(0, 0, 0, 0.15));
        }
        
        .empty-state-title {
            font-size: 1.75rem;
            font-weight: 600;
            color: #2d3748;
            margin: 1.5rem 0 0.5rem;
            letter-spacing: -0.5px;
        }
        
        .empty-state-subtitle {
            font-size: 1.1rem;
            color: #718096;
            max-width: 500px;
            text-align: center;
            line-height: 1.6;
            margin-bottom: 2rem;
        }
        
        .action-button {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-size: 1.1rem;
            font-weight: 500;
            color: white;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            width: 100%;
            max-width: 240px;
            margin-top: 1rem;
        }
        
        .action-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .action-button:active {
            transform: translateY(0);
        }
        
        .pulse-animation {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }
        
        .floating-elements {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            overflow: hidden;
            z-index: -1;
            border-radius: 20px;
        }
        
        .floating-element {
            position: absolute;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            opacity: 0.7;
        }
        
        .floating-element:nth-child(1) {
            width: 60px;
            height: 60px;
            top: 10%;
            left: 10%;
            animation: float 15s infinite linear;
        }
        
        .floating-element:nth-child(2) {
            width: 40px;
            height: 40px;
            top: 70%;
            left: 80%;
            animation: float 12s infinite linear reverse;
        }
        
        .floating-element:nth-child(3) {
            width: 30px;
            height: 30px;
            top: 30%;
            left: 85%;
            animation: float 18s infinite linear;
        }
        
        @keyframes float {
            0% {
                transform: translate(0, 0) rotate(0deg);
            }
            100% {
                transform: translate(30px, 30px) rotate(360deg);
            }
        }
        
        .container-fluid {
            padding: 2rem;
        }
</style>
