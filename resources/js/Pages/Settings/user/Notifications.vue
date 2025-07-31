<script setup>
import { Head } from "@inertiajs/vue3";
import UserSettingsLayout from "@/Layouts/UserSettingsLayout.vue";
import NotificationCard from "@/Components/NotificationCard.vue";
import { defineProps, ref, watch } from "vue";

const props = defineProps({
  notifications: {
    type: Array,
    default: () => []
  }
})

const getData = ref([]);
watch(
  () => props.notifications,
  (i) => {
    getData.value = i;
  },
  {immediate: true}
)
</script>

<template>
    <Head title="Notifications" />
  <UserSettingsLayout>
    <div>
      <h1>Notifications</h1>
      <div class="container text-center" v-if="getData.length < 1">No notification this time.</div>
      <NotificationCard :notification="getData" v-else/>
  </div>
  </UserSettingsLayout>

</template>
