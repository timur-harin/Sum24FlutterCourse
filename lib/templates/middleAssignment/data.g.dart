// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 0;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      hotShowerTime: fields[0] as int,
      coldShowerTime: fields[1] as int,
      totalTime: fields[2] as int,
      totalPhases: fields[3] as int,
      rating: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.hotShowerTime)
      ..writeByte(1)
      ..write(obj.coldShowerTime)
      ..writeByte(2)
      ..write(obj.totalTime)
      ..writeByte(3)
      ..write(obj.totalPhases)
      ..writeByte(4)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
