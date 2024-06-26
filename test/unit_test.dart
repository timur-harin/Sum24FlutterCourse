import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  if (email.contains('@') && email.contains('.')) {
    if (email.split('@')[0].isNotEmpty && email.split('@')[1].split('.')[0].isNotEmpty && email.split('@')[1].split('.')[1].isNotEmpty) {
      return true;
    }
  }
  
  return false;
}

void main() {
  group('Email Validation', () {
    test('Test 1', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Test 2', () {
      expect(isValidEmail('t@e.c'), true);
    });

    test('Test 3', () {
      expect(isValidEmail('@example.com'), false);
    });

    test('Test 4', () {
      expect(isValidEmail('test@.com'), false);
    });

    test('Test 5', () {
      expect(isValidEmail('test@example.'), false);
    });

    //  TODO add more test cases for invalid emails
  });

  // Test using flutter test test/unit_test.dart
}
