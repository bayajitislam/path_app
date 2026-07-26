import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/features/home/view/widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppPallete.white,
      appBar: HomeAppBar(userName: 'Kieran', onBellTap: () {},),
      body: AppBg(child: Center(child: Text('Home Page'))),
    );
  }
}
