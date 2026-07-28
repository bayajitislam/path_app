import 'package:get/get_navigation/get_navigation.dart';
import 'package:path_app/features/auth/view/pages/auth_page.dart';
import 'package:path_app/features/auth/view/pages/change_password_page.dart';
import 'package:path_app/features/auth/view/pages/forgot_password_page.dart';
import 'package:path_app/features/auth/view/pages/otp_page.dart';
import 'package:path_app/features/auth/view/pages/reset_password_page.dart';
import 'package:path_app/features/base/view/pages/base_page.dart';
import 'package:path_app/features/home/view/pages/friends_page.dart';
import 'package:path_app/features/home/view/pages/home_page.dart';
import 'package:path_app/features/home/view/pages/insight_page.dart';
import 'package:path_app/features/home/view/pages/trip_analytics_page.dart';
import 'package:path_app/features/home/view/pages/wallet_page.dart';
import 'package:path_app/features/leaderboard/view/pages/leaderboard_page.dart';
import 'package:path_app/features/log_route/view/pages/log_route_page.dart';
import 'package:path_app/features/notification/view/pages/notification_page.dart';
import 'package:path_app/features/onboarding/bindings/onboarding_binding.dart';
import 'package:path_app/features/onboarding/view/pages/onboarding_page.dart';
import 'package:path_app/features/play/view/pages/host_match_page.dart';
import 'package:path_app/features/play/view/pages/in_match_page.dart';
import 'package:path_app/features/play/view/pages/join_lobby_page.dart';
import 'package:path_app/features/play/view/pages/play_page.dart';
import 'package:path_app/features/profile/view/pages/achievement_page.dart';
import 'package:path_app/features/profile/view/pages/career_rank_page.dart';
import 'package:path_app/features/profile/view/pages/connect_account_page.dart';
import 'package:path_app/features/profile/view/pages/earnings_page.dart';
import 'package:path_app/features/profile/view/pages/help_and_feedback_page.dart';
import 'package:path_app/features/profile/view/pages/profile_page.dart';
import 'package:path_app/features/profile/view/pages/profile_update_page.dart';
import 'package:path_app/features/profile/view/pages/terms/faqs_page.dart';
import 'package:path_app/features/profile/view/pages/terms/privacy_policy_page.dart';
import 'package:path_app/features/profile/view/pages/terms/terms_and_condition_page.dart';
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

    //Home
    GetPage(name: RoutesName.wallet, page: () => WalletPage()),
    GetPage(name: RoutesName.insight, page: () => InsigntPage()),
    GetPage(name: RoutesName.tripAnalytics, page: () => TripAnalytics()),
    GetPage(name: RoutesName.friends, page: () => FriendsPage()),

    //Play
    GetPage(name: RoutesName.play, page: () => PlayPage()),
    GetPage(name: RoutesName.hostMatch, page: () => HostMatchPage()),
    GetPage(name: RoutesName.joinLobby, page: () => JoinLobbyPage()),
    GetPage(name: RoutesName.inMatch, page: () => InMatchPage()),

    //Profile
    GetPage(
      name: RoutesName.helpAndFeedback,
      page: () => HelpAndFeedbackPage(),
    ),
    GetPage(
      name: RoutesName.termsAndConditions,
      page: () => TermsAndConditionsPage(),
    ),
    GetPage(name: RoutesName.privacyPolicy, page: () => PrivacyPolicyPage()),
    GetPage(name: RoutesName.faqs, page: () => FaqsPage()),

    GetPage(name: RoutesName.connectAccount, page: () => ConnectAccountPage()),
    GetPage(name: RoutesName.changePassword, page: () => ChangePasswordPage()),

    GetPage(name: RoutesName.profileUpdate, page: () => ProfileUpdatePage()),
    GetPage(name: RoutesName.achievement, page: ()=> AchievementPage()),
    GetPage(name: RoutesName.careerRank, page: ()=> CareerRankPage()),
    GetPage(name: RoutesName.earnings, page: ()=> EarningsPage()),

    //Notification
    GetPage(name: RoutesName.notification, page: () => NotificationPage()),
  ];
}
