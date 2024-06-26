import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // Simple regex pattern for email validation
  final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return regex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Email without "@" returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Email without domain returns false', () {
      expect(isValidEmail('test@'), false);
    });

    test('Email without username returns false', () {
      expect(isValidEmail('@example.com'), false);
    });

    test('Email with special characters returns false', () {
      expect(isValidEmail('test@exam!ple.com'), false);
    });

    test('Empty email returns false', () {
      expect(isValidEmail(''), false);
    });

    test('Email with consecutive dots returns false', () {
      expect(isValidEmail('test..email@example.com'), false);
    });

    test('Email with spaces returns false', () {
      expect(isValidEmail('test @example.com'), false);
    });
  });
}
