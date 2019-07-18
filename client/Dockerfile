#Multi-stage build
FROM node:alpine as builder 
# Project will live in /app
WORKDIR  '/app'
# Copy Package.json
COPY ./package.json ./
# Install dependencies
RUN npm install
# Copy everything in root to container
COPY . .
# Run the production build script in React
RUN npm run build
# Multi-Container Step install nginx for routing
FROM nginx
# Expose the port 3000 (ReactJS)
EXPOSE 3000
# Overwrite nginx's default.conf for routing
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
# copy artifacts to nginx
COPY --from=builder /app/build /usr/share/nginx/html