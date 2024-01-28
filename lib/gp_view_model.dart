import 'package:flutter/foundation.dart';
import 'package:gp_calculator/model/course.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/model/gp_report.dart';

class GpViewModel extends ChangeNotifier {
  String? session;
  String? semester;
  String? level;
  String? totalUnits;

  List<Course> courses = [
    Course(),
  ];

  reset() {
    session = null;
    semester = null;
    level = null;
    totalUnits = null;

    courses = [
      Course(),
    ];
  }

  setForEdit(FullReport report) {
    session = report.session;
    semester = report.semester;
    level = report.level;
    totalUnits = report.totalUnits.toString();
    courses = report.courses;
  }

  GpReport getGpReport() {
    int totalCumulatedPoints = 0;

    for (var course in courses) {
      totalCumulatedPoints += course.units! * course.gradeUnit!;
    }

    double gpa = totalCumulatedPoints / int.parse(totalUnits!);

    return GpReport(
      session: session!,
      semester: semester!,
      level: level!,
      gpa: gpa.toStringAsFixed(2),
    );
  }

  String? validateHeaders() {
    if (session == null) {
      return 'Please specify the session';
    } else if (semester == null) {
      return 'Please specify the semester';
    } else if (level == null) {
      return 'Please specify the level';
    } else if (totalUnits == null) {
      return 'Please specify the total units';
    } else {
      int calculatedTotalUnits = 0;

      for (var course in courses) {
        if (course.units == null) {
          // some units have not been specified
          // this issue will be detected when the form is validated
          return null;
        }
        calculatedTotalUnits += course.units!;
      }

      if (calculatedTotalUnits != int.parse(totalUnits!)) {
        return 'The sum ($calculatedTotalUnits) of all the units is '
            'not equal to the specified Total Units ($totalUnits)';
      }
      return null;
    }
  }

  FullReport getFullReport() {
    int totalCumulatedPoints = 0;

    for (var course in courses) {
      totalCumulatedPoints += course.units! * course.gradeUnit!;
    }

    double gpa = totalCumulatedPoints / int.parse(totalUnits!);

    return FullReport(
      session: session!,
      semester: semester!,
      level: level!,
      gpa: gpa.toStringAsFixed(2),
      totalUnits: int.parse(totalUnits!),
      totalAccumulatedPoints: totalCumulatedPoints,
      courses: courses,
    );
  }
}
