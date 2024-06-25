import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    caseSensitive: false,
  );
  return emailRegExp.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email (missing @) returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Invalid email (missing domain) returns false', () {
      expect(isValidEmail('test@'), false);
    });

    test('Invalid email (missing extension) returns false', () {
      expect(isValidEmail('test@example'), false);
    });

    test('Invalid email (extra characters) returns false', () {
      expect(isValidEmail('test@example.com!'), false);
    });

    test('Empty email returns false', () {
      expect(isValidEmail(''), false);
    });

    test('Email with spaces returns false', () {
      expect(isValidEmail(' test@example.com '), false);
    });

    // Add more test cases as needed
  });

  // Test using flutter test test/unit_test.dart
}