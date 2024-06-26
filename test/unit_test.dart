import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  return emailRegex.hasMatch(email);
}

void main() {
  test('Email validation', () {
    final validEmail = 'example@example.com';
    final invalidEmail = 'invalid email';

    expect(isValidEmail(validEmail), true);
    expect(isValidEmail(invalidEmail), false);
  });
}