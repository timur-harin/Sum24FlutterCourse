bool containsOnlyDigits(String string) {
  RegExp regExp = RegExp(r'^\d+$');
  return regExp.hasMatch(string);
}

void main() {
  String string = "12345";
  if (containsOnlyDigits(string)) {
    print("Строка содержит только цифры.");
  } else {
    print("Строка содержит не только цифры.");
  }
}
