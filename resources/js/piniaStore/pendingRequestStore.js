import { defineStore } from "pinia";

export const usePendingRequestStore = defineStore("pendingRequest", {
  state: () => ({
    count: 0, // global count of pending requests
  }),

  actions: {
    setCount(value) {
      this.count = Number(value) || 0;
    },

    increment() {
      this.count++;
    },

    decrement() {
      if (this.count > 0) this.count--;
    },
  },
});
