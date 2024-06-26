FROM debian:latest AS build-env

RUN apt-get update 
# Add apt-get install for flutter linux from 
# https://docs.flutter.dev/get-started/install/linux/desktop?tab=download
RUN apt-get clean

# TODO clone original flutter github repo

RUN apt-get update

RUN apt-get install -y curl git unzip xz-utils zip

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter && \
    export PATH="/usr/local/flutter/bin:$PATH" && \
    flutter doctor -v



ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor -v

RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web


RUN mkdir /app/
COPY . /app/
WORKDIR /app/

RUN flutter pub get
RUN flutter build web --release -t lib/templates/lab7/main.dart

# TODO get dependencies
# TODO build web from needed file

FROM nginx:1.21.1-alpine

COPY --from=build-env /app/build/web /usr/share/nginx/html
