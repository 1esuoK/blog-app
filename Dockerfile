# Use the official Node.js 18 Alpine image as the build stage
FROM node:18-alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy only the package.json and yarn.lock to leverage Docker's cache for dependencies
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code to the container
COPY . .

# Install nodemon globally for development convenience
RUN yarn global add nodemon

# Start a new stage from the same Node.js base image
FROM node:18-alpine

# Set the working directory in the final image
WORKDIR /app

# Copy the built application from the build stage
COPY --from=build /app .

# Install nodemon globally in the final stage for hot-reloading
RUN yarn global add nodemon

# Expose the application port
EXPOSE 4000

# Run the application using nodemon, with the entry file specified
CMD ["nodemon", "api/index.js"]