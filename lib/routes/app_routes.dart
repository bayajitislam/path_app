import 'package:get/get_navigation/get_navigation.dart';
import 'package:path_app/features/auth/view/pages/auth_page.dart';
import 'package:path_app/features/auth/view/pages/forgot_password_page.dart';
import 'package:path_app/features/auth/view/pages/otp_page.dart';
import 'package:path_app/features/auth/view/pages/reset_password_page.dart';
import 'package:path_app/features/base/view/pages/base_page.dart';
import 'package:path_app/features/home/view%20copy/pages/wallet_page.dart';
import 'package:path_app/features/home/view/pages/home_page.dart';
import 'package:path_app/features/leaderboard/view/pages/leaderboard_page.dart';
import 'package:path_app/features/log_route/view/pages/log_route_page.dart';
import 'package:path_app/features/onboarding/bindings/onboarding_binding.dart';
import 'package:path_app/features/onboarding/view/pages/onboarding_page.dart';
import 'package:path_app/features/play/view/pages/play_page.dart';
import 'package:path_app/features/profile/view/pages/profile_page.dart';
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

    //Base
    GetPage(name: RoutesName.basePage, page: () => BasePage()),
    GetPage(name: RoutesName.home, page: () => HomePage()),
    GetPage(name: RoutesName.profile, page: () => ProfilePage()),
    GetPage(name: RoutesName.leaderboard, page: () => LeaderboardPage()),
    GetPage(name: RoutesName.logRoute, page: () => LogRoutePage()),

    //Wallet
    GetPage(name: RoutesName.wallet, page: () => WalletPage()),

    //Play
    GetPage(name: RoutesName.play, page: () => PlayPage()),
  ];
}
