<script setup>
import { defineProps, ref, watch } from "vue";
import { router } from "@inertiajs/vue3";

const props = defineProps({
  notification: {
    type: Array,
    default: () => [],
  },
});

const getData = ref([]);
const alertMessage = ref("");
const showAlert = ref(false);

watch(
  () => props.notification,
  (i) => {
    getData.value = i;
  },
  { immediate: true }
);
const deleteNotification = (id) => {
  router.delete(
    route("settings.deleteNotification", { id }),
    {},
    {
      onSuccess: () => {
        alertMessage.value = "Notification deleted successfully.";
        showAlert.value = true;

        setTimeout(() => {
          showAlert.value = false;
        }, 3000);
      },
    }
  );
};
const viewItem = async (index, id, readStatus, title, itemId) => {
  const t = title.toLowerCase();

  if (readStatus === 0) {
    await router.put(
      route("settings.modifyReadStatus", { notification: id }),
      {},
      { preserveScroll: true }
    );

    // Update local state only after promise resolved
    getData.value[index].read_status = 1;
  }

  if (!itemId) {
    alert("No associated item for this notification.");
    return;
  }

  const actions = {
    resolved: () => {
      alert("Your reported item has been marked as resolved. Thank you for using our service!");
    },
    "face to face verification": () => {
      router.get(route("face.to.face", { id: itemId }));
    },
    approved: () => {
      router.get(route("viewItemInfo", { item: itemId }));
    },
    denied: () => {
      router.get(route("deniedRequests.index", { itemId }));
    },
  };

  const match = Object.keys(actions).find((key) => t.includes(key));

  if (match) {
    actions[match]();
  } else {
    alert("No redirect page defined for this title.");
  }
};

const formatDate = (dateString) => {
  const options = { year: "numeric", month: "long", day: "numeric" };
  return new Date(dateString).toLocaleDateString(undefined, options);
};
</script>

<template>
  <div>
    <div v-if="showAlert" class="alert alert-success text-center" role="alert">
      {{ alertMessage }}
    </div>

    <div class="notification-container d-flex flex-wrap gap-3">
      <div
        class="card p-3 rounded w-100 py-4"
        style="max-width: 90%"
        v-for="(data, index) in getData"
        :key="data.id"
      >
        <div class="flex-grow-1">
  <div class="d-flex justify-content-between align-items-start mb-1">
    <div class="d-flex flex-row gap-1">
      <div class="w-100">
        <h6 class="mb-1 fw-bold text-dark fs-5">{{ data.title }}</h6>
        <small class="text-muted">{{ formatDate(data.created_at) }}</small>
      </div>

      <div 
      v-if="data.read_status == 0 && !data?.title.includes('Post Deleted')" 
      class="not-read ms-2"></div>
    </div>
  </div>

  <p class="mb-2 text-muted" style="font-size: 0.95rem">
    {{ data.message }}
  </p>

  <div>
    <a
      href="#"
      class="text-decoration-none fw-bold btn btn-primary"
      v-if="!data?.title.includes('Post Deleted') || !data?.title.includes('Approved')"
      @click.prevent="viewItem(index, data.id, data.read_status, data.title, data.item_id)"
    >
      View
    </a>
  </div>
</div>

      </div>
    </div>
  </div>
</template>

<style scoped>
.not-read {
  width: 10px;
  height: 10px;
  background: #099c3a;
  border-radius: 50%;
}
.card {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
.notification-container {
  max-height: 500px;
  overflow-y: auto;
  padding-right: 8px;
}
</style>
