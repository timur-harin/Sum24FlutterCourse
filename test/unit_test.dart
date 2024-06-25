import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
  if (emailRegex.hasMatch(email)) {
    return true;
  }
  return false;
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test'), false);
    });


    //  TODO add more test cases for invalid emails
  });

  // Test using flutter test test/unit_test.dart
}
