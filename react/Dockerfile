# Stage 1: Build the React application
FROM node:alpine AS build

WORKDIR /usr/src/app

COPY . .

RUN npm install

RUN npm run build

# Stage 2: Create a lightweight production image
FROM node:alpine AS production

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/package*.json ./
COPY --from=build /usr/src/app/node_modules ./node_modules

# Create 'build' directory if it doesn't exist
RUN mkdir -p ./build

# Copy build artifacts
COPY --from=build /usr/src/app/dist ./build

EXPOSE 5173

CMD ["npm", "start"]
