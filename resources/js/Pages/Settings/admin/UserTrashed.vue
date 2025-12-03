<script setup>
import { usePage, router, Head } from '@inertiajs/vue3';
import { ref, defineProps, watch } from 'vue';
import AdminSettingsLayout from '@/Layouts/settings/AdminSettingsLayout.vue';
import TrashLayout from '@/Layouts/TrashLayout.vue';

const props = defineProps({
  users: {
    type: Object,
    default: () => ({})
  }
})

const trashedUsers = ref([]);
watch(
  () => props.users,
  (newUsers) => {
    trashedUsers.value = Object.values(newUsers);
  },
  {immediate: true}
)

const restoreUser = (getId) => {
    if (confirm("Are you sure you want to restore the user?")) {
        router.put(route('userTrashed.restore' , {id: getId}),
        {},
        {
            onSuccess: () => {
                trashedUsers.value = trashedUsers.value.filter(item => item.id !== id);
                alert('User restored.')
            }
        });
    }
};

const deleteUser = (getId) => {
  if (confirm("Are you sure you want to permanently delete this user?")) {
        router.delete(route('userTrashed.deletePermanently', {id: getId}), {
            onSuccess: () => {
                trashedUsers.value = trashedUsers.value.filter(item => item.id !== id);
                alert('User deleted permanently.')
            }
        });
    }
};

// kapag may 404 i means wara user_info an iba na deleted user
//nag ka error kc dati 
const viewUser = (getId) => {
    router.visit(route('userTrashed.view', {id: getId}));
};
</script>

<template>
  <Head title="Trash" />
  <AdminSettingsLayout>
    <TrashLayout>
      <div class="container mt-4">
        <div v-if="trashedUsers.length === 0" class="text-center">
          <img src="../../../../images/no-data.svg" alt="No Data" class="w-50 mb-3 no-data-img" />
          <p>No trashed users available.</p>
        </div>

        
        <div v-else>
          <div class="table-responsive">
            <table class="table table-hover align-middle">
              <thead class="table-light">
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Role</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(data) in trashedUsers" :key="data.id">
                  <td>{{ data.name }}</td>
                  <td>{{ data.email }}</td>
                  <td>{{ data.role }}</td>
                  <td>
                    <button @click="viewUser(data.id)" class="btn btn-info btn-sm me-1">View</button>
                    <button @click="restoreUser(data.id)" class="btn btn-primary btn-sm me-1">Restore</button>
                    <button @click="deleteUser(data.id)" class="btn btn-danger btn-sm">Delete</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </TrashLayout>
  </AdminSettingsLayout>
</template>

<style scoped>
.no-data-img{
    width: 300px;
    height: 300px;
    margin: auto;
}
</style>