import 'package:hive_flutter/hive_flutter.dart';
part 'session_model.g.dart';

@HiveType(typeId: 1)
class Session extends HiveObject {

  @HiveField(0)
  final String _date;
  get date => _date;

  @HiveField(1)
  final String _duration;
  get duration => _duration;

  @HiveField(2)
  final int _phases;
  get phases => _phases;



  Session(this._date, this._duration, this._phases);
}

