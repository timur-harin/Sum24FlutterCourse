FROM debian:latest AS build-env

# Install required tools
RUN apt-get update && apt-get install -y git wget unzip xz-utils zip libglu1-mesa curl

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set the Flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor -v

# Switch to stable channel and upgrade
RUN flutter channel stable
RUN flutter upgrade

# Enable Flutter web
RUN flutter config --enable-web

# Create and set the app directory
RUN mkdir /app/
COPY . /app/
WORKDIR /app/

# Get Flutter dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Start the second stage of the build for serving the app using Nginx
FROM nginx:1.21.1-alpine

# Copy the build files from the build-env to the nginx server
COPY --from=build-env /app/build/web /usr/share/nginx/html