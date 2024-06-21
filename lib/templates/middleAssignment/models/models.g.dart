// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShowerSessionAdapter extends TypeAdapter<ShowerSession> {
  @override
  final int typeId = 0;

  @override
  ShowerSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShowerSession(
      fields[0] as DateTime,
      (fields[1] as List).cast<TemperaturePhase>(),
      fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ShowerSession obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.phases)
      ..writeByte(2)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowerSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TemperaturePhaseAdapter extends TypeAdapter<TemperaturePhase> {
  @override
  final int typeId = 1;

  @override
  TemperaturePhase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemperaturePhase(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TemperaturePhase obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.phase)
      ..writeByte(1)
      ..write(obj.duration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemperaturePhaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
