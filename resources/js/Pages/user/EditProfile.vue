<script setup>
import { useForm, Head } from "@inertiajs/vue3";
import UploadImage from "@/Components/UploadImage.vue";
import UserSettingsLayout from "@/Layouts/UserSettingsLayout.vue";
import { defineProps, ref } from "vue";

const props = defineProps({
  user: {
    type: Object,
    default: () => ({}),
  },
  info: {
    type: Object,
    default: () => ({}),
  },
});
const form = useForm({
  profile_pic: null, // Holds the new file if selected
  address: props.info?.address || "",
  bio: props.info?.bio || "",
  contact: props.info?.contact || "",
  facebook_links: props.info?.facebook_links || "",
});

const imagePreview = ref(props.info?.profile_pic || ""); // Holds the current image URL for display

const handleFileSelected = (file) => {
  form.profile_pic = file;
  const reader = new FileReader();
  reader.onload = (e) => {
    imagePreview.value = e.target.result; // Update the image preview
  };
  reader.readAsDataURL(file);
};

const submit = () => {
  const dataToSubmit = { ...form };

  // Only include profile_pic in data if a new file is selected
  if (!form.profile_pic) {
    delete dataToSubmit.profile_pic;
  }

  form.post(route("user.update.post", { id: props.user.id }), {
    data: dataToSubmit,
    forceFormData: true,
    onSuccess: () => alert("Profile updated successfully!"),
    onError: (errors) => console.error("An error occurred:", errors),
  });
};
</script>

<template>
  <UserSettingsLayout>
    <Head title="Edit profile" />
    <div class="container container-top">
      <div>
        <h1 class="text-center fw-lighter">Edit Profile</h1>
      </div>
      <form
        @submit.prevent="submit"
        class="form mx-auto bg-white p-6 rounded-lg shadow-md w-full max-w-2xl"
        enctype="multipart/form-data"
      >
        <!-- UploadImage emits the selected file -->
        <UploadImage @file-selected="handleFileSelected" />

        <div class="mb-4">
          <label for="bio" class="block text-lg font-medium text-gray-700">Bio</label>
          <textarea
            v-model="form.bio"
            id="bio"
            class="mt-1 block w-full px-4 py-3 border rounded-lg shadow-sm focus:ring focus:ring-blue-300"
            placeholder="Tell something about yourself"
          ></textarea>
        </div>

        <div class="mb-4">
          <label for="address" class="block text-lg font-medium text-gray-700">Address</label>
          <input
            v-model="form.address"
            id="address"
            class="mt-1 block w-full px-4 py-3 border rounded-lg shadow-sm focus:ring focus:ring-blue-300"
            placeholder="ex: Bonga, Bulan, Sorsogon"
          />
        </div>

        <div class="mb-4">
          <label for="contact" class="block text-lg font-medium text-gray-700">Contact</label>
          <input
            v-model="form.contact"
            id="contact"
            type="text"
            class="mt-1 block w-full px-4 py-3 border rounded-lg shadow-sm focus:ring focus:ring-blue-300"
            placeholder="ex: 09460163977"
          />
        </div>

        <div class="mb-4">
          <label for="facebook_link" class="block text-lg font-medium text-gray-700">Social Links (optional)</label>
          <input
            type="text"
            v-model="form.facebook_links"
            id="facebook_link"
            class="mt-1 block w-full px-4 py-3 border rounded-lg shadow-sm focus:ring focus:ring-blue-300"
            placeholder="facebook/twitter/instagram/etc."
          />
        </div>

        <button type="submit" class="btn btn-dark w-100">Save Changes</button>
      </form>
    </div>
  </UserSettingsLayout>
</template>

<style scoped>
.container-top {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  overflow-y: scroll;
  overflow-x: hidden;
}

.form input,
.form textarea {
  border: 1px solid rgba(0, 0, 0, 0.2);
  transition: all 0.3s ease-in-out;
}

.form input:focus,
.form textarea:focus {
  outline: none;
  border-color: #3b82f6;
  box-shadow: 0 0 5px rgba(59, 130, 246, 0.5);
}
</style>
