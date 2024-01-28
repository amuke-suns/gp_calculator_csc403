import 'package:flutter/material.dart';
import 'package:gp_calculator/cgpa_view_model.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/services/storage_service.dart';
import 'package:gp_calculator/utilities/alert_utils.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/utilities/navigation_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CGPAHomeScreen extends StatelessWidget with AlertUtils {
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
                  List<FullReport> reports = box.values
                      .map((json) => FullReport.fromJson(json))
                      .toList();

                  if (reports.isEmpty) {
                    return const Text.rich(
                      TextSpan(
                        text: 'GP: 0.00\n',
                        style: TextStyle(
                          fontSize: 42,
                        ),
                        children: [
                          TextSpan(
                            text: 'For 0 semester(s).',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    );
                  }
                  int sumCumulatedPoints = 0;
                  int sumTotalUnits = 0;

                  for (var report in reports) {
                    sumCumulatedPoints += report.totalAccumulatedPoints;
                    sumTotalUnits += report.totalUnits;
                  }

                  double cgpa = sumCumulatedPoints / sumTotalUnits;

                  return Text.rich(
                    TextSpan(
                      text: 'GP: ${cgpa.toStringAsFixed(2)}\n',
                      style: const TextStyle(
                        fontSize: 42,
                      ),
                      children: [
                        TextSpan(
                          text: 'For ${box.length} semester(s).',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    NavigationUtils.goToNamed(
                        context, NavigationUtils.cgpaInput);
                  },
                  child: const Text('Add Semester'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    NavigationUtils.goToNamed(
                        context, NavigationUtils.cgpaList);
                  },
                  child: const Text('View/Edit Existing Records'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final password =
                        await StorageServiceImpl().getCGPAPassword();
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
                  onPressed: () async {
                    final provider =
                        Provider.of<CGPAViewModel>(context, listen: false);
                    if (provider.getBoxSize() == 0) {
                      const snackBar = SnackBar(
                        content: Text('There are no records to clear.'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      bool? isCorrectPassword = await showPasswordDialog(
                          context,
                          title:
                              'Enter your password to clear all the records:\n',
                          actionText: 'CLEAR RECORDS');

                      if (context.mounted) {
                        if (isCorrectPassword == false) {
                          const snackBar = SnackBar(
                            content: Text('Incorrect Password'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (isCorrectPassword == true) {
                          provider.deleteAll();

                          const snackBar = SnackBar(
                            content: Text('All records deleted successfully'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    }
                  },
                  child: const Text('Clear All Records'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
