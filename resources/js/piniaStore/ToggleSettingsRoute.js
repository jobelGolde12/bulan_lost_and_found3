import { defineStore } from "pinia";
import { usePage } from "@inertiajs/inertia-vue3";
const role = usePage().auth?.user.role;
export const toggleRoute = defineStore('routeChange', {
    state: () => ({
        text: (role == 'admin') ? 'Item' : 'Announcement'
    }),
    actions: {
        updateText(newText){
            this.text = newText;
        }
    }
})