import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  if(email.contains('@') && email.contains('.')) {
    if(email.split('@')[0].isNotEmpty && email.split('@')[1].split('.')[0].isNotEmpty && email.split('.')[1].isNotEmpty) {
      return true;
    }
    return false;

  }
  return false;
}


void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);

    });
    test('Test 1.1', () {

      expect(isValidEmail('@inno.com'), false);
  });

  test('Test 1.2', () {

      expect(isValidEmail('d@i.c'), true);
  });

    test('Test 1.3', () {

      expect(isValidEmail('KiWi@inno.'), false);
  });

  // Test using flutter test test/unit_test.dart
});
}
