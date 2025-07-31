<script setup>
import { computed, onMounted, watch } from "vue";
import { Link, router } from "@inertiajs/vue3";
import { ref } from "vue";

const props = defineProps({
    items: {
        type: Array,
        default: [],
    }
});
const itemContainer = ref([]);

watch(
    () => props.items,
    (newItem) => {
        itemContainer.value = newItem;
    },
    { immediate: true }
);
const viewLaterFunc = (id) => {
    router.post(route("viewLater.add", { id: id }), {},
   {
    onSuccess: () => {
      window.location.reload();
    }
  }
  );
};


const formatDate = (dateString) => {
    const options = { year: "numeric", month: "long", day: "numeric" };
    return new Date(dateString).toLocaleDateString(undefined, options);
};

//add a limit text sa character description
const truncateText = (text, maxLength = 20) => {
    if (!text) return "";
    return text.length > maxLength ? text.slice(0, maxLength) + "..." : text;
};

</script>

<template>
    <div
        class="card-container container-fluid d-flex flex-row flex-wrap mt-4 gap-3 justify-content-center"
        v-if="itemContainer"
    >
        <div class="card bg-light" v-for="data in itemContainer" :key="data.id">
            <Link
                :href="route('viewItemInfoAsAdmin', { item: data?.id })"
                class="text-decoration-none"
            >
                <div class="image-container">
                    <img
                        :src="data.image_url"
                        class="card-img-top"
                        alt="Item image"
                        v-if="data.image_url"
                    />
                  <p class="text-light">{{ formatDate(data?.created_at) }}</p>
                  <!-- Kapag in hover ma show ang date  -->
                </div>
            </Link>
            <div class="card-body">
                <div class="d-flex flex-column gap-0 m-0 p-0">
                    <h5 class="card-title text-dark mb-0 fw-bolder">
                        {{ data.title }}
                    </h5>
                    <p class="card-text text-muted m-0" :title="data.description">
                        {{ truncateText(data.description, 25) }}
                    </p>
                    <p class="text-success m-0">
                        {{ data.category || "null" }}
                    </p>
                </div>

                <div
                    class="container-fluid bottom d-flex flex-row justify-content-between align-items-center px-0"
                >
                    <div class="left">
                        <Link
                            :href="route('viewUserAsAdmin', {id: data.user?.id})"
                            class="ps-0 d-flex flex-row gap-2 align-items-center text-decoration-none"
                        >
                            <div>
                                <img
                                    :src="data.user?.user_info?.profile_pic == null ? '../../images/profile.jpeg' : `/storage/${data.user?.user_info?.profile_pic}`"
                                    alt="profile"
                                    class="default-profile"
                                />
                            </div>
                            <div class="owner_name text-dark">
                                {{ data.user?.name || "user" }}
                            </div>
                        </Link>
                    </div>

                    <div class="right">
                        <i
                          class="btn btn-light bi"
                          :class="data.view_later.some(v => v.item_id === data.id) ? 'bi-bookmark-fill' : 'bi-bookmark'"
                          title="View later"
                          @click="viewLaterFunc(data.id)"
                        ></i>

                    </div>
                </div>
            </div>
        </div>
        <div class="container text-center" v-if="itemContainer.length === 0">
            No Item.
        </div>
        <!-- Para may extra space sa baba -->
        <div class="container-bottom mt-5"></div>
    </div>
</template>

<style scoped>
.card-container {
    position: relative;
    width: 100%;
    height: 100vh;
    overflow-y: scroll;
    overflow-x: hidden;
    padding-bottom: 2rem;
}

.card {
    border-radius: 8px;
    max-width: 18rem;
    width: 100%;
    min-height: 300px;
    padding: 15px;
    background-color: white;
    cursor: pointer;
    /* box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s, box-shadow 0.2s; */
    border: none;
}
.card .card-body .bottom {
    position: relative;
    bottom: 0;
}
/* .card:hover {
  transform: scale(1.03);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
  background: rgba(200, 195, 195, 0.1);
} */

.image-container {
    width: 100%;
    height: 200px;
    overflow: hidden;
    border-radius: 8px;
    overflow: hidden;
    position: relative;
}

.image-container .card-img-top {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: top;
    transition: 0.5s;
    z-index: 1;
}
.image-container p {
    position: absolute;
    z-index: 3;
    display: none;
    background: rgba(90, 88, 88, 0.6);
    padding: 0.5rem;
    bottom: -9%;
    right: 0;
    text-align: center;
    font-size: .8rem;
    border-radius: 5px 0 0 5px;
}

.image-container .card-img-top:hover {
    transform: scale(1.1);
    filter: brightness(0.8);
}
.image-container:hover p{
    display: block;
}
.card-body {
    padding: 10px 0;
}

.container-bottom {
    width: 100%;
    height: 200px;
}
.default-profile {
    width: 30px;
    height: 30px;
    border-radius: 50%;
}
@media (max-width: 768px) {
    .card {
        max-width: 100%;
    }
}
</style>
