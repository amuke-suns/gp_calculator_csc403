import 'package:flutter/material.dart';
import 'package:gp_calculator/cgpa_view_model.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/utilities/navigation_utils.dart';
import 'package:gp_calculator/widgets/app_button.dart';
import 'package:provider/provider.dart';

class FullReportScreen extends StatelessWidget {
  final FullReport fullReport;

  const FullReportScreen({
    super.key,
    required this.fullReport,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text.rich(
                TextSpan(
                  text: 'Your GPA is Ready!\n',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Congratulations! Your GPA has been calculated '
                          'based on the entered course details. Below is your result.',
                      style: TextStyle(
                        fontSize: 14,
                        color: kGreyTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'GPA: ${fullReport.gpa}\n',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                  children: [
                    TextSpan(
                      text: fullReport.getGradeClass(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\nThis GPA reflects your performance '
                          'for the ${fullReport.level} Level, ${fullReport.session} Session, '
                          '${fullReport.semester} Semester.',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: kGreyTextColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              AppButton(
                title: 'Save to Cumulative',
                onPressed: () {
                  final provider = Provider.of<CGPAViewModel>(
                    context,
                    listen: false,
                  );

                  provider.save(fullReport);

                  NavigationUtils.goBackToCGPAHome(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
