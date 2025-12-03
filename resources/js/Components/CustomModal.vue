<template>
    <div>
      <!-- Modal -->
      <div 
        class="modal fade" 
        id="customModal" 
        tabindex="-1" 
        aria-labelledby="customModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="customModalLabel" v-if="user">Hi, {{ user.name }}</h5>
              <button 
                type="button" 
                class="btn-close" 
                data-bs-dismiss="modal" 
                aria-label="Close"></button>
            </div>
            <div class="modal-body d-flex flex-column gap-1">
              <div>
                <p class="text-dark">{{ name }}</p>
              </div>
  
              <div class="d-flex flex-row gap-2 align-items-center">
                <div>
                  <button 
                    class="button1" 
                    @click="handleResponse('yes')"
                    data-bs-dismiss="modal"
                    >Yes</button>
                </div>
                <div>
                  <button 
                    class="btn btn-secondary" 
                    @click="handleResponse('no')"
                    data-bs-dismiss="modal">No</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  import { usePage } from '@inertiajs/vue3';
  import { defineEmits } from 'vue';
  
  const user = usePage().props.auth.user;
  
 
  const props = defineProps({
    name: {
      type: String,
      required: true,
    },
    id: {
      type: [String, Number],
      required: true,
    },
  });
  
  
  const response = ref('');
  
  
  const emit = defineEmits(['response']);

    const handleResponse = (value) => {
    emit('response', value);
    };
  </script>
  
  <style scoped>
  @import '../../css/global.css';
  </style>
    