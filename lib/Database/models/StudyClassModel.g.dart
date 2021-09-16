// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudyClassModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudyClassModelAdapter extends TypeAdapter<StudyClassModel> {
  @override
  final int typeId = 0;

  @override
  StudyClassModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyClassModel()
      ..className = fields[0] as String
      ..semester = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, StudyClassModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.semester);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyClassModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
