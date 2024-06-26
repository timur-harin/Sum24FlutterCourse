# Use the official Dart image as the base image
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code and AOT compile the app.
COPY . ./
RUN dart pub get --offline
RUN dart compile exe bin/server.dart -o bin/server

# Use the official Dart runtime image to package the AOT compiled app.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Start the server.
CMD ["app/bin/server"]
