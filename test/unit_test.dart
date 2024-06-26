import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // TODO add your validation logic here
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
     //  TODO add more test cases for invalid emails
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });
    test('Invalid email (without @)returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });
    test('Invalid email (without domain)returns false', () {
      expect(isValidEmail('test@example.'), false);
    });
    test('Invalid email (with @@)returns false', () {
      expect(isValidEmail('test@@example.'), false);
    });
    test('Invalid email (with space)returns false', () {
      expect(isValidEmail('test @example.'), false);
    });
    test('Invalid email (without name)returns false', () {
      expect(isValidEmail('@example.'), false);
    });
    test('Empty email returns false', () {
      expect(isValidEmail(''), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
