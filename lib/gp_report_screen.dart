import 'package:flutter/material.dart';
import 'package:gp_calculator/model/gp_report.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/widgets/app_button.dart';

class GpReportScreen extends StatelessWidget {
  final GpReport report;

  const GpReportScreen({
    super.key,
    required this.report,
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
                  text: 'GPA: ${report.gpa}\n',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                  children: [
                    TextSpan(
                      text: 'This GPA reflects your performance '
                          'for the ${report.level} Level, ${report.session} Session, '
                          '${report.semester} Semester.',
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
                title: 'Back to Home',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
