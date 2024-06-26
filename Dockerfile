# Dockerfile
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  xz-utils \
  zip \
  libglu1-mesa

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Precache Flutter Web
RUN flutter precache --web

# Set working directory
WORKDIR /app

# Copy app files
COPY . .

# Get dependencies
RUN flutter pub get

# Build the web app
RUN flutter build web

# Expose port
EXPOSE 8080

# Run the web app
CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080"]