import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // TODO add your validation logic here
  RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  return regex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    //  TODO add more test cases for invalid emails
    test('Valid email returns true', () {
      expect(isValidEmail('invalid_email'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
