import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return (emailRegExp.hasMatch(email));
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });
    
    test('Invalid email returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Empty email returns false', () {
      expect(isValidEmail(''), false);
    });

    test('Invalid email with spaces returns false', () {
      expect(isValidEmail('test @example.com'), false);
    });

    test('Invalid email with special characters returns false', () {
      expect(isValidEmail('test!example.com'), false); 
    });

    test('Invalid email without domain returns false', () {
      expect(isValidEmail('test@example'), false);
    });
  });
}
