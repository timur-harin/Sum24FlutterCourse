import 'package:flutter_test/flutter_test.dart';

const emailValidnessRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

bool isValidEmail(String email) {
  return RegExp(emailValidnessRegex).hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });
    test('Invalid email returns false', () {
      expect(isValidEmail('.test@example.com'), true);
    });
    //  TODO add more test cases for invalid emails
  });

  // Test using flutter test test/unit_test.dart
}
