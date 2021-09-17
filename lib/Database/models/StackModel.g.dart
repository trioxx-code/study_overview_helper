// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StackModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StackModelAdapter extends TypeAdapter<StackModel> {
  @override
  final int typeId = 1;

  @override
  StackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StackModel()
      ..className = fields[0] as String
      ..content = (fields[1] as Map).cast<dynamic, dynamic>();
  }

  @override
  void write(BinaryWriter writer, StackModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
