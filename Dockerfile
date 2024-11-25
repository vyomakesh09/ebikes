# Base image
FROM oven/bun:1.0.35 as base
WORKDIR /app

# Dependencies
FROM base AS dependencies
COPY package.json ./
RUN bun install

# Development
FROM base AS development
COPY package.json ./
RUN bun install
COPY . ./
CMD ["bun", "run", "dev"]

# Builder
FROM base AS builder
COPY --from=dependencies /app/node_modules ./node_modules
COPY . ./
RUN bun run build

# Production
FROM base AS runner
ENV NODE_ENV=production

# Copy necessary files
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000
CMD ["bun", "server.js"] 