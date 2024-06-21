class Session {
  final Duration _sessionDuration;
  final Duration _periodDuration;
  final int _repetitions;

  Session(this._periodDuration, this._repetitions): _sessionDuration = _periodDuration * _repetitions;

  Session.sessionAndPeriodDurationInit(Duration sessionDuration, this._periodDuration) :
    _sessionDuration = sessionDuration,
    _repetitions = sessionDuration.inSeconds ~/ _periodDuration.inSeconds;

  int numberOfPeriods() {
    return _repetitions;
  }

  int numberOfPhases() {
    return (_sessionDuration.inSeconds / (_periodDuration.inSeconds / 2)).toInt();
  }

  Duration getPhaseDuration() {
    return _periodDuration * 0.5; // multiply by 0.5 because of the two periods: hot and cold
  }

  Duration getPeriodDuration() {
    return _periodDuration;
  }

  Duration getSessionDuration() {
    return _sessionDuration;  
  }

  static String formattedDuration(Duration duration) {
    return "${duration.inMinutes.toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }

  String info() {
    String phaseDuration = formattedDuration(getPhaseDuration());
    String periodDuration = formattedDuration(getPeriodDuration());
    String sessioonDuration = formattedDuration(getSessionDuration());

    return "Phase duration: $phaseDuration\nPeriod duration: $periodDuration\nRepetitions: $_repetitions\nOverall session duration: $sessioonDuration";
  }
}