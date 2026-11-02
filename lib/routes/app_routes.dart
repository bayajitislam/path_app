import 'package:get/get_navigation/get_navigation.dart';
import 'package:path_app/features/auth/view/pages/auth_page.dart';
import 'package:path_app/features/auth/view/pages/change_password_page.dart';
import 'package:path_app/features/auth/view/pages/forgot_password_page.dart';
import 'package:path_app/features/auth/view/pages/otp_page.dart';
import 'package:path_app/features/auth/view/pages/reset_password_page.dart';
import 'package:path_app/features/base/bindings/base_binding.dart';
import 'package:path_app/features/base/view/pages/base_page.dart';
import 'package:path_app/features/home/view/pages/friends_page.dart';
import 'package:path_app/features/home/view/pages/home_page.dart';
import 'package:path_app/features/profile/view/pages/insight_page.dart';
import 'package:path_app/features/home/view/pages/trip_analytics_page.dart';
import 'package:path_app/features/home/view/pages/wallet_page.dart';
import 'package:path_app/features/leaderboard/bindings/leaderboard_binding.dart';
import 'package:path_app/features/leaderboard/view/pages/leaderboard_page.dart';
import 'package:path_app/features/leaderboard/view/pages/rank_detail_page.dart';
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
    GetPage(name: RoutesName.splash, page: () => const SplashPage()),
    //Onboarding
    GetPage(
      name: RoutesName.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    //Auth
    GetPage(name: RoutesName.auth, page: () => const AuthPage()),
    GetPage(
      name: RoutesName.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(name: RoutesName.otp, page: () => const OtpPage()),
    GetPage(
      name: RoutesName.resetPassword,
      page: () => const ResetPasswordPage(),
    ),

    //Subscription
    GetPage(
      name: RoutesName.subscription,
      page: () => const SubscriptionPage(),
    ),

    //Base
    GetPage(
      name: RoutesName.basePage,
      page: () => const BasePage(),
      binding: BaseBinding(),
    ),
    GetPage(name: RoutesName.home, page: () => const HomePage()),
    GetPage(name: RoutesName.profile, page: () => const ProfilePage()),
    //Leaderboard
    GetPage(
      name: RoutesName.leaderboard,
      page: () => const LeaderboardPage(),
      binding: LeaderboardBinding(),
    ),
    GetPage(
      name: RoutesName.rankDetail,
      page: () => const RankDetailPage(),
      binding: LeaderboardBinding(),
    ),
    GetPage(name: RoutesName.logRoute, page: () => const LogRoutePage()),

    //Home
    GetPage(name: RoutesName.wallet, page: () => const WalletPage()),
    GetPage(
      name: RoutesName.tripAnalytics,
      page: () => const TripAnalyticsPage(),
    ),
    GetPage(name: RoutesName.friends, page: () => const FriendsPage()),

    //Play
    GetPage(name: RoutesName.play, page: () => const PlayPage()),
    GetPage(name: RoutesName.hostMatch, page: () => const HostMatchPage()),
    GetPage(name: RoutesName.joinLobby, page: () => const JoinLobbyPage()),
    GetPage(name: RoutesName.inMatch, page: () => const InMatchPage()),

    //Profile
    GetPage(name: RoutesName.insight, page: () => const InsightPage()),
    GetPage(
      name: RoutesName.helpAndFeedback,
      page: () => const HelpAndFeedbackPage(),
    ),
    GetPage(
      name: RoutesName.termsAndConditions,
      page: () => const TermsAndConditionsPage(),
    ),
    GetPage(
      name: RoutesName.privacyPolicy,
      page: () => const PrivacyPolicyPage(),
    ),
    GetPage(name: RoutesName.faqs, page: () => const FaqsPage()),

    GetPage(
      name: RoutesName.connectAccount,
      page: () => const ConnectAccountPage(),
    ),
    GetPage(
      name: RoutesName.changePassword,
      page: () => const ChangePasswordPage(),
    ),

    GetPage(
      name: RoutesName.profileUpdate,
      page: () => const ProfileUpdatePage(),
    ),
    GetPage(name: RoutesName.achievement, page: () => const AchievementPage()),
    GetPage(name: RoutesName.careerRank, page: () => const CareerRankPage()),
    GetPage(name: RoutesName.earnings, page: () => const EarningsPage()),

    //Notification
    GetPage(
      name: RoutesName.notification,
      page: () => const NotificationPage(),
    ),
  ];
}
