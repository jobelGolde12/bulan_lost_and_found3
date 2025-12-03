<script setup>
import { defineProps } from "vue";
import { Head, Link } from "@inertiajs/vue3";

const props = defineProps({
  requests: {
    type: Array,
    default: () => [],
  },
});
</script>

<template>
  <Head title="Face to Face Verification" />

  <div class="container my-5">
    <h2 class="mb-4 text-center fw-bold">
      <i class="bi bi-hourglass-split text-warning"></i>
      Face to Face Verification Requests
    </h2>
    <p class="text-muted">The admin needs to verify your identity face to face for a reason.</p>

    <div v-if="requests.length > 0" class="row g-4 container ps-0">
      <div
        v-for="req in requests"
        :key="req.id"
        class="col-md-6 col-lg-4"
      >
        <div class="card shadow-sm border-0 h-100 rounded-3">
          <img
            v-if="req.image_url"
            :src="req.image_url"
            class="card-img-top rounded-top"
            alt="Lost/Found Item"
            style="height: 200px; object-fit: cover;"
          />
          <div class="card-body">
            <h5 class="card-title fw-semibold text-primary">
              <i class="bi bi-tag-fill"></i> {{ req.title }}
            </h5>
            <p class="card-text text-muted small">
              <i class="bi bi-geo-alt-fill"></i> {{ req.location }}
            </p>
            <p class="card-text">
              {{ req.description?.substring(0, 80) }}...
            </p>
            <span
              class="badge"
              :class="{
                'bg-warning text-dark': req.pending_status === 'pending',
                'bg-success': req.pending_status === 'approve'
              }"
            >
              <i
                :class="req.pending_status === 'pending' ? 'bi bi-clock' : 'bi bi-check-circle'"
              ></i>
              {{ req.pending_status }} - Need face to face verification
            </span>
          </div>
          <div class="card-footer bg-light d-flex justify-content-between align-items-center">
            <small class="text-muted">
              <i class="bi bi-calendar-event"></i>
              {{ new Date(req.reported_at).toLocaleDateString() }}
            </small>
           
          </div>
        </div>
      </div>
    </div>

    <div v-else class="text-center py-5">
      <i class="bi bi-inbox display-1 text-muted"></i>
      <h5 class="mt-3">No item requests found</h5>
      <p class="text-muted">You haven’t submitted any item requests yet.</p>
    </div>

    <div class=" mt-3">
              <Link :href="route('settings.index')" class="btn btn-dark mt-3">Go back</Link>
    </div>
  </div>
</template>
