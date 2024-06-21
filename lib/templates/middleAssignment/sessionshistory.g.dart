// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessionshistory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionshistoryAdapter extends TypeAdapter<Sessionshistory> {
  @override
  final int typeId = 1;

  @override
  Sessionshistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sessionshistory(
      historyTotalTime: fields[0] as int,
      historyHotWaterDuration: fields[1] as int,
      historyColdWaterDuration: fields[2] as int,
      historyNumberOfCycles: fields[3] as int,
      historyRating: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Sessionshistory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.historyTotalTime)
      ..writeByte(1)
      ..write(obj.historyHotWaterDuration)
      ..writeByte(2)
      ..write(obj.historyColdWaterDuration)
      ..writeByte(3)
      ..write(obj.historyNumberOfCycles)
      ..writeByte(4)
      ..write(obj.historyRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionshistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
