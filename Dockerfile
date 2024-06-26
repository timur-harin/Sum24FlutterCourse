# Use the latest Debian image as the build environment
FROM debian:latest AS build-env

# Install necessary packages and clean up
RUN apt-get update && \
    apt-get install -y curl git unzip xz-utils zip libglu1-mesa && \
    apt-get clean

# Download and install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter to the stable channel and enable web support
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

# Check the Dart SDK version
RUN dart --version

# Create and set the working directory
RUN mkdir /app/
COPY . /app/
WORKDIR /app/

# Get Flutter dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Use Nginx to serve the Flutter web app
FROM nginx:1.21.1-alpine

# Copy the built web app to the Nginx HTML directory
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
