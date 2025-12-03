<script setup>
import UserSettingsLayout from '@/Layouts/UserSettingsLayout.vue'
import { Link, Head } from '@inertiajs/vue3'
import PostsCard from '@/Components/user/PostsCard.vue'
import axios from 'axios'
import { ref } from 'vue'

const props = defineProps({
  items: {
    type: Array,
    default: () => [],
  },
})

const posts = ref(props.items)
const loading = ref(false)
const activeTab = ref('posts')

// Show original posts
const showOriginalPosts = () => {
  activeTab.value = 'posts'
  posts.value = props.items
}

// Fetch pending posts
const fetchPendingPosts = async () => {
  loading.value = true
  activeTab.value = 'pending'
  try {
    const response = await axios.get(route('post.pendingRequests.index'))
    posts.value = response.data.data
  } catch (error) {
    console.error('Error fetching pending posts:', error)
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <UserSettingsLayout>
    <Head title="My Posts" />
    <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 py-10 px-6 md:px-10">
      <div class="max-w-6xl mx-auto">

        <!-- Header -->
        <div class="flex items-center justify-between mb-8">
          <h1 class="text-3xl font-semibold text-gray-800 flex items-center gap-3">
            <i class="bi bi-box-seam text-indigo-500 text-4xl"></i>
            <span class="post-text">Your Posts</span>
          </h1>

          <div class="flex items-center gap-3 p-1 bg-white/80 backdrop-blur-sm rounded-2xl border border-gray-200/60 shadow-sm">
          <!-- Posts Icon -->
          <button
            @click="showOriginalPosts"
            :class="['modern-icon-btn group', activeTab === 'posts' ? 'modern-active-tab' : '']"
            title="Show Active Posts"
          >
            <div class="modern-icon-wrapper">
              <i class="bi bi-grid-3x3-gap-fill text-lg"></i>
            </div>
            <span class="modern-tooltip">Active Posts</span>
          </button>

          <!-- Pending Posts Icon -->
          <button
            @click="fetchPendingPosts"
            :class="['modern-icon-btn group', activeTab === 'pending' ? 'modern-active-tab' : '']"
            title="Pending Posts"
          >
            <div class="modern-icon-wrapper">
              <i class="bi bi-clock-history text-lg"></i>
            </div>
            <span class="modern-tooltip">Pending</span>
          </button>

          <!-- Add Post Button -->
          <Link
            :href="route('reportItem')"
            class="modern-add-post group flex items-center gap-2 bg-gradient-to-r from-indigo-500 to-purple-600 text-white px-5 py-2.5 rounded-xl hover:from-indigo-600 hover:to-purple-700 transition-all duration-300 shadow-lg hover:shadow-xl hover:-translate-y-0.5 border-0"
          >
            <div class="modern-add-icon">
              <i class="bi bi-plus-lg text-base"></i>
            </div>
            <span class="font-semibold tracking-tight d-none d-lg-block">Add Post</span>
            <div class="modern-ripple"></div>
          </Link>
        </div>

        </div>

        <!-- Loading Spinner -->
        <div v-if="loading" class="text-center py-10">
          <div class="spinner-border text-indigo-600" role="status" style="width: 3rem; height: 3rem;">
          </div>
        </div>

        <!-- Posts Section -->
        <div v-else>
          <div v-if="posts.length > 0">
            <PostsCard :items="posts" />
          </div>

          <div class="text-center mt-6" v-else>
            <h5 class="text-muted">No Post Found.</h5>
          </div>
        </div>

      </div>
    </div>
  </UserSettingsLayout>
</template>

<style scoped>
.icon-btn {
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 10px;
  border-radius: 50%;
  transition: 0.25s ease-in-out;
}
.icon-btn:hover {
  background-color: rgba(99, 102, 241, 0.15);
  transform: scale(1.1);
}
.active-tab {
  background-color: rgba(99, 102, 241, 0.25);
  border: 1px solid rgba(99, 102, 241, 0.6);
}
.add-post {
  transform: translateY(-40%);
}
.post-text {
  font-size: 2rem;
}
.modern-icon-btn {
  @apply relative p-2 rounded-xl transition-all duration-300 border-0 bg-transparent hover:bg-white/60 active:scale-95;
}

.modern-icon-wrapper {
  @apply p-2 rounded-lg transition-all duration-300 bg-gray-100/80 group-hover:bg-white group-hover:shadow-md;
}

.modern-active-tab .modern-icon-wrapper {
  @apply bg-gradient-to-br from-indigo-500 to-purple-600 text-white shadow-lg;
}

.modern-tooltip {
  @apply absolute -bottom-8 left-1/2 transform -translate-x-1/2 text-xs font-medium bg-gray-900 text-white px-2 py-1 rounded-md opacity-0 group-hover:opacity-100 transition-opacity duration-200 pointer-events-none whitespace-nowrap;
}

.modern-add-post {
  position: relative;
  overflow: hidden;
}

.modern-add-icon {
  @apply transition-transform duration-300 group-hover:scale-110;
}

.modern-ripple {
  @apply absolute inset-0 bg-gradient-to-r from-white/20 to-transparent -translate-x-full group-hover:translate-x-full transition-transform duration-700;
}

/* Optional: Add subtle animation for the active state */
.modern-active-tab .modern-icon-wrapper {
  animation: gentlePulse 2s ease-in-out infinite;
}

@keyframes gentlePulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

/* Glass morphism effect for the container */
.backdrop-blur-sm {
  backdrop-filter: blur(8px);
}
@media screen and (max-width: 756px) {
  .post-text {
    font-size: 1rem;
  }
  .add-post {
    transform: translateY(-20%);
  }
}
</style>
