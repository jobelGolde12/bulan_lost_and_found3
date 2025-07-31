<script setup>
import { ref, watch } from "vue";
import { Link, useForm, Head } from "@inertiajs/vue3";
import CustomModal from "@/Components/CustomModal.vue";

const props = defineProps({
  item: {
    type: Object,
    default: () => ({}),
  },
  created_by: {
    type: String,
    default: () => "NA",
  },
});
const data = ref({});
const deleteMessage = ref("Are you sure you want to delete this item?");
const response = ref();

watch(
  () => props.item,
  (newItem) => {
    data.value = newItem;
  },
  { immediate: true }
);

const deleteItem = useForm({});

const getResponse = (res) => {
  if (res === "yes") {
    deleteItem.delete(route("trashItem", { id: props.item?.id }), {
      onSuccess: () => {
        alert("Item moved to trash");
        data.value = {}; // Clear data to simulate removal
      },
      onError: (errors) => console.log("Error:", errors),
    });
  }
};
</script>

<template>
  <Head title="View Item Info" />
  <div class="main-container bg-light row">
    <div v-if="Object.keys(data).length > 0" class="left col-12 col-sm-6 col-lg-6">
      <div class="card bg-light">     
        <div class="card-body">
          <div class="image-container">
            <img v-if="data.image_url" :src="data.image_url" alt="Item Image" class="rounded"/>
          </div>
        </div>
      </div>
    </div>

    <div class="right col-12 col-sm-6 col-lg-6">
      <div class="card bg-light">
        <div v-if="Object.keys(data).length > 0">
          <div class="card-body">
            <h1 :class="data.status === 'Lost' ? 'text-danger' : 'text-success'" class="text-center">{{ data.status }}</h1>
            <p class="my-2"><strong>Name: </strong>{{ data.title || "No name provided" }}</p>
            <p><strong>Description:</strong> {{ data.description }}</p>
            <p><strong>Location:</strong> {{ data.location }}</p>
            <p v-if="data.category">
              <strong>Category:</strong> {{ data.category || 'NA' }}
            </p>
            <p v-if="data.owner_phone_number">
              <strong>Contact:</strong> {{ data.owner_phone_number }}
            </p>
            <p class="my-2"><strong>Created by: </strong>{{ props.created_by || "No name provided" }}</p>
            <p>
              <strong>Created at:</strong>
              {{ new Date(data.created_at).toLocaleString() }}
            </p>

            <div class="container px-0 d-flex flex-row gap-2 mt-2">
              <Link :href="route('totalLostItemIndex')" class="btn btn-light">
                <span class="d-block d-lg-none"><i class="bi bi-chevron-left"></i></span>
                <span class="d-none d-lg-inline"><i class="bi bi-chevron-left"></i> Back</span>
              </Link>

              <button class="btn btn-dark">
                Mark As Resolve
              </button>

              <!-- DELETE BUTTON (MOVES TO TRASH) -->
              <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#customModal">
                <span class="d-block d-lg-none"><i class="bi bi-trash"></i></span>
                <span class="d-none d-lg-inline">Delete</span>
              </button>
            </div>
          </div>
        </div>
        <div v-else>
          <p>Loading item details...</p>
        </div>
      </div>
    </div>
  </div>

  <CustomModal ref="deleteModal" :name="deleteMessage" :id="data.id" @response="getResponse" />
</template>

<style scoped>
.main-container {
  width: 100vw;
  height: 100vh;
  overflow: hidden;
}
.image-container {
  overflow: hidden;
  min-width: 150px;
  height: 800px;
}
.image-container img {
  position: relative;
  width: 100%;
  height: 70%;
  transition: 0.5s;
}
.image-container img:hover {
  transform: scale(1.1);
}
.card {
  border: none;
}
@media screen and (max-width: 768px){
 .main-container {
  width: 100vw;
  height: auto;
  overflow-y: scroll;
  padding-left: 1rem;
}
.right{
    transform: translateY(-60%);
}
}
</style>
