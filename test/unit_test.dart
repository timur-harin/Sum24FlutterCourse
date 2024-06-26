import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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

    test('Valid email returns true', () {
      expect(isValidEmail('adukfhgasdkfd@eougfhewolgusgkol.fef'), true);
    });

    test('Invalid email Invalid characters', () {
      expect(isValidEmail('test@!example.com'), false);
    });

    test('Invalid email Missing @', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Invalid email Missing .', () {
      expect(isValidEmail('test@examplecom'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
