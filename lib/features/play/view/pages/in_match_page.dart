import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';

class InMatchPage extends StatelessWidget {
  const InMatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'In Match',
        subtitle: 'Create a public challenge',
      ),
      body: AppBg(child: Center(child: Text('In Match Page'))),
    );
  }
}
