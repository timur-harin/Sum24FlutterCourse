import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // Regular expression for email validation - structure something like this: 3C5Xa@example.com
  final pattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (pattern.hasMatch(email)) {
    return true;
  }
  return false;
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email without "@" returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Invalid email without domain returns false', () {
      expect(isValidEmail('test@.com'), false);
    });

    test('Invalid email without top-level domain returns false', () {
      expect(isValidEmail('test@example'), false);
    });

    test('Invalid email with spaces returns false', () {
      expect(isValidEmail('test @example.com'), false);
    });

    test('Invalid email with special characters returns false', () {
      expect(isValidEmail('test@exa!mple.com'), false);
    });

  });
  // Test using flutter test test/unit_test.dart
}
