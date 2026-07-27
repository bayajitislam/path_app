import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SecondaryAppBar(title: 'Profile', showBackButton: false),
      body: AppBg(child: Center(child: Text('Profile Page'))),
    );
  }
}
