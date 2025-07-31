
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    plugins: [
        laravel({
            input: 'resources/js/app.js',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    // server: {
    //     host: '0.0.0.0',   Accept connections from network
    //     port: 5173,        Or any port you prefer
    //     strictPort: true,  Avoid fallback to random port
    //     hmr: {
    //         host: '192.168.1.3',
    //     }
    // },
});
