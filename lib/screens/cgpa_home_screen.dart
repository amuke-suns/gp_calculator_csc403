import 'package:flutter/material.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/services/storage_service.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/utilities/navigation_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CGPAHomeScreen extends StatelessWidget {
  const CGPAHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cumulative GPA'),
          automaticallyImplyLeading: false,
          elevation: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder<Box>(
                valueListenable: Hive.box(kAppBoxName).listenable(),
                builder: (context, box, widget) {
                  List<FullReport> reports = box.values.map((json) => FullReport.fromJson(json)).toList();

                  if (reports.isEmpty) {
                    return const Text(
                      'GP: 0.00',
                      style: TextStyle(
                        fontSize: 42,
                      ),
                    );
                  }
                  int sumCumulatedPoints = 0;
                  int sumTotalUnits = 0;

                  for (var report in reports) {
                    sumCumulatedPoints += report.totalAccumulatedPoints;
                    sumTotalUnits += report.totalUnits;
                  }

                  double cgpa = sumCumulatedPoints / sumTotalUnits;

                  return Text(
                    'GP: ${cgpa.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 42,
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    NavigationUtils.goToNamed(context, NavigationUtils.cgpaInput);
                  },
                  child: const Text('Add Semester'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    NavigationUtils.goToNamed(context, NavigationUtils.cgpaList);
                  },
                  child: const Text('View/Edit Existing Records'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final password = await StorageServiceImpl().getCGPAPassword();
                    if (context.mounted) {
                      NavigationUtils.goToChangePassword(context, password);
                    }
                  },
                  child: const Text('Change Password'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Clear CGPA'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
