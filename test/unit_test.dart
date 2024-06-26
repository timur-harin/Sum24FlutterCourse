import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegExp.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
      expect(isValidEmail('user.name+tag+sorting@example.com'), true);
      expect(isValidEmail('user.name@example.co.uk'), true);
    });
  });
}