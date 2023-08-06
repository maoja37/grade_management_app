import 'package:grade_management_app/modules/dashboard/models/year_model.dart';
import 'package:hive/hive.dart';

part 'student_model.g.dart';

String studentBoxName = 'student';

@HiveType(typeId: 4)
class Student {
  @HiveField(0)
  List<Year> years;
  // ... constructor and other methods ...
  Student({required this.years});
}
