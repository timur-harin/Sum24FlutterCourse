class ShowerSessionDuration {
  static int? getSeconds(String durationInStringFormat) {
    final seconds = int.tryParse(durationInStringFormat) ?? -1;
    return (0 <= seconds && seconds <= 60) ? seconds : null;
  }
}
