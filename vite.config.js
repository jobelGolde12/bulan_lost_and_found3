import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';
import path from 'path'; // <- make sure to import this

export default defineConfig({
    server: {
    host: '0.0.0.0',
    port: 5173,
    hmr: {
        host: '192.168.1.4',
        },
    },
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
    resolve: {
        alias: {
            '@': path.resolve(__dirname, 'resources/js'),
            '@components': path.resolve(__dirname, 'resources/js/components'),
            '@views': path.resolve(__dirname, 'resources/js/views'),
        },
    },
});
