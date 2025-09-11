<script setup>
import { ref } from "vue";
import { Head, router } from "@inertiajs/vue3";
import AdminLayout from "@/Layouts/AdminLayout.vue";

const props = defineProps({
  item: {
    type: Object,
    default: () => ({}),
  },
});

const reason = ref("");

const deny = () => {
  if (!reason.value.trim()) {
    alert("Please provide a reason before denying the request.");
    return;
  }

  const response = confirm("This action will delete the item. Are you sure you want to proceed?");
  if (!response) return;

  router.delete(route("deny.request", { item: props.item.id }), {
    data: { reason: reason.value }, // send reason to backend
    onSuccess: () => {
      alert("Request denied successfully.");
    },
    onError: (err) => {
      console.error("Error denying request:", err);
    },
  });
};
</script>

<template>
  <Head title="Deny Pending Request" />

  <AdminLayout>
    <div class="deny-container">
        <div class="container py-5 d-flex justify-content-center">
      <div class="card shadow-lg w-100" style="max-width: 700px; border-radius: 1rem;">
        <div class="card-body p-5">
          <!-- Recommendation / Instruction -->
          <div class="mb-4">
            <h3 class="fw-bold text-danger mb-3">Deny Reported Item</h3>
            <p class="text-muted">
              Please provide a clear reason why this reported item request is being denied.
              This will help the user understand the decision and improve the reliability of the system.
            </p>
          </div>

          <!-- Item Preview -->
          <div class="mb-4 p-3 border rounded bg-light">
            <h5 class="mb-1"><strong>Item:</strong> {{ props.item?.title || "Unnamed Item" }}</h5>
            <p class="mb-0"><strong>Description:</strong> {{ props.item?.description || "No description" }}</p>
          </div>

          <!-- Denial Reason -->
          <div class="mb-4">
            <label for="denyReason" class="form-label fw-semibold">Reason for Denial</label>
            <textarea
              id="denyReason"
              class="form-control"
              rows="5"
              v-model="reason"
              placeholder="Write the reason here..."
              style="resize: none; border-radius: 0.75rem;"
            ></textarea>
          </div>

          <!-- Action Buttons -->
          <div class="d-flex justify-content-between">
            <a :href="route('dashboard')" class="btn btn-outline-secondary px-4">
              Cancel
            </a>
            <button @click="deny" class="btn btn-danger px-4">
              Deny Request
            </button>
          </div>
        </div>
      </div>
    </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.card {
  border: none;
}
.btn-danger {
  background: linear-gradient(90deg, #dc3545, #b02a37);
  border: none;
}
.btn-outline-secondary:hover {
  background-color: #f1f1f1;
}
.deny-container {
  height: 100vh;         
  overflow-y: auto;      
  display: flex;         
  justify-content: center;
  align-items: flex-start; 
  padding: 1rem;
}
</style>
