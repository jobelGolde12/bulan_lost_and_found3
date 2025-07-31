<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, useForm } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<style scoped>
.main-container{
    width: 100vw;
    height: 100vh;
}
</style>
<template>
        <Head title="Forgot Password" />

        <div
            class="main-container d-flex justify-content-center align-items-center"
            style="background: linear-gradient(0deg, #f3d9fb, #d0f5ee); padding: 1rem; border-radius: 0 0 12px 12px;"
        >
            <div class="row align-items-center px-4">
                <!-- Left Side Image -->
                <div class="col-md-6 text-center mb-4 mb-md-0">
                    <img
                        src="../../../images/forgot-password.svg"
                        alt="Forgot Password"
                        class="img-fluid"
                        style="max-height: 300px;"
                    />
                </div>

                <!-- Right Side Form -->
                <div class="col-md-6">
                    <div class="mb-4 text-sm text-gray-600">
                        Forgot your password? No problem. Just let us know your email
                        address and we will email you a password reset link that will allow
                        you to choose a new one.
                    </div>

                    <div
                        v-if="status"
                        class="mb-4 text-sm font-medium text-green-600"
                    >
                        {{ status }}
                    </div>

                    <form @submit.prevent="submit">
                        <div class="mb-3">
                            <InputLabel for="email" value="Email" />

                            <TextInput
                                id="email"
                                type="email"
                                class="mt-1 block w-full"
                                v-model="form.email"
                                required
                                autofocus
                                autocomplete="username"
                            />

                            <InputError class="mt-2" :message="form.errors.email" />
                        </div>

                        <div class="d-flex justify-content-end">
                            <PrimaryButton
                                :class="{ 'opacity-25': form.processing }"
                                :disabled="form.processing"
                            >
                                Email Password Reset Link
                            </PrimaryButton>
                        </div>
                    </form>
                </div>
            </div>
        </div>
</template>
