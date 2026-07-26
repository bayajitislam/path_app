import 'package:get/get_navigation/get_navigation.dart';
import 'package:path_app/features/auth/view/pages/auth_page.dart';
import 'package:path_app/features/auth/view/pages/forgot_password_page.dart';
import 'package:path_app/features/auth/view/pages/otp_page.dart';
import 'package:path_app/features/auth/view/pages/reset_password_page.dart';
import 'package:path_app/features/onboarding/bindings/onboarding_binding.dart';
import 'package:path_app/features/onboarding/view/pages/onboarding_page.dart';
import 'package:path_app/features/splash/view/pages/splash_page.dart';
import 'package:path_app/features/subscription/view/pages/subscription_page.dart';
import 'package:path_app/routes/routes_name.dart';

class AppRoutes {
  static List<GetPage> pages = [
    //Splash
    GetPage(name: RoutesName.splash, page: () => SplashPage()),
    //Onboarding
    GetPage(
      name: RoutesName.onboarding,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    //Auth
    GetPage(name: RoutesName.auth, page: () => AuthPage()),
    GetPage(name: RoutesName.forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: RoutesName.otp, page: () => OtpPage()),
    GetPage(name: RoutesName.resetPassword, page: () => ResetPasswordPage()),

    //Subscription
    GetPage(name: RoutesName.subscription, page: () => SubscriptionPage()),
  ];
}
