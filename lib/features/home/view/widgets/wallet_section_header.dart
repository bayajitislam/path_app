import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class WalletSectionHeader extends StatelessWidget {
  final String title;

  const WalletSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyle.s14w4i(
          color: AppPallete.primaryText,
        ).copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
