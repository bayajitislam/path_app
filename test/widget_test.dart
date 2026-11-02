import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_app/app.dart';
import 'package:path_app/core/common/app_dialog.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/features/base/controllers/base_controller.dart';
import 'package:path_app/features/home/data/friends_repository.dart';
import 'package:path_app/features/home/data/trip_repository.dart';
import 'package:path_app/features/home/data/wallet_repository.dart';
import 'package:path_app/features/home/models/delivery_trip_model.dart';
import 'package:path_app/features/home/models/friend_model.dart';
import 'package:path_app/features/home/models/transaction_model.dart';
import 'package:path_app/features/home/view/widgets/live_gps_card.dart';
import 'package:path_app/features/leaderboard/controllers/leaderboard_controller.dart';
import 'package:path_app/features/notification/data/notification_repository.dart';
import 'package:path_app/features/notification/models/notification_model.dart';
import 'package:path_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:path_app/features/play/view/pages/host_match_page.dart';
import 'package:path_app/features/play/view/widgets/play_wager_card.dart';
import 'package:path_app/features/profile/view/widgets/faq_list.dart';

void main() {
  setUp(() {
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });

  group('Application Smoke & Initialization Tests', () {
    testWidgets('App root initializes without uncaught exceptions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const App());
      await tester.pump(const Duration(milliseconds: 500));

      // Splash page logo or text is rendered
      expect(find.byType(App), findsOneWidget);

      // Clean unmount
      await tester.pumpWidget(const SizedBox());
    });
  });

  group('Controllers & State Management Tests', () {
    test('BaseController manages tab index correctly', () {
      final controller = BaseController();
      expect(controller.currentIndex.value, 0);

      controller.changeIndex(2);
      expect(controller.currentIndex.value, 2);

      controller.changeIndex(4);
      expect(controller.currentIndex.value, 4);
    });

    test('OnboardingController tracks steps and selections', () {
      final controller = OnboardingController();
      expect(controller.currentStep.value, 1);
      expect(controller.selectedIndex.value, 0);
      expect(controller.selectedCountry.value, '');

      controller.select(1);
      expect(controller.selectedIndex.value, 1);

      controller.setCountry('United States');
      expect(controller.selectedCountry.value, 'United States');

      controller.onClose();
    });

    test('LeaderboardController manages cars and tiers', () {
      final controller = LeaderboardController();
      expect(controller.cars.isNotEmpty, true);
      expect(controller.selectedCarId.value, 'yellow_hover_car');
      expect(controller.activeCar.id, 'yellow_hover_car');

      controller.selectCar('space_rocket_1');
      expect(controller.selectedCarId.value, 'space_rocket_1');
      expect(controller.activeCar.name, 'Aero Rocket');

      controller.selectTab(1);
      expect(controller.selectedTab.value, 1);
    });
  });

  group('Domain Data Models & Repositories Tests', () {
    test('TransactionModel fromJson and toJson serialization', () {
      final json = {
        'id': 'tx_10',
        'title': 'Test Deposit',
        'date': 'Oct 30',
        'amount': 75.50,
        'type': 'deposit',
        'status': 'completed',
      };

      final tx = TransactionModel.fromJson(json);
      expect(tx.id, 'tx_10');
      expect(tx.amount, 75.50);
      expect(tx.type, TransactionType.deposit);
      expect(tx.status, TransactionStatus.completed);

      final encoded = tx.toJson();
      expect(encoded['title'], 'Test Deposit');
      expect(encoded['type'], 'deposit');
    });

    test('LocalWalletRepository returns expected mock data', () async {
      const repo = LocalWalletRepository();
      final balance = await repo.getBalance();
      final txs = await repo.getTransactions();

      expect(balance, greaterThan(0));
      expect(txs.length, 4);
      expect(txs.first.title, 'Jackpot Payout');
    });

    test('DeliveryTripModel fromJson and toJson serialization', () {
      final json = {
        'id': 'trip_99',
        'dateTime': 'Today, 4:00 PM',
        'ecoPoints': 20,
        'startLabel': 'Start Point',
        'dropoffLabel': 'Dropoff Point',
        'distanceKm': 8.5,
        'durationMin': 25,
        'co2Saved': 1.5,
      };

      final trip = DeliveryTripModel.fromJson(json);
      expect(trip.id, 'trip_99');
      expect(trip.ecoPoints, 20);
      expect(trip.distanceKm, 8.5);

      final encoded = trip.toJson();
      expect(encoded['startLabel'], 'Start Point');
    });

    test('LocalTripRepository returns mock trips', () async {
      const repo = LocalTripRepository();
      final trips = await repo.getRecentTrips();
      expect(trips.length, 3);
      expect(trips.first.ecoPoints, 12);
    });

    test('FriendModel fromJson and serialization', () {
      final json = {
        'id': 'fr_5',
        'name': 'Test Friend',
        'rank': 'Diamond I',
        'isOnline': true,
      };
      final friend = FriendModel.fromJson(json);
      expect(friend.name, 'Test Friend');
      expect(friend.isOnline, true);
    });

    test('LocalFriendsRepository returns mock friends', () async {
      const repo = LocalFriendsRepository();
      final friends = await repo.getFriends();
      expect(friends.length, 4);
      expect(friends.first.name, 'Maya Osei');
    });

    test('NotificationModel fromJson and copyWith', () {
      final notif = NotificationModel.fromJson({
        'id': 'n_1',
        'emoji': '⚡',
        'title': 'Test Notif',
        'time': 'Just now',
        'isRead': false,
        'category': 'Rankings',
      });

      expect(notif.isRead, false);
      final readNotif = notif.copyWith(isRead: true);
      expect(readNotif.isRead, true);
    });

    test('LocalNotificationRepository returns mock notifications', () async {
      const repo = LocalNotificationRepository();
      final list = await repo.getNotifications();
      expect(list.isNotEmpty, true);
    });
  });

  group('Reusable Core UI Widgets Tests', () {
    testWidgets('PrimaryButton renders label and responds to tap', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              buttonName: 'Submit Test',
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Submit Test'), findsOneWidget);
      await tester.tap(find.text('Submit Test'));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('PrimaryButton renders in solid color mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              buttonName: 'Solid Button',
              useGradient: false,
              solidColor: Colors.blue,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Solid Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('AppDialog displays title, message, and trigger callbacks', (
      WidgetTester tester,
    ) async {
      bool confirmed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AppDialog(
                        title: 'Notice',
                        message: 'This is a test notification',
                        onConfirm: () {
                          confirmed = true;
                          Navigator.pop(ctx);
                        },
                      ),
                    );
                  },
                  child: const Text('Open Dialog'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Notice'), findsOneWidget);
      expect(find.text('This is a test notification'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(confirmed, true);
    });

    testWidgets(
      'PlayWagerCard middle row scrolls horizontally without overflow',
      (WidgetTester tester) async {
        FlutterErrorDetails? errorDetails;
        final prevOnError = FlutterError.onError;
        FlutterError.onError = (details) {
          errorDetails = details;
        };

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 320, // Constrained small viewport width
                  child: PlayWagerCard(
                    playerName: 'Liam Chen',
                    playerRank: 'Gold III',
                    playerPoints: 180,
                    mode: 'Green Commute',
                    distanceKm: 8.5,
                    locationLabel: 'West Bay Station to Downtown Central',
                    reward: 320,
                    slotsUsed: 3,
                    slotsTotal: 4,
                  ),
                ),
              ),
            ),
          ),
        );

        FlutterError.onError = prevOnError;
        if (errorDetails != null) {
          debugPrint('ERROR CONTEXT: ${errorDetails?.context}');
          debugPrint('ERROR SUMMARY: ${errorDetails?.summary}');
          debugPrint(
            'ERROR INFO: ${errorDetails?.informationCollector?.call().map((d) => d.toString()).join("\n")}',
          );
        }

        // Verify the horizontal scroll view is present for chips
        final horizontalScrollView = find.byWidgetPredicate(
          (w) =>
              w is SingleChildScrollView &&
              w.scrollDirection == Axis.horizontal,
        );
        expect(horizontalScrollView, findsOneWidget);

        // Verify chips render without RenderFlex overflow
        expect(find.text('Green Commute'), findsOneWidget);
        expect(errorDetails, isNull);

        // Unmount widget cleanly
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );

    testWidgets('LiveGpsCard renders properly with bundled map preview', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(child: SizedBox(width: 360, child: LiveGpsCard())),
          ),
        ),
      );

      expect(find.text('Live GPS Tracking Active'), findsOneWidget);
      expect(find.text('Eco-Route Comparison'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('FaqItem expands to display answer on tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: FaqItem(
                question: 'How is my eco-score calculated?',
                answer:
                    'Your eco-score is calculated by analyzing your driving smoothness.',
              ),
            ),
          ),
        ),
      );

      // Question is visible
      expect(find.text('How is my eco-score calculated?'), findsOneWidget);

      // Tap to expand
      await tester.tap(find.text('How is my eco-score calculated?'));
      await tester.pumpAndSettle();

      // Answer is now visible
      expect(
        find.text(
          'Your eco-score is calculated by analyzing your driving smoothness.',
        ),
        findsOneWidget,
      );

      // Tap again to collapse
      await tester.tap(find.text('How is my eco-score calculated?'));
      await tester.pumpAndSettle();

      await tester.pumpWidget(const SizedBox.shrink());
    });

    testWidgets('HostMatchPage toggles between Max Players and Game Duration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: HostMatchPage()));

      // Initially Distance mode: Max Players is visible, Game Duration is not
      expect(find.text('Max players'), findsOneWidget);
      expect(find.text('Game Duration'), findsNothing);

      // Tap 'Duration' toggle tab
      await tester.tap(find.text('Duration'));
      await tester.pumpAndSettle();

      // Now Game Duration is visible, Max players is hidden
      expect(find.text('Game Duration'), findsOneWidget);
      expect(find.text('Game Availability Duration'), findsOneWidget);
      expect(find.text('2 hr'), findsOneWidget);
      expect(find.text('Max players'), findsNothing);

      // Tap '+' to increment duration
      final addBtn = find.byIcon(Icons.add).last;
      await tester.ensureVisible(addBtn);
      await tester.pumpAndSettle();
      await tester.tap(addBtn);
      await tester.pumpAndSettle();
      expect(find.text('3 hr'), findsOneWidget);

      // Tap 'Distance' toggle tab to return
      final distanceTab = find.text('Distance');
      await tester.ensureVisible(distanceTab);
      await tester.pumpAndSettle();
      await tester.tap(distanceTab);
      await tester.pumpAndSettle();

      expect(find.text('Max players'), findsOneWidget);
      expect(find.text('Game Duration'), findsNothing);

      await tester.pumpWidget(const SizedBox.shrink());
    });
  });
}
