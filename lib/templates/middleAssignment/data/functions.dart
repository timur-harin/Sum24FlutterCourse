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

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inSeconds.remainder(60));
  String twoDigitHours = twoDigits(duration.inMinutes);
  return "$twoDigitHours:$twoDigitMinutes";
}
