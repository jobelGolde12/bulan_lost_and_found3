<script setup>
import { defineProps, watch, ref } from 'vue';
import { router } from '@inertiajs/vue3';
const props = defineProps({
    data: {
        type: Object,
        default: () => ({})
    }
})

let getTrashed = ref([]);
watch(
    () => props.data,
    (newItem) => {
        getTrashed.value = Array.isArray(newItem) ? newItem : [];
    },
    { immediate: true }
)
const formatDate = (dateString) => {
    const options = { year: "numeric", month: "long", day: "numeric" };
    return new Date(dateString).toLocaleDateString(undefined, options);
};
const restoreFunc = (getId) => {
    router.put(route('notificationTrashed.restore', {id: getId}),
    {},
     {
        onSuccess: () => alert('Notification restored.'),
        onError: (e) => console.log("An error occured while restoring data: ", e)
    })
}
const deleteFunc = (getId) => {
   if(confirm('This action can delete the notification permanently, are you sure you want to proceed?')){
     router.delete(route('notificationTrashed.delete', {id: getId}), 
        {},
        {
            onSuccess: alert('Notification deleted.'),
            onError: () => alert("An error while deleting notification, please try again")
        }
    )
   }
}
</script>

<template>
  <div>
        <table class="table table-bordered table-striped mt-5 table-responsive" v-if="getTrashed.length > 0">
                    <thead class="">
                        <tr>
                            <th><small>User ID</small></th>
                            <th>Title</th>
                            <th>Content</th>
                            <th>Created At</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in getTrashed" :key="item.id">
                            <td>{{ item.user_id }}</td>
                            <td>{{ item.title }}</td>
                            <td>{{ item.message }}</td>
                            <td>{{ formatDate(item.created_at) }}</td>
                            <td class="d-flex align-items-center gap-2">
                                <button class="btn btn-secondary" @click="restoreFunc(item.id)">Restore</button>
                                <button class="btn btn-warning" @click="deleteFunc(item.id)">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="container text-center text-muted" v-else>
                    <p>No notification trashed found.</p>
                </div>
  </div>
</template>



<style scoped>

</style>