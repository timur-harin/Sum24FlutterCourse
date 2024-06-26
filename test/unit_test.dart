import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // Regular expression for validating an email
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  return emailRegExp.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    //  TODO add more test cases for invalid emails

    test('Empty email returns false', () {
      expect(isValidEmail(''), false);
    });

    test('Email missing @ symbol returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
