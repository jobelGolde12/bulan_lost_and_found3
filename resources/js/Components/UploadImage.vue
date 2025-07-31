<template>
  <div 
    class="container mx-auto flex flex-col items-center justify-center p-6 border-2 border-dashed rounded-lg shadow-md bg-white transition relative"
    :class="{ 'border-blue-500 border-solid': isDragging }"
    @dragover.prevent="dragOver"
    @dragleave.prevent="dragLeave"
    @drop.prevent="handleDrop">
    
    <label for="profile_pic" class="cursor-pointer w-full text-center py-6">
      <div v-if="!previewImage" class="flex flex-col items-center">
        <svg class="w-20 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M7 16V4m0 0l-4 4m4-4l4 4m10 6v6m0 0l-4-4m4 4l4-4" />
        </svg>
        <p class="text-gray-600 mt-2">
          Drag and drop an image or <span class="text-blue-500 underline">click to upload</span>
        </p>
      </div>
      <img v-else :src="previewImage" alt="Preview"
           class="w-full h-full object-cover absolute top-0 left-0" />
    </label>

    <input id="profile_pic" type="file" accept="image/*" class="hidden" @change="handleFileChange" />
  </div>
</template>

<script>
export default {
  data() {
    return {
      previewImage: null,
      isDragging: false,
    };
  },
  methods: {
    handleFileChange(event) {
      const file = event.target.files[0];
      if (file) {
        this.previewImage = URL.createObjectURL(file);
        this.$emit("file-selected", file);
      }
    },
    handleDrop(event) {
      const file = event.dataTransfer.files[0];
      if (file) {
        this.previewImage = URL.createObjectURL(file);
        this.$emit("file-selected", file);
      }
      this.isDragging = false;
    },
    dragOver() {
      this.isDragging = true;
    },
    dragLeave() {
      this.isDragging = false;
    },
  },
};
</script>

<style scoped>
.container {
  max-width: 400px;
  min-height: 250px;
  text-align: center;
  position: relative;
  overflow: hidden;
}
</style>
