import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    include: ["test/**/*.test.{ts,tsx,js,jsx}"],
    environment: "happy-dom",
    globals: true,
  },
});
