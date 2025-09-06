import './bootstrap';
import '../css/app.css';

import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { createApp, h, ref } from 'vue';
import { ZiggyVue } from '../../vendor/tightenco/ziggy';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import 'bootstrap';
import LoadingPage from '@/Components/LoadingPage.vue';
import axios from 'axios';

import { createPinia } from 'pinia';

const appName = import.meta.env.VITE_APP_NAME || 'Laravel';

//  Create a single axios instance with CSRF included
window.axios = axios;
window.axios.defaults.withCredentials = true;
window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

const token = document.head.querySelector('meta[name="csrf-token"]');
// if (token) {
//     window.axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content;
// } else {
//     console.error(
//         'CSRF token not found: please add <meta name="csrf-token" content="{{ csrf_token() }}"> in your HTML head.'
//     );
// }

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) =>
        resolvePageComponent(
            `./Pages/${name}.vue`,
            import.meta.glob('./Pages/**/*.vue'),
        ),
    setup({ el, App, props, plugin }) {
        const isLoading = ref(true);

        const pinia = createPinia();

        return createApp({
            render: () => (isLoading.value ? h(LoadingPage) : h(App, props)),
            mounted() {
                isLoading.value = false;
            },
        })
            .use(plugin)
            .use(pinia)       
            .use(ZiggyVue)
            .mount(el);
    },
    progress: {
        color: '#4B5563',
    },
});


// ====< Old code (in case na magka error) >====
// import './bootstrap';
// import '../css/app.css';

// import { createInertiaApp } from '@inertiajs/vue3';
// import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
// import { createApp, h, ref } from 'vue';
// import { ZiggyVue } from '../../vendor/tightenco/ziggy';
// import 'bootstrap/dist/css/bootstrap.min.css';
// import 'bootstrap/dist/js/bootstrap.bundle.min.js';
// import axios from 'axios';
// import 'bootstrap';
// import LoadingPage from '@/Components/LoadingPage.vue';

// import { createPinia } from 'pinia';


// Get CSRF token from meta tag
// const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

// // Set Axios defaults
// axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken;
// axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';


// const appName = import.meta.env.VITE_APP_NAME || 'Laravel';

// createInertiaApp({
//     title: (title) => `${title} - ${appName}`,
//     resolve: (name) =>
//         resolvePageComponent(
//             `./Pages/${name}.vue`,
//             import.meta.glob('./Pages/**/*.vue'),
//         ),
//     setup({ el, App, props, plugin }) {
//         const isLoading = ref(true);

//         const pinia = createPinia();

//         return createApp({
//             render: () => (isLoading.value ? h(LoadingPage) : h(App, props)),
//             mounted() {
//                 isLoading.value = false;
//             },
//         })
//             .use(plugin)
//             .use(pinia)       
//             .use(ZiggyVue)
//             .mount(el);
//     },
//     progress: {
//         color: '#4B5563',
//     },
// });
