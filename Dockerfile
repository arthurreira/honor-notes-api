# ---- Production Dockerfile ----
# Based on Alpine for small image size (Prisma supports musl on amd64/arm64)
FROM node:18-alpine

WORKDIR /app

# Copy dependency manifests first (layer caching)
COPY package.json package-lock.json ./
RUN npm ci

# Copy Prisma schema, config, source code, and bootstrap script
COPY prisma ./prisma
COPY prisma.config.ts ./
COPY src ./src
COPY start.sh ./
RUN chmod +x start.sh

# Generate Prisma client inside the container (platform-specific binaries)
# Dummy DATABASE_URL satisfies prisma.config.ts validation — no DB connection needed
RUN DATABASE_URL="postgresql://dummy:dummy@localhost:5432/dummy" npx prisma generate

# Run as non-root for security
USER node

# Healthcheck using wget (curl not available in Alpine)
HEALTHCHECK --interval=30s --timeout=5s \
  CMD wget -qO- http://localhost:3000/ || exit 1

EXPOSE 3000

# Bootstrap: run migrations then start the server
CMD ["sh", "./start.sh"]