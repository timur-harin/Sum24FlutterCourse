import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );
  return emailRegex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });
    test('Email without @ symbol returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Email without domain returns false', () {
      expect(isValidEmail('test@.com'), false);
    });

    test('Email with special characters returns false', () {
      expect(isValidEmail('test*example@domain.com'), false);
    });

    test('Empty string returns false', () {
      expect(isValidEmail(''), false);
    });
  });
  // Test using flutter test test/unit_test.dart
}