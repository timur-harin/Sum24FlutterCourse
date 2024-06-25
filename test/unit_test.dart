import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // Validate email
  // Check that email contains '@' sign, domain and name and all of them are valid strings

  final emailParts = email.split('@');
  if (emailParts.length != 2) return false;

  final domain = emailParts[1];
  if (!domain.contains('.')) return false;

  final domainParts = domain.split('.');
  if (domainParts.length < 2) return false;

  for (final part in domainParts) {
    if (part.isEmpty) return false;
  }
  return true;
}

bool isValidPassword(String password) {
  // Validate password
  // Check that password contains at least 8 characters, at least 1 uppercase letter, at least 1 lowercase
  // letter, at least 1 number, and at least 1 special character

  if (password.length < 8) return false;
  if (!password.contains(RegExp(r'[A-Z]'))) return false;
  if (!password.contains(RegExp(r'[a-z]'))) return false;
  if (!password.contains(RegExp(r'[0-9]'))) return false;
  // Check special characters
  if (!password.contains(RegExp(r'[$&+,:;=?@#|<>.^*()%!-]'))) return false;

  return true;
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('test'), false);
    });

    test('Email with invalid domain returns false', () {
      expect(isValidEmail('test@example'), false);
    });
  });

  group('Password Validation', () {
    test('Valid password returns true', () {
      expect(isValidPassword('Password123!'), true);
    });

    test('Invalid password returns false', () {
      expect(isValidPassword('password'), false);
    });
  });

  group('Password Validation', () {
    test('Valid password returns true', () {
      expect(isValidPassword('Password123!'), true);
    });

    test('Weak password returns false', () {
      expect(isValidPassword('password'), false);
    });

    test('Password with special characters returns true', () {
      expect(isValidPassword('P@ssw0rd'), true);
    });

    test('Password with only uppercase letters returns false', () {
      expect(isValidPassword('PASSWORD123!'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
