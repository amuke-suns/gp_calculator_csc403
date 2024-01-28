import 'package:flutter/material.dart';
import 'package:gp_calculator/services/storage_service.dart';

mixin AlertUtils {
  Future<bool?> showPasswordDialog(BuildContext context) async {
    String currentPassword = await StorageServiceImpl().getCGPAPassword();
    String inputPassword = '';
    if (context.mounted) {
      bool? isCorrectPassword = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text.rich(
              TextSpan(
                text: 'Enter your password\n',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Your initial password is: ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    )
                  ),
                  TextSpan(
                      text: 'password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      )
                  ),
                ],
              ),
            ),
            /*const Text(
              'Enter the password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )*/
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
                child: const Text('ENTER'),
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
