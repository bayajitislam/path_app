import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class AppSearchbar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? hintText;

  const AppSearchbar({
    super.key,
    this.onChanged,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      onChanged: onChanged,
      backgroundColor: const WidgetStatePropertyAll(AppPallete.white),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      elevation: const WidgetStatePropertyAll(0),
      leading: const Icon(Icons.search, color: AppPallete.primaryText),
      hintText: hintText ?? 'Search by player name or @handle',
      constraints: const BoxConstraints(maxHeight: 40, minHeight: 40),
    );
  }
}
