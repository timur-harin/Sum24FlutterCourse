import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // TODO add your validation logic here
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z\-0-9]+\.)+))([a-zA-Z]{2,}|[0-9]{1,})$");

  return emailRegex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    //  TODO add more test cases for invalid emails

    test('Email without domain returns false', () {
      expect(isValidEmail('test@'), false);
    });

    test('Email without local part returns false', () {
      expect(isValidEmail('@example.com'), false);
    });

    test('Email with invalid domain returns false', () {
      expect(isValidEmail('test@example'), false);
      expect(isValidEmail('test@.com'), false);
      expect(isValidEmail('test@example..com'), false);
      expect(isValidEmail('test@example_com'), false);
      expect(isValidEmail('test@example-com'), false);
    });

    test('Email with invalid local part returns false', () {
      expect(isValidEmail('test.com'), false);
      expect(isValidEmail('test@example.'), false);
      expect(isValidEmail('test@example_'), false);
      expect(isValidEmail('test@example-'), false);
    });

  // Test using flutter test test/unit_test.dart
  });
}
