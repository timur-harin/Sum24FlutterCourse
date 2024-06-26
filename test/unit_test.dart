import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  return RegExp(
          r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
      .hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email with no @ returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Invalid email with no tld returns false', () {
      expect(isValidEmail('test@example'), false);
    });

    test('Invalid email with spaces returns false', () {
      expect(isValidEmail('test @ example.com'), false);
    });
  });
}