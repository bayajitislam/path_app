import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/features/auth/view/widgets/auth_field.dart';
import 'package:path_app/features/profile/view/widgets/profile_image_.avatardart';
import 'package:path_app/features/profile/view/widgets/uplaod_image_field.dart';

// Component Imports
// import 'package:path_app/features/profile/widgets/profile_image_avatar.dart';
// import 'package:path_app/features/profile/widgets/upload_image_field.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SecondaryAppBar(title: 'Profile Update'),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // ── Profile Image Widget ──
                const ProfileImageAvatar(),

                const SizedBox(height: 24),

                // ── Name Field ──
                AuthField(
                  lebel: 'Name',
                  hintText: 'Full Name',
                  controller: _nameController,
                ),

                const SizedBox(height: 16),

                // ── Address Field ──
                AuthField(
                  lebel: 'Address',
                  hintText: 'Type here.....',
                  controller: _addressController,
                ),

                const SizedBox(height: 16),

                // ── Upload Image Field Widget ──
                UploadImageField(
                  onPickImage: () {
                    // Trigger image picker logic
                  },
                ),

                const SizedBox(height: 24),

                // ── Save Button ──
                PrimaryButton(
                  buttonName: 'Save',
                  onPressed: () {
                    // Handle profile update logic
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
