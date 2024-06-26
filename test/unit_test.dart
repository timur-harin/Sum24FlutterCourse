import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // Regular expression for validating an email
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

  return emailRegExp.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
      expect(isValidEmail('user.name+tag+sorting@example.com'), true);
      expect(isValidEmail('user_name@example.co.in'), true);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('plainaddress'), false); // Missing @
      expect(isValidEmail('@@missingusername.com'), false); // Missing username
      expect(isValidEmail('username@.com.my'), false); // TLD starts with dot
      expect(isValidEmail('username@.com'), false); // Domain starts with dot
      expect(isValidEmail('username@com'), false); // Missing TLD
      expect(isValidEmail('@missingusername.com'), false); // Missing username
      expect(isValidEmail('username@.com.my'), false); // TLD starts with dot
      expect(isValidEmail('username@sub_domain.com'), false); // Underscore in domain
      expect(isValidEmail('username@domain..com'), false); // Double dot in domain
      expect(isValidEmail('username@domain.com.'), false); // Trailing dot in domain
      expect(isValidEmail('.username@domain.com'), false); // Leading dot in username
    });
  });

  // Test using flutter test test/unit_test.dart
}
