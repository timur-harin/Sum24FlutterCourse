# Use the latest Debian image as the base for the build environment
FROM debian:latest AS build-env

# Update the package list
RUN apt-get update 

# Install required dependencies for Flutter
RUN apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Download the latest stable version of Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter environment variables
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run Flutter doctor to ensure Flutter is correctly installed
RUN flutter doctor -v

# Set Flutter to the stable channel and upgrade
RUN flutter channel stable
RUN flutter upgrade

# Enable Flutter web support
RUN flutter config --enable-web

# Create the app directory
RUN mkdir /app/

# Copy the project files to the app directory
COPY . /app/
WORKDIR /app/

# Get the dependencies
RUN flutter pub get

# Build the web application
RUN flutter build web

# Use the NGINX image to serve the built web application
FROM nginx:1.21.1-alpine

# Copy the built web application to the NGINX html directory
COPY --from=build-env /app/build/web /usr/share/nginx/html
