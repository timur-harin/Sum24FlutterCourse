// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessionBath.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class sessionBathAdapter extends TypeAdapter<sessionBath> {
  @override
  final int typeId = 0;

  @override
  sessionBath read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return sessionBath(
      duration: (fields[0] as List).cast<String>(),
      timeStart: (fields[1] as List).cast<DateTime>(),
      phase_duration: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, sessionBath obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.duration)
      ..writeByte(1)
      ..write(obj.timeStart)
      ..writeByte(2)
      ..write(obj.phase_duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is sessionBathAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
