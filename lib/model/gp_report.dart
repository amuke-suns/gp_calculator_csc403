class GpReport {
  final String session;
  final String semester;
  final String level;
  final String gpa;

  GpReport({
    required this.session,
    required this.semester,
    required this. level,
    required this.gpa,
  });

  String getGradeClass() {
    double cgpa = double.parse(gpa);
    if (cgpa >= 4.5) {
      return "First Class Honours";
    } else if (cgpa >= 3.5) {
      return 'Second Class (Upper) Honours';
    } else if (cgpa >= 2.5) {
      return 'Second Class (Lower) Honours';
    } else if (cgpa >= 1.5) {
      return 'Third Class';
    } else if (cgpa >= 1.0) {
      return 'Pass';
    } else {
      return 'Fail';
    }
  }
}
