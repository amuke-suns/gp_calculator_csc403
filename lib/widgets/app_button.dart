import 'package:flutter/material.dart';
import 'package:gp_calculator/utilities/constants.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title),
        ),
      ),
    );
  }
}
