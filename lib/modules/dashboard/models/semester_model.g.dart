// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SemesterAdapter extends TypeAdapter<Semester> {
  @override
  final int typeId = 2;

  @override
  Semester read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Semester(
      courses: (fields[0] as List).cast<Course>(),
    );
  }

  @override
  void write(BinaryWriter writer, Semester obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.courses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
