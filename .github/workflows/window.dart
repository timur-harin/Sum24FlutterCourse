name: Build Windows

on:
  push:
    branches:
      - lab7
  pull_request:
    branches:
      - lab7

jobs:
  build_windows:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
          flutter-version: 3.22.2
      - run: flutter config --enable-windows-desktop

      - run: flutter pub get

      - run: flutter build windows