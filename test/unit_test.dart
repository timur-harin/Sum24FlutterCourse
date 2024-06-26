import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

bool isValidEmail(String email) {
  RegExp regex = RegExp(r'^[\w\.]+@[\w]+\.[\w]{2,20}');
  return (regex.hasMatch(email));
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
      expect(isValidEmail('i.chabanov@innopolis.university'), true);
      expect(isValidEmail('i.chabanov@innopolis'), false);
      expect(isValidEmail('i.chabanov@innopolis.c'), false);

    });
  });
  // Test using flutter test test/unit_test.dart
}
