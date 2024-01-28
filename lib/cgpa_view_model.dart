import 'package:flutter/foundation.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:hive/hive.dart';

class CGPAViewModel extends ChangeNotifier {
  final _dataBox = Hive.box(kAppBoxName);

  save(FullReport fullReport) {
    final json = fullReport.toJson();
    String key = '${fullReport.session}${fullReport.semester}';

    _dataBox.put(key, json);
  }

  int getBoxSize() => _dataBox.length;

  delete(FullReport fullReport) {
    String key = '${fullReport.session}${fullReport.semester}';

    _dataBox.delete(key);
  }

  deleteAll() {
    _dataBox.clear();
  }

  retrieve(String session, String semester) {
    String key = '$session$semester';
    var json = _dataBox.get(key);

    if (json != null) {
      final fullReport = FullReport.fromJson(json);

      print(fullReport.gpa);
    }
  }
}