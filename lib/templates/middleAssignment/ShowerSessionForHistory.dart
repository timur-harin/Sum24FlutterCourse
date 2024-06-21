class ShowerSessionForHistory{
  final int sessionDuration;
  final int hotWaterDuration;
  final int coldWaterDuration;
  final bool startWithHotWater;
  final int phasesCompleted;

  ShowerSessionForHistory({
    required this.sessionDuration,
    required this.hotWaterDuration,
    required this.coldWaterDuration,
    required this.startWithHotWater,
    required this.phasesCompleted,
  });
}