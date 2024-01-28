import 'package:flutter/material.dart';
import 'package:gp_calculator/services/storage_service.dart';

mixin AlertUtils {
  Future<bool?> showPasswordDialog(
    BuildContext context, {
    required String title,
    required String actionText,
  }) async {
    String currentPassword = await StorageServiceImpl().getCGPAPassword();
    String inputPassword = '';
    if (context.mounted) {
      bool? isCorrectPassword = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text.rich(
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: const [
                  TextSpan(
                      text: 'Your initial password is: ',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      )),
                  TextSpan(
                      text: 'password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(),
            content: TextField(
              onChanged: (value) {
                inputPassword = value;
              },
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    currentPassword == inputPassword,
                  );
                },
                child: Text(actionText),
              ),
            ],
          );
        },
      );
      return isCorrectPassword;
    }
    return null;
  }
}
