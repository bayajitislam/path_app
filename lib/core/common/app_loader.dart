import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class AppLoader extends StatelessWidget {
  final Color color;
  const AppLoader({super.key, this.color = AppPallete.primary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}