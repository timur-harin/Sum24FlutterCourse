import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // TODO add your validation logic here
  String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(emailRegex);
  return regex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    //  TODO add more test cases for invalid emails
    test('Invalid email returns false', () {
      expect(isValidEmail('test'), false);
    });

    test('Email with invalid domain returns false', () {
      expect(isValidEmail('test@example'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
