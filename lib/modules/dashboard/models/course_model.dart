import 'package:hive/hive.dart';

part 'course_model.g.dart';

@HiveType(typeId: 1)
class Course {
  @HiveField(0)
  String name;
  @HiveField(1)
  String grade;
  @HiveField(2)
  int unit;
  // ... constructor and other methods ...
  Course({required this.name, required this.grade, required this.unit});
}
