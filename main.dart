import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import "ShowerApp.dart";

void main() {
  runApp(const ProviderScope(
    child: ShowerApp(),
  ));
}

