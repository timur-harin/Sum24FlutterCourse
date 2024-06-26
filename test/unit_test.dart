import 'package:flutter_test/flutter_test.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

bool isValidEmail(String email) {
  if (email.length < 5 || email.length > 40) {
    return false;
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    return false;
  }
  return true;
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });
    test(
      'Empty Email', () {
        expect(isValidEmail(''), false);
      }
    );
    
    test('Email without @', () {
      expect(isValidEmail('testexample.com'), false);
    });
    
    test('Email without .com', () {
      expect(isValidEmail('test@example'), false);
    });
    
    test('Email with @ and .com but invalid format', () {
      expect(isValidEmail('test@example..com'), false);
    });
    
    test('Email with @ and .com but too long', () {
      expect(isValidEmail('test@exampleexrkjgpwrpmwphnphrnpnhpwnrphamplenamerobert.com'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
