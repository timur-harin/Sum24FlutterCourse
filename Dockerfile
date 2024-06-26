FROM debian:latest AS build-env

RUN apt-get update
RUN apt-get install -y bash curl file git unzip which xz-utils zip

RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter doctor -v
RUN flutter channel stable
RUN flutter upgrade

RUN flutter config --enable-web

RUN mkdir /app/

COPY . /app/

WORKDIR /app/
RUN flutter pub get
RUN flutter build web

RUN adduser nonroot

USER nonroot

FROM nginx:1.21.1-alpine

COPY --from=build-env /app/build/web /usr/share/nginx/html

HEALTHCHECK --interval=1m --timeout=3s CMD curl --fail http://localhost:80/ || exit 1