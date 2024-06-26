import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // Regex for email validation
  final RegExp regex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  // Validate the input email with the regex
  return regex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    // Add more test cases for invalid emails
    test('Email without @ symbol returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Email without local-part returns false', () {
      expect(isValidEmail('@example.com'), false);
    });

    test('Email without domain returns false', () {
      expect(isValidEmail('test@.com'), false);
    });

    test('Email without top-level domain returns false', () {
      expect(isValidEmail('test@example'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
