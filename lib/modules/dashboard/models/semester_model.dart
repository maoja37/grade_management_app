import 'package:grade_management_app/modules/dashboard/models/course_model.dart';
import 'package:hive/hive.dart';

part 'semester_model.g.dart';

@HiveType(typeId: 2)
class Semester {
  @HiveField(0)
  List<Course> courses;
  // ... constructor and other methods ...
  Semester({required this.courses});
}
