FROM debian:latest AS build-env

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev \
    lib32stdc++6 \
    lib32gcc1 \
    lib32ncurses5 \
    lib32z1

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v

RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

RUN mkdir /app/
COPY . /app/
WORKDIR /app/

# Get dependencies
RUN flutter pub get

# Build web
RUN flutter build web

FROM nginx:1.21.1-alpine

COPY --from=build-env /app/build/web /usr/share/nginx/html
