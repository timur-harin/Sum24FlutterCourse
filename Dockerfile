FROM debian:latest AS build-env

RUN apt-get update && \
    apt-get install -y curl git && \
    apt-get clean

# Clone the original Flutter GitHub repository
RUN git clone https://github.com/timur-harin/Sum24FlutterCourse.git

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

# Build the web app
RUN flutter build web

FROM nginx:1.21.1-alpine

COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose the port for the web app
EXPOSE 80

# Set the entrypoint for the container
CMD ["nginx", "-g", "daemon off;"]