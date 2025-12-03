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

<template>
    <Head title="Forgot Password" />

    <div class="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-indigo-50 via-white to-cyan-50">
        <!-- Main Card -->
        <div class="max-w-6xl w-full">
            <div class="bg-white rounded-3xl shadow-2xl overflow-hidden backdrop-blur-sm bg-white/95 border border-white/20">
                <div class="grid grid-cols-1 lg:grid-cols-2">
                    <!-- Left Side - Illustration -->
                    <div class="bg-gradient-to-br from-purple-500 to-indigo-600 p-8 lg:p-12 flex items-center justify-center relative overflow-hidden">
                        <!-- Background Pattern -->
                        <div class="absolute inset-0 opacity-10">
                            <div class="absolute top-10 left-10 w-32 h-32 bg-white rounded-full"></div>
                            <div class="absolute bottom-10 right-10 w-24 h-24 bg-white rounded-full"></div>
                            <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-40 h-40 bg-white rounded-full"></div>
                        </div>
                        
                        <div class="text-center relative z-10">
                            <img
                                src="../../../images/forgot-password.svg"
                                alt="Forgot Password"
                                class="mx-auto mb-6 transform hover:scale-105 transition-transform duration-300"
                                style="max-height: 280px;"
                            />
                            <h2 class="text-2xl font-bold text-white mb-3">Reset Your Password</h2>
                            <p class="text-indigo-100 text-sm max-w-md">
                                Don't worry! Just enter your email and we'll send you a link to reset your password.
                            </p>
                        </div>

                        <!-- Floating Elements -->
                        <div class="absolute top-6 left-6 w-6 h-6 bg-white/20 rounded-full animate-pulse"></div>
                        <div class="absolute bottom-8 right-8 w-4 h-4 bg-white/30 rounded-full animate-bounce"></div>
                    </div>

                    <!-- Right Side - Form -->
                    <div class="p-8 lg:p-12 flex items-center justify-center">
                        <div class="w-full max-w-md">
                            <!-- Header -->
                            <div class="text-center mb-8">
                                <div class="w-14 h-14 bg-gradient-to-r from-purple-500 to-indigo-600 rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
                                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z"/>
                                    </svg>
                                </div>
                                <h1 class="text-3xl font-bold text-gray-900 mb-2">Forgot Password?</h1>
                                <p class="text-gray-600">We'll help you reset it</p>
                            </div>

                            <!-- Status Message -->
                            <div
                                v-if="status"
                                class="mb-6 p-4 bg-green-50 border border-green-200 rounded-xl flex items-center space-x-3 animate-fade-in"
                            >
                                <div class="w-6 h-6 bg-green-500 rounded-full flex items-center justify-center flex-shrink-0">
                                    <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                    </svg>
                                </div>
                                <p class="text-green-700 text-sm font-medium">
                                    {{ status }}
                                </p>
                            </div>

                            <!-- Instructions -->
                            <div class="mb-8 text-center">
                                <p class="text-gray-600 leading-relaxed">
                                    Enter your email address below and we'll send you a password reset link.
                                </p>
                            </div>

                            <!-- Form -->
                            <form @submit.prevent="submit" class="space-y-6">
                                <div class="space-y-2">
                                    <InputLabel 
                                        for="email" 
                                        value="Email Address" 
                                        class="text-gray-700 font-medium"
                                    />

                                    <div class="relative">
                                        <TextInput
                                            id="email"
                                            type="email"
                                            class="block w-full pl-11 pr-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all duration-200"
                                            :class="form.errors.email ? 'border-red-300' : 'hover:border-gray-300'"
                                            v-model="form.email"
                                            required
                                            autofocus
                                            autocomplete="email"
                                            placeholder="Enter your email"
                                        />
                                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                            </svg>
                                        </div>
                                    </div>

                                    <InputError class="text-sm mt-1" :message="form.errors.email" />
                                </div>

                                <div class="space-y-4">
                                    <PrimaryButton
                                        class="w-full justify-center py-4 px-6 rounded-xl font-semibold text-white bg-gradient-to-r from-purple-500 to-indigo-600 hover:from-purple-600 hover:to-indigo-700 shadow-lg hover:shadow-xl transition-all duration-200 transform hover:-translate-y-0.5 focus:ring-2 focus:ring-purple-500 focus:ring-offset-2"
                                        :class="[{ 'opacity-25 cursor-not-allowed': form.processing }, form.processing ? 'scale-95' : '']"
                                        :disabled="form.processing"
                                    >
                                        <span class="flex items-center justify-center space-x-2">
                                            <svg v-if="form.processing" class="w-4 h-4 animate-spin" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 2v4m0 12v4m8-10h-4M6 12H2"/>
                                            </svg>
                                            <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                            </svg>
                                            <span>{{ form.processing ? 'Sending...' : 'Send Reset Link' }}</span>
                                        </span>
                                    </PrimaryButton>

                                    <!-- Back to Login -->
                                    <div class="text-center pt-4">
                                        <a 
                                            :href="route('login')" 
                                            class="text-gray-600 hover:text-purple-600 font-medium transition-colors duration-200 flex items-center justify-center space-x-2 group"
                                        >
                                            <svg class="w-4 h-4 transform group-hover:-translate-x-0.5 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                                            </svg>
                                            <span>Back to Login</span>
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer Note -->
          
        </div>
    </div>
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

.border-white\/20 {
    border-color: rgba(255, 255, 255, 0.2);
}
</style>