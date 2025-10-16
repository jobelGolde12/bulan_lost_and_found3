<script setup>
import { ref } from "vue";
import Checkbox from "@/Components/Checkbox.vue";
import InputError from "@/Components/InputError.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import { toggleLoginButton } from "@/piniaStore/ToggleLoginButtonDisable";

defineProps({
  canResetPassword: {
    type: Boolean,
  },
  status: {
    type: String,
  },
});

const useToggleButton = toggleLoginButton();
const passwordLegthError = ref(false);
const form = useForm({
  email: "",
  password: "",
  remember: false,
});

// Toggle password visibility
const showPassword = ref(false);
const togglePassword = () => {
  showPassword.value = !showPassword.value;
};
const submit = () => {
  if(form.password.length < 8){
    passwordLegthError.value = true;
    return;
  }
  form.post(route("login"), {
    onFinish: () => form.reset("password"),
  });
};
</script>

<style scoped>
* {
  font-family: "Poppins", sans-serif;
}
.main-container {
  position: absolute;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 20px;
}
.form {
  width: 90%;
  max-width: 500px;
  background: transparent;
  padding: 20px;
  border-radius: 10px;
}
.password-wrapper {
  position: relative;
}
.eye-icon {
  position: absolute;
  top: 70%;
  right: 10px;
  transform: translateY(-50%);
  cursor: pointer;
}
.status {
  position: absolute;
  top: 20px;
  right: 5%;
  max-width: 500px;
  width: 90%;
  text-align: center;
  padding: 10px;
  border-radius: 10px;
  border: 1px solid #38a169;
  background-color: #f0fff4;
}
@media (min-width: 768px) {
  .main-container {
    flex-direction: row;
  }
  .form {
    width: 45%;
  }
}
</style>

<template>
  <div class="main-container bg-light">
    <Head title="Log in" />

    <div v-if="status" class="mb-4 text-sm font-medium text-green-600 status">
      {{ status }}
    </div>

    <form @submit.prevent="submit" class="form">
      <h3 class="text-dark text-center fw-semibold">Login</h3>

      <div>
        <InputLabel for="email" value="Email address" />
        <TextInput
          id="email"
          type="email"
          class="mt-1 block w-full"
          v-model="form.email"
          required
          autofocus
          autocomplete="username"
          style="border-radius: 10px"
          placeholder="you@example.com"
        />
        <InputError class="mt-2" :message="form.errors.email" />
      </div>

      <div class="mt-4 password-wrapper">
        <InputLabel for="password" value="Password" />
        <TextInput
          id="password"
          :type="showPassword ? 'text' : 'password'"
          class="mt-1 block w-full"
          v-model="form.password"
          required
          autocomplete="current-password"
          style="border-radius: 10px"
          placeholder="8 letters and long"
        />
        <i
          :class="showPassword ? 'bi bi-eye-slash' : 'bi bi-eye'"
          class="eye-icon"
          @click="togglePassword"
          :style="form.password.length < 8 && form.password != '' ? { 'transform': 'translateY(-130%)' } : {}"
        ></i>
        <!-- <InputError class="mt-2" :message="form.errors.password" /> -->
         <p v-if="form.password.length < 8 && form.password != ''" class="text-sm text-red-600 mt-2">
           Password must atleast 8 characters long.
        </p>
      </div>

      <div class="mt-4 d-flex flex-column">
        <Link
          v-if="canResetPassword"
          :href="route('password.request')"
          class="rounded-md text-sm text-gray-600 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
        >
          Forgot your password?
        </Link>

        <PrimaryButton
          class="w-100 d-block mt-2"
          :class="{ 'opacity-25': form.processing || useToggleButton.attemptError == true}"
          :disabled="form.processing"
          style="border-radius: 10px"
        >
          Log in
        </PrimaryButton>

        <p class="text-dark fw-light mt-3 text-center">
          Didn't have an account? |
          <Link :href="route('register')"> Signup </Link>
        </p>
      </div>
    </form>
  </div>
</template>
