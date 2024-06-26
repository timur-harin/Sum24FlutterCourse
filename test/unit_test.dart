import 'package:education/templates/lab6/login.dart';
import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  RegExp exp = RegExp(r'(^\S+@\S+\.\S+$)');
  return exp.hasMatch(email);
}

void main() {
  group('Email Validation', () {


    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test("Input email validation 1", () {
      expect(isValidEmail('email'),false);
    });

    test("Input email validation 1", () {
      expect(isValidEmail('email@'), false);
    });

    test("Input email validation 1", () {
      expect(isValidEmail('email@asd'), false);
    });

    test("Input email validation 1", () {
      expect(isValidEmail('@test.com'), false);
    });

    test("Input email validation 1", () {
      expect(isValidEmail('email@test.test'), true);
    });
  });

}