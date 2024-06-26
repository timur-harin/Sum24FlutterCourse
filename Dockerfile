FROM debian:latest AS build-env

RUN apt-get update 
# Add apt-get install for flutter linux from 
# https://docs.flutter.dev/get-started/install/linux/desktop?tab=download
RUN apt-get clean
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip \ 
    libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter \
     && /usr/local/flutter/bin/flutter doctor

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v

RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web


RUN mkdir /app/
COPY . /app/
WORKDIR /app/

# TODO get dependencies
# TODO build web from needed file

RUN flutter pub get
RUN flutter build web

FROM nginx:1.21.1-alpine

COPY --from=build-env /app/build/web /usr/share/nginx/html
