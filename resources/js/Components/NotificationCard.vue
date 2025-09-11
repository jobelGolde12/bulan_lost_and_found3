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
watch(
  () => props.notification,
  (i) => {
    getData.value = i;
  },
  { immediate: true }
);

const selectedNotification = ref(null);
const modalResult = ref(null);
const viewItemIndex = ref(null);

const deleteNotification = () => {
  modalResult.value = "yes";
  router.delete(
    route("settings.deleteNotification", { id: selectedNotification.value }),
    {},
    {
      onSuccess: alert("Notification Trashed."),
    }
  );
};

const passIdToDelete = (id) => {
  selectedNotification.value = id;
};

const viewItem = (index, id, readStatus) => {
  viewItemIndex.value = index;
  if (readStatus === 1) {
    return 0;
  }
  router.put(
    route("settings.modifyReadStatus", { notification: id }),
    {},
    {
      onSuccess: () => {
        getData.value[index].read_status = 1;
      },
    }
  );
};

const formatDate = (dateString) => {
  const options = { year: "numeric", month: "long", day: "numeric" };
  return new Date(dateString).toLocaleDateString(undefined, options);
};
</script>

<template>
  <div>
    <!-- Flex container for cards -->
    <div class="d-flex flex-wrap gap-3">
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
              data-bs-toggle="modal"
              data-bs-target="#deleteModal"
              aria-label="Close"
              @click="passIdToDelete(data.id)"
            ></button>
          </div>
          <p class="mb-2 text-muted" style="font-size: 0.95rem">
            {{ data.message }}
          </p>
          <div>
            <a
              href="#"
              class="me-3 text-decoration-none text-secondary"
              data-bs-toggle="modal"
              data-bs-target="#deleteModal"
              @click="passIdToDelete(data.id)"
              >Delete</a
            >
            <a
              href="#"
              class="text-decoration-none fw-bold"
              data-bs-toggle="modal"
              data-bs-target="#viewNotification"
              @click.prevent="viewItem(index, data.id, data.read_status)"
              >Full View</a
            >
          </div>
        </div>
      </div>
    </div>

    <!-- Delete Modal -->
    <div
      class="modal fade"
      id="deleteModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">Dismiss</h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            This action can
            <span class="text-danger">delete</span> the notification, are you
            sure you want to proceed?
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              No
            </button>
            <button
              type="button"
              class="btn btn-info"
              @click="deleteNotification"
              data-bs-dismiss="modal"
            >
              Yes
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- View Modal -->
    <div
      class="modal fade"
      id="viewNotification"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">
              Notification details
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <div>
              <p class="text-dark mb-0">
                <span class="fw-bold">Title: </span>
                {{ getData[viewItemIndex]?.title || "No title" }}
              </p>

              <p class="text-dark mb-0">
                <span class="fw-bold">Message: </span>
                {{ getData[viewItemIndex]?.message || "No description" }}
              </p>

              <p class="text-dark mb-0">
                <span class="fw-bold">Date: </span>
                {{ formatDate(getData[viewItemIndex]?.created_at) || "No date" }}
              </p>
            </div>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Close
            </button>
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
</style>
