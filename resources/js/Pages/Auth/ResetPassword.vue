<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, useForm } from '@inertiajs/vue3';

const props = defineProps({
    email: {
        type: String,
        required: true,
    },
    token: {
        type: String,
        required: true,
    },
});

const form = useForm({
    token: props.token,
    email: props.email,
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('password.store'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<template>
    <Head title="Reset Password" />

    <div class="min-h-screen flex items-center justify-center p-4 bg-gradient-to-br from-indigo-50 via-white to-cyan-50">
        <!-- Main Card -->
        <div class="max-w-md w-full">
            <div class="bg-white rounded-3xl shadow-2xl overflow-hidden backdrop-blur-sm bg-white/95 border border-white/20">
                <!-- Header Section -->
                <div class="bg-gradient-to-r from-purple-500 to-indigo-600 p-8 text-center relative overflow-hidden">
                    <!-- Background Pattern -->
                    <div class="absolute inset-0 opacity-10">
                        <div class="absolute top-4 left-4 w-8 h-8 bg-white rounded-full"></div>
                        <div class="absolute bottom-4 right-4 w-6 h-6 bg-white rounded-full"></div>
                    </div>
                    
                    <div class="relative z-10">
                        <div class="w-16 h-16 bg-white/20 rounded-2xl flex items-center justify-center mx-auto mb-4 backdrop-blur-sm">
                            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                            </svg>
                        </div>
                        <h1 class="text-3xl font-bold text-white mb-2">Reset Password</h1>
                        <p class="text-indigo-100">Create your new secure password</p>
                    </div>
                </div>

                <!-- Form Section -->
                <div class="p-8">
                    <form @submit.prevent="submit" class="space-y-6">
                        <!-- Email Field -->
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
                                    autocomplete="username"
                                    placeholder="your@email.com"
                                />
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                    </svg>
                                </div>
                            </div>
                            <InputError class="text-sm mt-1" :message="form.errors.email" />
                        </div>

                        <!-- Password Field -->
                        <div class="space-y-2">
                            <InputLabel 
                                for="password" 
                                value="New Password" 
                                class="text-gray-700 font-medium"
                            />
                            <div class="relative">
                                <TextInput
                                    id="password"
                                    type="password"
                                    class="block w-full pl-11 pr-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all duration-200"
                                    :class="form.errors.password ? 'border-red-300' : 'hover:border-gray-300'"
                                    v-model="form.password"
                                    required
                                    autocomplete="new-password"
                                    placeholder="Enter new password"
                                />
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                                    </svg>
                                </div>
                            </div>
                            <InputError class="text-sm mt-1" :message="form.errors.password" />
                        </div>

                        <!-- Confirm Password Field -->
                        <div class="space-y-2">
                            <InputLabel 
                                for="password_confirmation" 
                                value="Confirm New Password" 
                                class="text-gray-700 font-medium"
                            />
                            <div class="relative">
                                <TextInput
                                    id="password_confirmation"
                                    type="password"
                                    class="block w-full pl-11 pr-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all duration-200"
                                    :class="form.errors.password_confirmation ? 'border-red-300' : 'hover:border-gray-300'"
                                    v-model="form.password_confirmation"
                                    required
                                    autocomplete="new-password"
                                    placeholder="Confirm your password"
                                />
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                                    </svg>
                                </div>
                            </div>
                            <InputError class="text-sm mt-1" :message="form.errors.password_confirmation" />
                        </div>

                        <!-- Password Requirements -->
                        <div class="bg-blue-50 border border-blue-200 rounded-xl p-4">
                            <h4 class="text-sm font-semibold text-blue-800 mb-2 flex items-center">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                Password Requirements
                            </h4>
                            <ul class="text-xs text-blue-700 space-y-1">
                                <li class="flex items-center">
                                    <svg class="w-3 h-3 mr-2 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                    </svg>
                                    At least 8 characters long
                                </li>
                                <li class="flex items-center">
                                    <svg class="w-3 h-3 mr-2 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                    </svg>
                                    Include uppercase and lowercase letters
                                </li>
                                <li class="flex items-center">
                                    <svg class="w-3 h-3 mr-2 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                    </svg>
                                    Include numbers and special characters
                                </li>
                            </ul>
                        </div>

                        <!-- Submit Button -->
                        <div class="pt-4">
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
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                                    </svg>
                                    <span>{{ form.processing ? 'Resetting...' : 'Reset Password' }}</span>
                                </span>
                            </PrimaryButton>
                        </div>

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
                    </form>
                </div>
            </div>

            <!-- Security Note -->
           
        </div>
    </div>
</template>

<style scoped>
.backdrop-blur-sm {
    backdrop-filter: blur(8px);
}

.bg-white\/95 {
    background-color: rgba(255, 255, 255, 0.95);
}

.border-white\/20 {
    border-color: rgba(255, 255, 255, 0.2);
}

.animate-spin {
    animation: spin 1s linear infinite;
}

@keyframes spin {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
}
</style>