FROM debian:latest AS build-env

RUN apt-get update && \
    apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 && \
    rm -rf /var/lib/apt/lists/*

# Add apt-get install for flutter linux from
# https://docs.flutter.dev/get-started/install/linux/desktop?tab=download
RUN curl -s https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get clean

# TODO clone original flutter github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v

RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

RUN mkdir /app/
COPY . /app/
WORKDIR /app/

# TODO get dependencies
RUN flutter pub get

# TODO build web from needed file
RUN flutter build web

FROM nginx:1.21.1-alpine

COPY --from=build-env /app/build/web /usr/share/nginx/html