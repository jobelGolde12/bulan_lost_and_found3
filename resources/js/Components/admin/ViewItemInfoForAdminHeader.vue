<script setup>
import { defineProps, ref, onMounted, onBeforeUnmount } from 'vue';
import { Link, router } from '@inertiajs/vue3';

const props = defineProps({
  id: {
    type: [Number, String, null],
    default: null,
  },
  item_id: Number,
  profile: String,
  title: String,
  description: String,
  name: String,
});

// Popup state
const showPopup = ref(false);
const popupRef = ref(null);
const iconRef = ref(null);

// Toggle popup
const togglePopup = () => {
  showPopup.value = !showPopup.value;
};

// Handle outside click
const handleClickOutside = (event) => {
  if (
    popupRef.value &&
    !popupRef.value.contains(event.target) &&
    iconRef.value &&
    !iconRef.value.contains(event.target)
  ) {
    showPopup.value = false;
  }
};

onMounted(() => {
  document.addEventListener("click", handleClickOutside);
});
onBeforeUnmount(() => {
  document.removeEventListener("click", handleClickOutside);
});

// Resolve function
const markAsResolveFunc = () => {
  if (!props.id) {
    alert("The user no longer exists.");
    return;
  }

  const url = `/mark-as-resolve/${props.item_id}/${props.id}`;
  router.post(url, {}, {
    onSuccess: () => alert("Item resolved. You can now go back to items."),
    onError: () => alert("Something went wrong, please try again.")
  });
};

// Force delete
const forceDelete = () => {
  if(confirm("Are you sure you want to delete this item? ")){
      router.delete(route('forceDeleteItem', {id: props.item_id}), {}, {
    onSuccess: () => alert('Item deleted.'),
    onError: () => alert('An error occurred, please try again.')
  });
  }

};
</script>

<template>
  <div class="position-relative">
    <div class="d-flex flex-column gap-3 mb-4 header">
      <!-- profile, name, actions -->
      <div class="container-fluid d-flex flex-row justify-content-between align-items-center px-0">

        <!--  If user exists -->
<div v-if="props.id">
  <Link
    :href="route('viewUserAsAdmin', { id: props.id })"
    class="text-decoration-none d-flex align-items-center justify-content-end gap-2"
  >
    <img
      :src="props.profile === 'NA' ? '../../../images/profile.jpeg' : `/storage/${props.profile}`"
      alt="User"
      class="profile-pic rounded-full"
    />
    <span class="text-sm font-medium text-gray-700">{{ props.name }}</span>
  </Link>
</div>

<!--  Fallback for deleted user -->
<div v-else class="d-flex align-items-center gap-2 text-muted">
  <img
    src="../../../images/profile.jpeg"
    alt="User"
    class="profile-pic rounded-full"
  />
  <span class="text-sm font-medium">Deleted User</span>
</div>


        <div ref="iconRef" class="position-relative">
          <i class="bi bi-three-dots-vertical action" @click="togglePopup"></i>
          <!-- Popup -->
          <div
            v-if="showPopup"
            ref="popupRef"
            class="position-absolute bg-white border shadow-sm rounded d-flex flex-column"
            style="right: 10%; top: 100%; z-index: 999; min-width: 200px;"
          >
            <button class="button mb-2" @click="markAsResolveFunc">Mark as Resolve</button>
            <button class="button" @click="forceDelete" title="Note! only if the user didn't follow the privacy and policy.">Force Delete</button>
            <button class="button" data-bs-toggle="modal" data-bs-target="#downloadAsPDF">Download as PDF</button>
          </div>
        </div>
      </div>

      <!-- title & description -->
      <div class="d-flex flex-column w-100">
        <h2 class="text-xl font-semibold mb-0">{{ props.title || "Unnamed Item" }}</h2>
        <p class="description">{{ props.description || "No description" }}</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.description {
  font-size: 0.8rem;
}
.profile-pic {
  max-width: 35px;
  min-width: 35px;
  height: 35px;
}
.action {
  cursor: pointer;
}
.button {
  text-align: left;
  padding: .5rem 1rem;
}
.button:hover {
  background: #e9e3e3;
}
</style>
