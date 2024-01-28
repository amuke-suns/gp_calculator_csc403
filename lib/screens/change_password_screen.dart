import 'package:flutter/material.dart';
import 'package:gp_calculator/services/storage_service.dart';
import 'package:gp_calculator/widgets/app_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String currentPassword;

  const ChangePasswordScreen({
    super.key,
    required this.currentPassword,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _newPassword;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          elevation: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  // obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter the current password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the current password';
                    } else if (value != widget.currentPassword) {
                      return 'Wrong current password';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  // ddsobscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter the new password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please specify your new password';
                    } else if (value == widget.currentPassword) {
                      return 'The new password cannot be the same as the current one';
                    } else if (value.trim().length < 6) {
                      return 'The password should be at least 6 characters';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _newPassword = value!;
                  },
                ),
                const SizedBox(height: 24),
                AppButton(
                  title: 'Change Password',
                  onPressed: () async {
                    final form = _formKey.currentState!;

                    if (form.validate()) {
                      form.save();
                      await StorageServiceImpl().setCGPAPassword(_newPassword!);

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password changed successfully')),
                        );

                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
