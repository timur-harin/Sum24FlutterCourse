import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
    return true;
  }
  return false;
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email, without @ returns false', (){
      expect(isValidEmail('testexample.com'), false);
    });


    test('Invalid email, without . returns false', (){
      expect(isValidEmail('test@examplecom'), false);
    });

    test('Invalid email, without @ and . returns false', (){
      expect(isValidEmail('testexamplecom'), false);
    });


    test('Empty email returns false', (){
      expect(isValidEmail(''), false);
    });

    //  TODO add more test cases for invalid emails
  });

  // Test using flutter test test/unit_test.dart
}
