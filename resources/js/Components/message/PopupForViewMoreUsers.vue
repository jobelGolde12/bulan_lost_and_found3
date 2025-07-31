<script setup>
import { defineProps, ref, watch, defineExpose } from "vue";
import { router } from "@inertiajs/vue3";

const props = defineProps({
    show: Boolean,
    id: Number,
    position: Object,
    isBlocked: Boolean,
});

const isShow = ref(false);
const root = ref(null);
const getId = ref(0);
const isBlockedValue = ref(false)
watch(
    () => props.show,
    (val) => {
        isShow.value = val;
    },
    { immediate: true }
);
watch(
    () => props.id,
    (data) => {
        getId.value = data;
    },
    { immediate: true }
);
watch(
    () => props.isBlocked,
    (data) => {
        isBlockedValue.value = data;
    },
    { immediate: true }
);
defineExpose({ root });

const block = () => {
    isShow.value = false;
    router.post(
        route("message.block" , { id: getId.value }),
        {},
        {
            onError: () => alert("Something went wrong, please try again."),
            onSuccess: () => {
                router.visit(route("viewMoreUsers.index", {id: getId.value}));
            },
        }
    );
};
const unBlock = () => {
    isShow.value = false;
    router.delete(
        route("viewMoreUsers.unBlock" , { id: getId.value }),
        {},
        {
            onError: () => alert("Something went wrong, please try again."),
            onSuccess: () => {
                router.visit(route("viewMoreUsers.index", {id: getId.value}));
            },
        }
    );
}
const message = () => {
    router.visit(route("message.viewChat", { id: getId.value })); // Need pa id
};
</script>

<template>
    <div ref="root">
        <div
            v-if="isShow"
            class="action-container"
            :style="{ top: `${position.top}px`, left: `${position.left}px` }"
        >
            <div class="list">
              <!-- kapag diri naka block  -->
                <button
                    type="button"
                    class="d-flex align-items-center gap-2 w-100"
                    @click="block"
                    v-if="!isBlockedValue"
                >
                    <i class="bi bi-ban"></i> Block
                </button>

                <!-- Kapag naka block  -->
                 <button
                    type="button"
                    class="d-flex align-items-center gap-2 w-100"
                    @click="unBlock"
                    v-if="isBlockedValue"
                >
                    <i class="bi bi-circle"></i> Unblock
                </button>

                <button
                    type="button"
                    class="d-flex align-items-center gap-2 w-100 mt-2"
                    @click="message"
                    v-if="!isBlockedValue"
                >
                    <i class="bi bi-chat-dots"></i> Message
                </button>
            </div>
        </div>
    </div>
</template>

<style scoped>
.action-container {
    position: absolute;
    background: #f5f5f5;
    padding: 0.5rem;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(211, 207, 207, 0.1);
    z-index: 1000;
    width: 15%;
    right: 3%;
    top: 5%;
}
.action-container .list button:hover {
    background: #f0ecec;
}
@media screen and (max-width: 756px) {
    .action-container {
        right: 10%;
        top: 5%;
        width: 30%;
    }
}
</style>
