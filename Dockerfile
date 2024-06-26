# Use Debian as the base image
FROM debian:latest AS build-env

RUN apt-get update
RUN apt-get clean

# Update and install dependencies
RUN apt-get update \
    && apt-get install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter \
    && /usr/local/flutter/bin/flutter doctor

# Set Flutter environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable Flutter web
RUN flutter channel stable \
    && flutter upgrade \
    && flutter config --enable-web

# Create and set the working directory
RUN mkdir /app
WORKDIR /app

# Copy project files
COPY . /app/

# Get dependencies
RUN flutter pub get

# Build the Flutter web project
RUN flutter build web

# Use NGINX as the web server
FROM nginx:1.21.1-alpine

# Copy the build output to the NGINX HTML directory
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]