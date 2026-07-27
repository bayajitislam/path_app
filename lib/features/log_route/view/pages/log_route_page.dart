import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';

class LogRoutePage extends StatelessWidget {
  const LogRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'Log Route',
        subtitle: 'Record your delivery route details',
        showBackButton: false,
      ),
      body: AppBg(child: Center(child: Text('Log Route Page'))),
    );
  }
}
