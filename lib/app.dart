import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:path_app/core/constants/app_strings.dart';
import 'package:path_app/core/theme/app_theme.dart';
import 'package:path_app/routes/app_routes.dart';
import 'package:path_app/routes/routes_name.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 854),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: AppStrings.pathApp,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,

        initialRoute: RoutesName.splash,

        getPages: AppRoutes.pages,
      ),
    );
  }
}
