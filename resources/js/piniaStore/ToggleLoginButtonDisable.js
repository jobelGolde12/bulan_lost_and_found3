import { defineStore } from "pinia";

export const toggleLoginButton = defineStore('change', {
    state: () => ({
        attemptError: false
    }),
    actions: {
        toggleButtonValue(){
            return this.attemptError = !this.attemptError;
        }
    }
})