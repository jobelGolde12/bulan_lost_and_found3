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
    router.put(route('announcementTrashed.restore', {id: getId}),
    {},
     {
        onSuccess: () => alert('Annoucement restored.'),
        onError: (e) => console.log("An error occured while restoring data: ", e)
    })
}
const deleteFunc = (getId) => {
   if(confirm('This action can delete the announcement permanently, are you sure you want to proceed?')){
     router.delete(route('announcementTrashed.delete', {id: getId}), 
        {},
        {
            onSuccess: alert('Announcement deleted.'),
            onError: () => alert("An error while deleting announcement, please try again")
        }
    )
   }
}
</script>

<template>
  <div>
        <table class="table table-bordered table-striped">
                    <thead class="">
                        <tr>
                            <th>User ID</th>
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
                            <td>{{ item.content }}</td>
                            <td>{{ formatDate(item.created_at) }}</td>
                            <td class="d-flex align-items-center gap-2">
                                <button class="btn btn-secondary" @click="restoreFunc(item.id)">Restore</button>
                                <button class="btn btn-warning" @click="deleteFunc(item.id)">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
  </div>
</template>



<style scoped>

</style>