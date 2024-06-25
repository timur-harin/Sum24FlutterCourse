import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // TODO add your validation logic here
  return false;
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    //  TODO add more test cases for invalid emails
  });

  // Test using flutter test test/unit_test.dart
}
