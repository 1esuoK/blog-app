# Stage 1: Build the application with dependencies
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock into the working directory
COPY package.json yarn.lock ./

# Install dependencies using Yarn
RUN yarn install 

# Copy the rest of the application code
COPY . .

# Stage 2: Create a lightweight production image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app .

# Expose the application port (optional)
EXPOSE 3000

# Define the command to run the application
CMD ["yarn", "start"]