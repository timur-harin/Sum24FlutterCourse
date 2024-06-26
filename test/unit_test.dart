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
    test('Invalid email without "@" returns false', () {
      expect(isValidEmail('test.example.com'), false);
    });
    test('Invalid email without domain returns false', () {
      expect(isValidEmail('test@'), false);
    });
    test('Invalid email with special/wrong characters in domain returns false', () {
      expect(isValidEmail('test@example!.com'), false);
    });
    test('Invalid email with multiple "@" returns false', () {
      expect(isValidEmail('test@example@com'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
