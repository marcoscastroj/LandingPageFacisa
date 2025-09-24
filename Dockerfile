# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Copy the static assets to the Nginx html directory
COPY ./index.html /usr/share/nginx/html/
COPY ./css/ /usr/share/nginx/html/css/
COPY ./js/ /usr/share/nginx/html/js/
COPY ./assets/ /usr/share/nginx/html/assets/

# Expose port 80 to the outside world
EXPOSE 80