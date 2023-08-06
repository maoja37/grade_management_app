// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YearAdapter extends TypeAdapter<Year> {
  @override
  final int typeId = 3;

  @override
  Year read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Year(
      name: fields[1] as String,
    )..semesters = (fields[0] as List).cast<Semester>();
  }

  @override
  void write(BinaryWriter writer, Year obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.semesters)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
