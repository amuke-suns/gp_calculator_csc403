import 'package:flutter/foundation.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:hive/hive.dart';

class CGPAViewModel extends ChangeNotifier {
  final dataBox = Hive.box(kAppBoxName);

  save(FullReport fullReport) {
    final json = fullReport.toJson();
    String key = '${fullReport.session}${fullReport.semester}';

    dataBox.put(key, json);
  }

  delete(FullReport fullReport) {
    String key = '${fullReport.session}${fullReport.semester}';

    dataBox.delete(key);
  }

  retrieve(String session, String semester) {
    String key = '$session$semester';
    var json = dataBox.get(key);

    if (json != null) {
      final fullReport = FullReport.fromJson(json);

      print(fullReport.gpa);
    }
  }
}