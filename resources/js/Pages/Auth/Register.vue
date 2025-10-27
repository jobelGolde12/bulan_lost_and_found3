<script setup>
import { ref } from "vue";
import InputError from "@/Components/InputError.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { Head, Link, useForm, router } from "@inertiajs/vue3";

const form = useForm({
  name: "",
  email: "",
  password: "",
  password_confirmation: "",
  contact: "",
});

const firstName = ref("");
const middleInitial = ref("");
const lastName = ref("");

const submit = () => {
  if (form.contact.length < 11) {
    alert("Contact number must be at least 11 digits.");
    return;
  }

  // Combine name fields before submit
  form.name =
    `${firstName.value} ${middleInitial.value ? middleInitial.value + "." : ""} ${lastName.value}`
      .trim()
      .replace(/\s+/g, " ");

  form.post(route("register"), {
    onFinish: () => form.reset("password", "password_confirmation"),
    onSuccess: () => {
      router.visit(route("verification.notice"));
    },
  });
};

// Toggle password visibility
const showPassword = ref(false);
const showConfirmPassword = ref(false);

const togglePassword = () => {
  showPassword.value = !showPassword.value;
};
const toggleConfirmPassword = () => {
  showConfirmPassword.value = !showConfirmPassword.value;
};
const agreeInTermsAndPolicy = ref(false);
</script>

<style scoped>
* {
  font-family: "Poppins", sans-serif;
}

.main-container {
  position: absolute;
  width: 100vw;
  height: 100vh;
  overflow-x: hidden;
  overflow-y:scroll;
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
  top: 50%;
  right: 10px;
  transform: translateY(0%);
  cursor: pointer;
}
.terms-text{
  transform: translateY(35%);
}

@media (min-width: 768px) {
  .main-container {
    flex-direction: row;
  }
  .form {
    width: 50%;
  }
}
</style>

<template>
  <Head title="Register" />
  <div class="main-container bg-light">
    <form @submit.prevent="submit" class="form">
      <h2 class="text-dark text-center fw-semibold mt-5">Register now!</h2>

      <div>
  <InputLabel value="Name" />

  <div class="row">
    <div class="col-5">
      <TextInput
        type="text"
        class="mt-1 block w-full"
        v-model="firstName"
        required
        placeholder="First Name"
        style="border-radius: 10px"
      />
    </div>

    <div class="col-2">
      <TextInput
        type="text"
        class="mt-1 block w-full text-center"
        v-model="middleInitial"
        maxlength="1"
        placeholder="M"
        style="border-radius: 10px"
      />
    </div>

    <div class="col-5">
      <TextInput
        type="text"
        class="mt-1 block w-full"
        v-model="lastName"
        required
        placeholder="Last Name"
        style="border-radius: 10px"
      />
    </div>
  </div>

  <InputError class="mt-2" :message="form.errors.name" />
</div>


      <div class="mt-4">
        <InputLabel for="email" value="Email" />
        <TextInput
          id="email"
          type="email"
          class="mt-1 block w-full"
          v-model="form.email"
          required
          autocomplete="username"
          style="border-radius: 10px"
          placeholder="you@example.com"
        />
        <InputError class="mt-2" :message="form.errors.email" />
      </div>

      <div class="mt-3">
        <InputLabel for="contact" value="Contact" />
        <TextInput
          id="contact"
          type="text"
          class="mt-1 block w-full"
          v-model="form.contact"
          required
          autofocus
          style="border-radius: 10px"
          placeholder="09460162987"
        />
      </div>

      <div class="mt-4 password-wrapper">
        <InputLabel for="password" value="Create Password" />
        <TextInput
          id="password"
          :type="showPassword ? 'text' : 'password'"
          class="mt-1 block w-full"
          v-model="form.password"
          required
          autocomplete="new-password"
          style="border-radius: 10px"
          placeholder="8 letters and long"
        />
        <i
          :class="showPassword ? 'bi bi-eye-slash' : 'bi bi-eye'"
          class="eye-icon"
          @click="togglePassword"
        ></i>
        <InputError class="mt-2" :message="form.errors.password" />
      </div>

      <div class="mt-4 password-wrapper">
        <InputLabel for="password_confirmation" value="Confirm Password" />
        <TextInput
          id="password_confirmation"
          :type="showConfirmPassword ? 'text' : 'password'"
          class="mt-1 block w-full"
          v-model="form.password_confirmation"
          required
          autocomplete="new-password"
          style="border-radius: 10px"
          placeholder="8 letters and long"
        />
        <i
          :class="showConfirmPassword ? 'bi bi-eye-slash' : 'bi bi-eye'"
          class="eye-icon"
          @click="toggleConfirmPassword"
        ></i>
        <InputError class="mt-2" :message="form.errors.password_confirmation" />
      </div>

      <div
        class="mt-4 d-flex flex-row gap-2 align-items-center justify-content-start"
      >
        <input type="checkbox" v-model="agreeInTermsAndPolicy" />
        <div>
          <p class="terms-text">
            I agree to the
            <Link :href="route('view.privacy')" class="text-dark text-underline ">terms and policy</Link>
          </p>
        </div>
      </div>

      <div class="mt-4 d-flex flex-column align-items-center">
        <button
          class="bg-dark text-light w-100 rounded text-center py-2"
          :class="{ 'opacity-25': form.processing || !agreeInTermsAndPolicy }"
          :disabled="form.processing || !agreeInTermsAndPolicy"
        >
          Register
        </button>
        <div class="mt-4">
          Already registered?
          <Link :href="route('login')" class="text-primary"> signin </Link>
        </div>
      </div>
    </form>
  </div>
</template>
