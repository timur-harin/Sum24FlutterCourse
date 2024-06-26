import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // // TODO add your validation logic here
  // // return false;
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    // // TODO add more test cases for invalid emails
    test('Invalid email returns false', () {
      expect(isValidEmail('test@example@somewhere:there'), false);
    });
    test('Another invalid email returns false', () {
      expect(isValidEmail('This is definitely not an email'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
  // Done. All tests pass!
}
