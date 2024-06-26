import 'package:flutter_test/flutter_test.dart';

bool isValidEmail(String email) {
  if(!email.contains("@")){return false;}
  String name = email.split("@")[0];
  if(name.isEmpty){return false;}
  String domain = email.split("@")[1];
  if(domain.isEmpty){return false;}
  if(!domain.contains(".")){return false;}
  String domainName = domain.split(".")[0];
  if(domainName.isEmpty){return false;}
  String server = domain.split(".")[1];
  if(server.isEmpty){return false;}
  return true;
}

void main() {
  group('Email Validation', () {
    test('Valid email returns true', () {
      expect(isValidEmail('test@example.com'), true);
    });

    test("Invalid email return false", (){
      expect(isValidEmail('testExample.com'), false);
    });

    test("No email name return false", (){
      expect(isValidEmail('@example.com'), false);
    });

    test("No email domain return false", (){
      expect(isValidEmail('test@'), false);
    });

    test("Invalid email domain return false", (){
      expect(isValidEmail('test@examplecom'), false);
    });

    test("No email domain name return false", (){
      expect(isValidEmail('test@.com'), false);
    });

    test("No email domain server return false", (){
      expect(isValidEmail('test@example.'), false);
    });
  });

  // Test using flutter test test/unit_test.dart
}
