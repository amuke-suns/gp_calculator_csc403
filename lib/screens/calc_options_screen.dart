import 'package:flutter/material.dart';
import 'package:gp_calculator/utilities/alert_utils.dart';
import 'package:gp_calculator/utilities/navigation_utils.dart';
import 'package:gp_calculator/widgets/app_button.dart';

class CalcOptionsScreen extends StatelessWidget with AlertUtils {
  const CalcOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Calculation Options',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Customize your GPA calculation based on your preference.'
                    'Select \'Semester\' for a specific term or '
                    '\'Cumulative\' for an overview of your overall academic performance.',
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    title: 'One Semester',
                    onPressed: () {
                      NavigationUtils.goToNamed(context, NavigationUtils.oneSemesterInput);
                    },
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    title: 'Cumulative Calculations',
                    onPressed: () async {
                      bool? isCorrectPassword =
                          await showPasswordDialog(context);

                      if (context.mounted) {
                        if (isCorrectPassword == false) {
                          const snackBar = SnackBar(
                            content: Text('Incorrect Password'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (isCorrectPassword == true) {
                          NavigationUtils.goToNamed(context, NavigationUtils.cgpaHome);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'images/calc_option_bkg.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
