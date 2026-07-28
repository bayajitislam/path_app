import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/log_route/view/widgets/build_import_dropdown.dart';
import 'package:path_app/features/log_route/view/widgets/build_manual_logroute_form_.dart';
import 'package:path_app/features/log_route/view/widgets/route_summary_card.dart';

class LogRoutePage extends StatefulWidget {
  const LogRoutePage({super.key});

  @override
  State<LogRoutePage> createState() => _LogRoutePageState();
}

class _LogRoutePageState extends State<LogRoutePage> {
  bool _isFormExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: 'Log Route',
        subtitle: 'Record your delivery route details',
        showBackButton: false,
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Route Summary Card
                RouteSummaryCard(),
                const SizedBox(height: 16),

                // 2. Import from Delivery App Dropdown
                BuildImportDropDown(),
                const SizedBox(height: 16),

                // 3. Collapsible Add Log Form / Button
                if (!_isFormExpanded)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _isFormExpanded = true;
                      });
                    },
                    icon: const Icon(Icons.add, color: AppPallete.white),
                    label: Text(
                      'Add log Route',
                      style: AppTextStyle.s16w4i(
                        color: AppPallete.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPallete.primary,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  )
                else
                  BuildManualLogrouteForm(
                    onPressed: () {
                      setState(() {
                        _isFormExpanded = false;
                      });
                    },
                  ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
