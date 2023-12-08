import 'package:congle/app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FCMService extends GetxService {
  late FirebaseMessaging messaging;
  late String? fcmToken;
  Future<FCMService> init() async {
    messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Get.log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      Get.log('User granted provisional permission');
    } else {
      Get.log('User declined or has not accepted permission');
    }

    fcmToken = await messaging.getToken();
    Get.log(fcmToken ?? 'No Token Found');

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      if (initialMessage.data['type'] == 'booking-pending') {
        Get.to(Routes.BOOKING_PENDING_REQUESTS);
      } else if (initialMessage.data['type'] == 'booking-upcoming') {
        Get.to(Routes.BOOKING_UPCOMING_REQUESTS);
      } else if (initialMessage.data['type'] == 'date-pending') {
        Get.to(Routes.DATE_PENDING_REQUESTS);
      } else {
        Get.to(Routes.NOTIFICATIONS);
      }
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'booking') {
        Get.offNamed(Routes.HOME, arguments: 'booking');
      } else if (message.data['type'] == 'date') {
        Get.offNamed(Routes.HOME, arguments: 'date');
      } else if (message.data['type'] == 'social') {
        Get.offNamed(Routes.HOME);
      }
    });

    return this;
  }
}
