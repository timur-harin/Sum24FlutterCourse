import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return emailRegex.hasMatch(email);
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test('Invalid email returns false', () {
      expect(isValidEmail('invalid-email'), false);          
      expect(isValidEmail('invalid@.com'), false);            
      expect(isValidEmail('invalid@example'), false);        
      expect(isValidEmail('invalid@example.'), false);       
      expect(isValidEmail('invalid@.example.com'), false);  
      expect(isValidEmail('@example.com'), false);           
      expect(isValidEmail('invalid@com'), false);            
      expect(isValidEmail('invalid@.com.'), false);     
      expect(isValidEmail('invalid@com.'), false);          
      expect(isValidEmail('invalid@@example.com'), false); 
    });
  });
}

