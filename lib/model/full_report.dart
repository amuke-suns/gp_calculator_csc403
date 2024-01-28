import 'dart:convert';

import 'package:gp_calculator/model/course.dart';

class FullReport {
  final String session;
  final String semester;
  final String level;
  final String gpa;
  final int totalUnits;
  int totalAccumulatedPoints;
  final List<Course> courses;

  FullReport({
    required this.session,
    required this.semester,
    required this.level,
    required this.gpa,
    required this.totalUnits,
    required this.totalAccumulatedPoints,
    required this.courses,
  });

  factory FullReport.fromJson(Map<dynamic, dynamic> json) {
    return FullReport(
      session: json['session'],
      semester: json['semester'],
      level: json['level'],
      gpa: json['gpa'],
      totalUnits: json['totalUnits'],
      totalAccumulatedPoints: json['totalAccumulatedPoints'],
      courses: (json['courses'] as List<dynamic>)
          .map((itemJson) => Course.fromJson(itemJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'session': session,
    'semester': semester,
    'level': level,
    'gpa': gpa,
    'totalUnits': totalUnits,
    'totalAccumulatedPoints': totalAccumulatedPoints,
    'courses': courses.map((e) => e.toJson()).toList()
  };
}
