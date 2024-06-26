import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  final emailRegex = RegExp(
      r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  return emailRegex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test@example'), false);
    });

    test('Empty email returns false', () {
      expect(isValidEmail(''), false);
    });
  });
}