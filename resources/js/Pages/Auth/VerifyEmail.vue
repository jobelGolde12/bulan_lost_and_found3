<script setup>
import { computed } from 'vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const props = defineProps({
    status: {
        type: String,
    },
});

const form = useForm({});

const submit = () => {
    form.post(route('verification.send'));
};

const verificationLinkSent = computed(
    () => props.status === 'verification-link-sent',
);
</script>

<template>
    <GuestLayout>
        <Head title="Email Verification" />

        <div class="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-slate-50 to-slate-100">
            <div class="max-w-md w-full">
                <!-- Header -->
                <div class="text-center mb-8">
                    <div class="w-16 h-16 bg-gradient-to-r from-blue-500 to-purple-600 rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
                        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                        </svg>
                    </div>
                    <h1 class="text-3xl font-bold text-gray-900 mb-2">Verify Your Email</h1>
                    <p class="text-gray-600">Let's get you started</p>
                </div>

                <!-- Card -->
                <div class="bg-white rounded-2xl shadow-xl p-8 backdrop-blur-sm bg-white/95">
                    <!-- Main Message -->
                    <div class="text-center mb-6">
                        <p class="text-gray-700 leading-relaxed">
                            Thanks for signing up! Before getting started, could you verify your email address by clicking on the link we just emailed to you?
                        </p>
                    </div>

                    <!-- Success Message -->
                    <div
                        v-if="verificationLinkSent"
                        class="mb-6 p-4 bg-green-50 border border-green-200 rounded-xl flex items-center space-x-3 animate-fade-in"
                    >
                        <div class="w-6 h-6 bg-green-500 rounded-full flex items-center justify-center flex-shrink-0">
                            <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                        </div>
                        <p class="text-green-700 text-sm font-medium">
                            A new verification link has been sent to your email.
                        </p>
                    </div>

                    <!-- Action Section -->
                    <div class="space-y-6">
                        <form @submit.prevent="submit">
                            <PrimaryButton
                                class="w-full justify-center py-3 px-6 rounded-xl font-semibold shadow-lg hover:shadow-xl transition-all duration-200 transform hover:-translate-y-0.5"
                                :class="[{ 'opacity-25': form.processing }, form.processing ? 'cursor-not-allowed' : 'hover:shadow-blue-500/25']"
                                :disabled="form.processing"
                            >
                                <span class="flex items-center justify-center space-x-2">
                                    <svg v-if="form.processing" class="w-4 h-4 animate-spin" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 2v4m0 12v4m8-10h-4M6 12H2"/>
                                    </svg>
                                    <span>{{ form.processing ? 'Sending...' : 'Resend Verification Email' }}</span>
                                </span>
                            </PrimaryButton>
                        </form>

                        <!-- Divider -->
                        <div class="relative">
                            <div class="absolute inset-0 flex items-center">
                                <div class="w-full border-t border-gray-200"></div>
                            </div>
                            <div class="relative flex justify-center text-sm">
                                <span class="px-2 bg-white text-gray-500">or</span>
                            </div>
                        </div>

                        <!-- Logout -->
                        <div class="text-center">
                            <Link
                                :href="route('logout')"
                                method="post"
                                as="button"
                                class="text-gray-600 hover:text-gray-900 font-medium transition-colors duration-200 flex items-center justify-center space-x-2 mx-auto group"
                            >
                                <span>Log Out</span>
                                <svg class="w-4 h-4 transform group-hover:translate-x-0.5 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7"/>
                                </svg>
                            </Link>
                        </div>
                    </div>
                </div>

                <!-- Help Text -->
                <div class="text-center mt-6">
                    <p class="text-sm text-gray-500">
                        Didn't receive the email? Check your spam folder or contact support.
                    </p>
                </div>
            </div>
        </div>
    </GuestLayout>
</template>

<style scoped>
.animate-fade-in {
    animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.backdrop-blur-sm {
    backdrop-filter: blur(8px);
}

.bg-white\/95 {
    background-color: rgba(255, 255, 255, 0.95);
}
</style>