<script setup>
import { Head } from "@inertiajs/vue3";
import UserSettingsLayout from "@/Layouts/UserSettingsLayout.vue";
import NotificationCard from "@/Components/NotificationCard.vue";
import { defineProps, ref, watch, computed } from "vue";

const props = defineProps({
  notifications: {
    type: Array,
    default: () => []
  },
  hasUnread: {
    type: Boolean,
    default: false
  }
});

const getData = ref([]);
const sortOrder = ref("latest");
const filterStatus = ref("all"); // all | viewed | unviewed
const getHasUnread = ref(props.hasUnread);
watch(
  () => props.notifications,
  (i) => {
    getData.value = i;
    console.log("Notifications updated:", getData.value);
  },
  { immediate: true }
);

const filteredAndSortedNotifications = computed(() => {
  let data = [...getData.value];

  if (filterStatus.value === "viewed") {
    data = data.filter(n => n.read_status === 1);
  } else if (filterStatus.value === "unviewed") {
    data = data.filter(n => n.read_status === 0);
  }

  data.sort((a, b) => {
    const dateA = new Date(a.created_at);
    const dateB = new Date(b.created_at);
    return sortOrder.value === "latest" ? dateB - dateA : dateA - dateB;
  });

  return data;
});

const toggleSortOrder = () => {
  sortOrder.value = sortOrder.value === "latest" ? "oldest" : "latest";
};

const toggleFilter = () => {
  if (filterStatus.value === "all") filterStatus.value = "unviewed";
  else if (filterStatus.value === "unviewed") filterStatus.value = "viewed";
  else filterStatus.value = "all";
};
</script>

<template>
  <Head title="Notifications" />
  <UserSettingsLayout :hasUnread="getHasUnread">
    <div>
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="mb-0">Notifications</h1>

        <div class="d-flex align-items-center gap-5 me-4">
          <div
            class="text-dark fs-5 pointer d-flex align-items-center"
            @click="toggleFilter"
            title="Filter notifications"
          >
            <i class="bi bi-filter me-1"></i>
            <span style="font-size: 0.9rem;">
              {{ 
                filterStatus === "all" ? "All" :
                filterStatus === "viewed" ? "Viewed" : "Unviewed" 
              }}
            </span>
          </div>

          <div
            class="text-dark fs-5 pointer d-flex align-items-center"
            @click="toggleSortOrder"
            title="Sort notifications"
          >
            <i class="bi bi-sort-down me-1"></i>
            <span style="font-size: 0.9rem;">
              {{ sortOrder === "latest" ? "Latest → Oldest" : "Oldest → Latest" }}
            </span>
          </div>
        </div>
      </div>

      <div class="container text-center" v-if="filteredAndSortedNotifications.length < 1">
        No notification found.
      </div>

      <NotificationCard :notification="filteredAndSortedNotifications" v-else />
    </div>
  </UserSettingsLayout>
</template>

<style scoped>
.pointer {
  cursor: pointer;
}
</style>
