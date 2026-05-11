# 1. Base image
FROM nginx:alpine

# 2. Set working directory
WORKDIR /usr/share/nginx/html

# 3. Remove default nginx static files
RUN rm -rf ./*

# 4. Copy files from the cloned repo
COPY . .

# 5. Expose port
EXPOSE 80

# 6. Start nginx
CMD ["nginx", "-g", "daemon off;"]



