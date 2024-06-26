import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  if (email.isEmpty) {
    return false;
  }

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('invalidemail'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test@'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test@example'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('@example.com'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test@example.c'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test@example.'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test@.com'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
