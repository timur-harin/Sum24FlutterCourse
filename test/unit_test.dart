import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // TODO add your validation logic here
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    //  TODO add more test cases for invalid emails
    test('No @ sign', () {
      expect(isValidEmail('babusmemus.com'), true);
    });

    test('Invalid email without top-level domain returns false', () {
      expect(isValidEmail('test@example'), false);
    });

    test('Email with multiple @ symbols', () {
      expect(isValidEmail('test@@example.com'), false);
    });

    test('Email starting with a special character', () {
      expect(isValidEmail('!test@example.com'), false);
    });
  });


  // Test using flutter test test/unit_test.dart
}
