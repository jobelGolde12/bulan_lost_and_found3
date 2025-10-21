<script setup>
import UserSettingsLayout from '@/Layouts/UserSettingsLayout.vue'
import { Link } from '@inertiajs/vue3';
import PostsCard from '@/Components/user/PostsCard.vue';

const props = defineProps({
  items: {
    type: Array,
    default: () => [],
  },
})
</script>

<template>
  <UserSettingsLayout>
    <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 py-10 px-6 md:px-10">
      <div class="max-w-6xl mx-auto">
        <!-- Header -->
        <div class="flex items-center justify-between align-items-center mb-8">
          <h1 class="text-3xl font-semibold text-gray-800 flex items-center gap-3">
            <i class="bi bi-box-seam text-indigo-500 text-4xl"></i>
            <span class="post-text">Your Posts</span>
          </h1>

         <div>
             <Link
          :href="route('reportItem')"
            class="add-post flex items-center gap-2 bg-indigo-600 text-white px-4 py-2 rounded-xl hover:bg-indigo-700 transition-all duration-300 shadow-md hover:shadow-lg text-decoration-none"
          >
            <i class="bi bi-plus-lg text-lg"></i>
            <span class="d-none d-lg-block">Add Post</span>
    </Link>
         </div>
        </div>

        <!-- Items Section -->
        <div
          class="d-flex gap-2 align-items-center"
        v-if="props.items.length > 0"
        >
          <!-- Pass items to ItemCard -->
          <div >
            <PostsCard :items="props.items" />
          </div>

        </div>

        <div class="container-fluid text-center " v-else>
            <h5 class="text-muted">No Post Found.</h5>
          </div>


      </div>
    </div>
  </UserSettingsLayout>
</template>

<style scoped>
/* Optional subtle card hover effect */
.grid > *:hover {
  transform: translateY(-4px);
  transition: all 0.3s ease;
}
.add-post{
    position: relative;
    transform: translateY(-40%);
}
.post-text{
  font-size: 2rem;
}
@media screen and (max-width: 756px){
  .post-text{
    font-size: 1rem;
  }
  .add-post{
    transform: translateY(-20%);
  }
}
</style>
