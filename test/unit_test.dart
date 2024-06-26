import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return true;
      } else {
    return false;
  }
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
      expect(isValidEmail('testexample.com'), false);
      expect(isValidEmail('test@example'), false);
      expect(isValidEmail('test@example.'), false);
      expect(isValidEmail('test@example..com'), false);
    });
  });
}
