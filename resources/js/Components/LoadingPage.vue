<template>
    <div class="d-flex bg-dark items-center justify-center h-screen bg-gray-100">
        <div class="text-center">
            <i class="bi bi-arrow-repeat animate-spin text-4xl text-blue-500"></i>
            <p class="mt-2 text-lg text-gray-700">Loading...</p>
        </div>
    </div>
</template>

<style>
@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
.animate-spin {
    animation: spin 1s linear infinite;
}
</style>
