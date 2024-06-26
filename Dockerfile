FROM debian:latest AS build-env

RUN apt-get update \
    && apt-get install -y curl git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter \
    && /usr/local/flutter/bin/flutter doctor

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter channel stable \
    && flutter upgrade \
    && flutter config --enable-web


RUN mkdir /app
WORKDIR /app

COPY . /app/

RUN flutter pub get

RUN flutter build web

FROM nginx:1.21.1-alpine

COPY --from=build-env /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
