import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
      .hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email (without @)', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Invalid email (without domain)', () {
      expect(isValidEmail('test@examplecom'), false);
    });

    test('Invalid email (with invalid characters)', () {
      expect(isValidEmail('test@example.com*'), false);
    });

    test('Invalid email (with invalid domain)', () {
      expect(isValidEmail('test@example.'), false);
    });

    test('Invalid email (with multiple characters)', () {
      expect(isValidEmail('test@example.com@'), false);
    });
  });
  // Test using flutter test test/unit_test.dart
}
