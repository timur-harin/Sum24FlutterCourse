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
<<<<<<< HEAD
<<<<<<< HEAD
      phase_duration: (fields[2] as List).cast<String>(),
=======
>>>>>>> eef26d5 (mid assigment commit 1)
=======
      phase_duration: (fields[2] as List).cast<String>(),
>>>>>>> 8a0517b (mid assig second comit)
    );
  }

  @override
  void write(BinaryWriter writer, sessionBath obj) {
    writer
<<<<<<< HEAD
<<<<<<< HEAD
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.duration)
      ..writeByte(1)
      ..write(obj.timeStart)
      ..writeByte(2)
      ..write(obj.phase_duration);
=======
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.duration)
      ..writeByte(1)
      ..write(obj.timeStart);
>>>>>>> eef26d5 (mid assigment commit 1)
=======
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.duration)
      ..writeByte(1)
      ..write(obj.timeStart)
      ..writeByte(2)
      ..write(obj.phase_duration);
>>>>>>> 8a0517b (mid assig second comit)
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
