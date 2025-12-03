<!-- resources/js/Pages/DeniedPage.vue -->
<script setup>
import { defineProps } from "vue";
import { Head, Link } from "@inertiajs/vue3";

const props = defineProps({
  deniedRequests: {
    type: Array,
    default: () => [],
  },
});
</script>

<template>
  <Head title="Denied Requests" />

  <div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2 class="fw-bold text-danger">
        <i class="bi bi-x-circle-fill me-2"></i>Denied Requests
      </h2>
      <span class="badge bg-danger fs-6">
        <i class="bi bi-exclamation-triangle-fill me-1"></i>
        {{ props.deniedRequests.length }} total
      </span>
    </div>

    <div v-if="props.deniedRequests.length" class="table-responsive rounded">
      <table class="table align-middle table-hover">
        <thead class="table-dark">
          <tr>
            <th scope="col">#</th>
            <th scope="col"><i class="bi bi-person-fill me-1"></i>User ID</th>
            <th scope="col"><i class="bi bi-file-earmark-text me-1"></i>Request ID</th>
            <th scope="col"><i class="bi bi-chat-left-text me-1"></i>Reason</th>
            <th scope="col"><i class="bi bi-clock-history me-1"></i>Date</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(request, index) in props.deniedRequests" :key="request.id">
            <th scope="row">{{ index + 1 }}</th>
            <td>{{ request.user_id }}</td>
            <td>{{ request.request_id }}</td>
            <td>
              <span class="text-danger">
                <i class="bi bi-x-circle me-1"></i>{{ request.reason }}
              </span>
            </td>
            <td>{{ new Date(request.created_at).toLocaleString() }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    

    <div v-else class="text-center py-5">
      <i class="bi bi-inbox fs-1 text-muted"></i>
      <p class="mt-3 text-secondary">No denied requests found.</p>
    </div>

        <div class="container ps-0">
        <Link :href="route('settings.index')" class="btn btn-dark mt-3">Go back</Link>
      </div>
  </div>
</template>

<style scoped>
.container {
  max-width: 1100px;
}
.table {
  border-radius: 0.75rem;
  overflow: hidden;
}
</style>
