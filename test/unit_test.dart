import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)*\w+[\w-]$');
  return (emailRegExp.hasMatch(email));
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Empty email returns false', () {
      expect(isValidEmail(''), false);
    });

    test('Invalid email with spaces returns false', () {
      expect(isValidEmail('test @example.com'), false);
    });

    test('Invalid email without domain returns false', () {
      expect(isValidEmail('test@example'), false);
    });

    test('Invalid email without @ returns false', () {
      expect(isValidEmail('testexample.com'), false);
    });
  });
}
