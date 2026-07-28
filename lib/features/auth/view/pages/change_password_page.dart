import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/features/auth/view/widgets/auth_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: const SecondaryAppBar(title: 'Change Password'),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // ── Old Password ──
                AuthField(
                  lebel: 'Old Password',
                  hintText: '********',
                  controller: _currentPasswordController,
                  isObscure: true,
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                // ── New Password ──
                AuthField(
                  lebel: 'New Password',
                  hintText: '********',
                  controller: _newPasswordController,
                  isObscure: true,
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                // ── Re Type Password ──
                AuthField(
                  lebel: 'Re Type Password',
                  hintText: '********',
                  controller: _confirmPasswordController,
                  isObscure: true,
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PrimaryButton(
                    buttonName: 'Save',
                    isLoading: false,
                    onPressed: () {
                      // Handle UI action / Navigation here
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
