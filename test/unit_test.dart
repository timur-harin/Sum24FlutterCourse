import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  // TODO add your validation logic here
  final RegExp regex = RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.\w+$");
  return regex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    //  TODO add more test cases for invalid emails
    test('Invalid email without domen', () {
      expect(isValidEmail('test@'), false);
    });

    test('Invalid email without @', () {
      expect(isValidEmail('testexample.com'), false);
    });

    test('Invalid email without "."', () {
      expect(isValidEmail('test@examplecom'), false);
    });

    test('Invalid email without symbols after "."', () {
      expect(isValidEmail('test@example.'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
