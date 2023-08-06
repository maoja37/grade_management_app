import 'package:grade_management_app/modules/dashboard/models/semester_model.dart';
import 'package:hive/hive.dart';

part 'year_model.g.dart';

@HiveType(typeId: 3)
class Year {
  @HiveField(0)
  List<Semester> semesters = [
    Semester(courses: []),
    Semester(courses: []),
  ];
  @HiveField(1)
  String name;

  Year({required this.name});
}
