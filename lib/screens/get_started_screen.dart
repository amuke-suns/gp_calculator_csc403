import 'package:flutter/material.dart';
import 'package:gp_calculator/screens/calc_options_screen.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/utilities/navigation_utils.dart';
import 'package:gp_calculator/widgets/app_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF6BA41B),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'images/get_started_bkg.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.all(48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Your Personal Grade Point Calculator',
                    style: TextStyle(fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Empower your academic journey with a GP calculator. '
                    'Easily track and calculate your GPA, manage courses, '
                    'and stay on top of your academic performance.',
                    style: TextStyle(
                      color: Color(
                        0xFF8E9399,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    title: 'Get Started',
                    onPressed: () {
                      NavigationUtils.goToNamed(context, NavigationUtils.options);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
