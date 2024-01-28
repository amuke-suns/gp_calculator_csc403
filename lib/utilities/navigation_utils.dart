import 'package:flutter/cupertino.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/model/gp_report.dart';

class NavigationUtils {
  static String initial = '/';
  static String options = '/options';
  static String oneSemesterInput = '/inputGrades';
  static String cgpaInput = '/inputCGPA';
  static String editSemester = '/inputEdit';
  static String cgpaHome = '/home';
  static String gpReport = '/report';
  static String fullReport = '/fullReport';
  static String cgpaList = '/cgpaList';
  static String changePassword = '/changePassword';

  static void goToNamed(BuildContext context, String name) {
    Navigator.pushNamed(context, name);
  }

  static void goToGpReport(BuildContext context, GpReport report) {
    Navigator.pushNamed(context, gpReport, arguments: report);
  }

  static void goToFullReport(BuildContext context, FullReport report) {
    Navigator.pushNamed(context, fullReport, arguments: report);
  }

  static void goToChangePassword(BuildContext context, String currentPassword) {
    Navigator.pushNamed(context, changePassword, arguments: currentPassword);
  }

  static void goBackToOptions(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(options));
  }

  static void goBackToCGPAHome(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(cgpaHome));
  }
}