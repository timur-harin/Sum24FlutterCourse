import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  final RegExp regex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)*\w+[\w-]$',
  );
  return regex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email without @ symbol returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Invalid email without domain returns false', () {
      expect(isValidEmail('test@'), false);
    });

    test('Invalid email with space returns false', () {
      expect(isValidEmail('test @example.com'), false);
    });
  });
}
// Test using flutter test test/unit_test.dart
