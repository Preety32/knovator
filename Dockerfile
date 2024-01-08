# Stage 1: Build the Node.js application
FROM node:alpine AS build

WORKDIR /usr/src/app

# Copy package.json and package-lock.json separately to leverage Docker layer caching
COPY package*.json ./

RUN npm install

# Copy the rest of the application source code
COPY . .

# Stage 2: Create a lightweight production image
FROM node:alpine AS production

WORKDIR /usr/src/app

# Copy only necessary files from the build stage
COPY --from=build /usr/src/app/package*.json ./
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist  # Assuming your build artifacts are in a 'dist' folder

EXPOSE 3000

CMD ["npm", "start"]
