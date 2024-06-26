FROM debian:latest AS build-env

RUN apt-get update && \
    apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 gnupg && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v

RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web

WORKDIR /app/
COPY pubspec.yaml pubspec.lock /app/
RUN flutter pub get
COPY . /app/

RUN flutter build web --release

FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html