import 'package:grade_management_app/modules/dashboard/models/models.dart';

double calculateTotalStudentCGPA(Student student) {
  double cumulativeQualityPoints = 0;
  int cumulativeUnits = 0;

  if (student.years.isEmpty) {
    return 0;
  }

  for (Year year in student.years) {
    cumulativeQualityPoints +=
        calculateGPAPerYear(year) * calculateUnitsPerYear(year);
    cumulativeUnits += calculateUnitsPerYear(year);
  }

  return cumulativeQualityPoints / cumulativeUnits;
}

int calculateTotalUnitsPerYear(List<Year> years) {
  int totalUnits = 0;

  for (Year year in years) {
    totalUnits += calculateUnitsPerYear(year);
  }

  return totalUnits;
}

int calculateUnitsPerYear(Year year) {
  int firstSemesterUnits = 0;
  int secondSemesterUnits = 0;

  for (Course course in year.semesters[0].courses) {
    firstSemesterUnits += course.unit;
  }

  for (Course course in year.semesters[1].courses) {
    secondSemesterUnits += course.unit;
  }

  return firstSemesterUnits + secondSemesterUnits;
}

double calculateGPAPerYear(Year year) {
  double cumulativeQualityPoints = 0;
  int cumulativeUnits = 0;

  if (year.semesters[0].courses.isEmpty && year.semesters[1].courses.isEmpty) {
    return 0;
  }

  for (Semester semester in year.semesters) {
    cumulativeQualityPoints +=
        calculateSemesterGPA(semester) * semester.courses.length;
    cumulativeUnits += semester.courses.length;
  }

  return cumulativeQualityPoints / cumulativeUnits;
}

double calculateSemesterGPA(Semester semester) {
  double totalQualityPoints = 0;
  int totalUnits = 0;

  if (semester.courses.isEmpty) {
    return 0;
  }

  for (Course course in semester.courses) {
    totalQualityPoints += convertGradeToScore(course.grade) * course.unit;
    totalUnits += course.unit;
  }

  return totalQualityPoints / totalUnits;
}

int convertGradeToScore(String grade) {
  switch (grade) {
    case 'A':
      return 5;
    case 'B':
      return 4;
    case 'C':
      return 3;
    case 'D':
      return 2;
    case 'E':
      return 1;
    case 'F':
      return 0;
    default:
      return 0;
  }
}

int calculateTotalUnitsPerSemester(Semester semester) {
  int totalUnits = 0;

  for (Course course in semester.courses) {
    totalUnits += course.unit;
  }

  return totalUnits;
}
