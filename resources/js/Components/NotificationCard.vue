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
console.log(getData);
const viewItem = (index, id, readStatus, title, itemId) => {
  if (readStatus === 0) {
    router.put(route("settings.modifyReadStatus", { notification: id }), {}, {
      onSuccess: () => {
        getData.value[index].read_status = 1;
      },
    });
  }

  if (title.toLowerCase().includes("denied")) {
    alert("Cannot redirect to denied item as it has been deleted.");
    return;
  } else if (!itemId) {
    alert("No associated item for this notification.");
    return;
  }

  if (title.toLowerCase().includes("resolved")) {
    alert("Your reported item has been marked as resolved. Thank you for using our service!");
  } else if (title.toLowerCase().includes("face to face")) {
    router.get(route("face.to.face", { id: itemId }));
  } else if (title.toLowerCase().includes("approved")) {
    router.get(route("viewItemInfo", { item: itemId }));
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
    <!-- Bootstrap alert -->
    <div v-if="showAlert" class="alert alert-success text-center" role="alert">
      {{ alertMessage }}
    </div>

    <!-- Scrollable flex container -->
    <div class="notification-container d-flex flex-wrap gap-3">
      <div
        class="card p-3 rounded"
        style="width: 500px"
        v-for="(data, index) in getData"
        :key="data.id"
      >
        <div class="flex-grow-1">
          <div class="d-flex justify-content-between align-items-start mb-1">
            <div class="d-flex flex-row gap-1">
              <div>
                <h6 class="mb-0">{{ data.title }}</h6>
              </div>
              <div>
                <div class="not-read" v-if="data.read_status == 0"></div>
              </div>
            </div>
            <button
              type="button"
              class="btn-close ms-2"
              aria-label="Close"
              @click="deleteNotification(data.id)"
            ></button>
          </div>
          <p class="mb-2 text-muted" style="font-size: 0.95rem">
            {{ data.message }}
          </p>
          <div>
            <a
              href="#"
              class="me-3 text-decoration-none text-secondary"
              @click.prevent="deleteNotification(data.id)"
              >Delete</a
            >
            <a
              href="#"
              class="text-decoration-none fw-bold"
              @click.prevent="viewItem(index, data.id, data.read_status, data.title, data.item_id)"
              >View</a
            >
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
