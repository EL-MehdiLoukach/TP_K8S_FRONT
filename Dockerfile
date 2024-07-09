# Use the official Node.js image as the base image
FROM node:16 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the React application
RUN npm run build

# Use a lightweight web server to serve the React application
FROM nginx:alpine

# Copy the built React application to the nginx directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port that nginx will use
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
