import 'package:flutter/material.dart';
import 'package:path_app/core/constants/app_images.dart';

class AppBg extends StatelessWidget {
  final Widget child;
  const AppBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.appBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}