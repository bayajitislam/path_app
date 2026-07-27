import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class AppSearchbar extends StatelessWidget {
  const AppSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      backgroundColor: WidgetStatePropertyAll(AppPallete.white),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      elevation: WidgetStatePropertyAll(0),
      leading: Icon(Icons.search, color: AppPallete.primaryText),
      hintText: 'Search by player name or @handle',
      constraints: BoxConstraints(maxHeight: 40, minHeight: 40),
    );
  }
}
