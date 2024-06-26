# Use the official Dart image
FROM dart:stable AS build

# Resolve app dependencies
WORKDIR /app
COPY . .
RUN dart pub get

# Compile the app
RUN dart compile exe bin/server.dart -o bin/server

# Use a minimal runtime image
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/
COPY --from=build /app/web /app/web/

# Start the server
CMD ["/app/bin/server"]
