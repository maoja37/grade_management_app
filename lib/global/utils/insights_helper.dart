class InsightsHelper {
  static const double firstClassThreshold = 4.5;
  static const double secondClassUpperThreshold = 3.5;
  static const double secondClassLowerThreshold = 2.4;
  static const double thirdClassThreshold = 1.5;
  static const double minimumThreshold = 1.0;

  static String giveAcademicInsights(double cgpa) {
    if (cgpa >= firstClassThreshold) {
      return "You're a first class student! You're doing so well";
    } else if (cgpa >= secondClassUpperThreshold) {
      return "You're a second class student (upper division). You're almost there";
    } else if (cgpa >= secondClassLowerThreshold) {
      return "You're a second class student (lower division). You can do better";
    } else if (cgpa >= thirdClassThreshold) {
      return "You're a third class student! You should see your Level advisor";
    } else if (cgpa >= minimumThreshold) {
      return "You're doing terrible, do you even read?";
    } else {
      return "Input grades for insights";
    }
  }

  static String getGraduationStatusBasedOnCGPA(double cgpa) {
    if (cgpa >= firstClassThreshold) {
      return "You're definitely eligible for graduation";
    } else if (cgpa >= secondClassUpperThreshold) {
      return "You're eligible for graduation";
    } else if (cgpa >= secondClassLowerThreshold) {
      return "You're still eligible for graduation";
    } else if (cgpa >= thirdClassThreshold) {
      return "Your graduation status is written in sand";
    } else if (cgpa >= minimumThreshold) {
      return "You might not be graduating";
    } else {
      return "Input grades for insights";
    }
  }
}