import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );
  return emailRegExp.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('testexample.com'), false);
      expect(isValidEmail('test@com'), false);
      expect(isValidEmail('test@.com'), false);
      expect(isValidEmail('@example.com'), false);
      expect(isValidEmail('test@.com'), false);
    });
  });
}
