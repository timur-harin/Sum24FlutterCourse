import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );
  return emailRegex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });
    test('Valid email returns true', () {
      expect(isValidEmail('testexample.com'), false);
    });
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.crm'), true);
    });
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.commit'), false);
    });
    test('Valid email returns true', () {
      expect(isValidEmail('test@example'), false);
    });
    test('Valid email returns true', () {
      expect(isValidEmail('@example.com.ru'), false);
    });

    //  TODO add more test cases for invalid emails
  });

  // Test using flutter test test/unit_test.dart
}
