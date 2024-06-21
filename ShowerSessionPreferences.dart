class ShowerSessionPreferences {
  final String _firstPhase;
  final int _coldPhaseDuration, _hotPhaseDuration;
  ShowerSessionPreferences(this._firstPhase, this._coldPhaseDuration, this._hotPhaseDuration);

  get firstPhase => _firstPhase;
  int get coldPhaseDuration => _coldPhaseDuration;
  int get hotPhaseDuration => _hotPhaseDuration;

  @override toString() => "$_firstPhase & $_coldPhaseDuration & $_hotPhaseDuration";
}
