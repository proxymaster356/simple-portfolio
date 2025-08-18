# Use nginx as base image for serving static files
FROM nginx:alpine

# Set maintainer
LABEL maintainer="Debopam Dutta <debopamdutta99@gmail.com>"
LABEL description="Debopam Dutta's Portfolio Website"

# Copy website files to nginx html directory
COPY . /usr/share/nginx/html/

# Copy custom nginx configuration
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]