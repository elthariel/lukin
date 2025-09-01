import { resolve } from "path"

import { defineConfig } from 'vite'

import Rails from "vite-plugin-rails"

export default defineConfig({
  resolve: {
    alias: {
      // // Define your useful aliases here
      // "@x": resolve(__dirname, "app/javascript/mystuff"),
    }
  },
  plugins: [
    Rails({
      root: __dirname,
      envVars: {
        RAILS_ENV: "development",
        POSTHOG_API_KEY: 'nulltest',
      },
      fullReload: {
        additionalPaths: [
          "config/routes.rb",
          "config/locales/**",
          "app/views/**/*",
          "app/controllers/**/*",
          "tailwind.config.js",
        ],
      },
    })
  ],
  server: {
    allowedHosts: [`chat.${process.env.DOMAIN}`],
    origin: `chat.${process.env.DOMAIN}`,
    hmr: {
      host: `chat.${process.env.DOMAIN}`,
      clientPort: 80,
    },
  }
});
