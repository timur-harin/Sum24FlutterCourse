
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
      expect(isValidEmail('user.nadia@sub.tarubarova.co.ru'), true);
    });

    test('Test 2', () {
      expect(isValidEmail('nadia+mailbox@domain.com'), true);
    });

    test('Test 3', () {
      expect(isValidEmail('@domain.ru'), false);
    });

    test('Test 4', () {
      expect(isValidEmail('nadia@domaincom'), false);
    });

    test('Test 5', () {
      expect(isValidEmail('nadiatarubarova.com'), false);
    });
    test('Test 6', () {
      expect(isValidEmail('nadia@tarubarova..com'), false);
    });

  });

  // Test using flutter test test/unit_test.dart
}
