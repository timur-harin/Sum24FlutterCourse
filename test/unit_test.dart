import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // TODO add your validation logic here
  if (email.contains('@') && email.contains('.') && email.length > 5) {
    return true;
  }
  return false;
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

    test('Invalid email returns false', () {
      expect(isValidEmail('test@example&ru'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('@.'), false);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test_example.ru'), false);
    });

    //  TODO add more test cases for invalid emails
  });

  // Test using flutter test test/unit_test.dart
}
