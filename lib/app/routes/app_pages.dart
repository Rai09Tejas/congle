import 'package:get/get.dart';

import '../modules/activities/bindings/activities_binding.dart';
import '../modules/activities/views/activities_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/bookingRequests/bindings/booking_requests_binding.dart';
import '../modules/bookingRequests/views/booking_requests_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/dateRequests/bindings/date_requests_binding.dart';
import '../modules/dateRequests/views/date_requests_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/my_home_page.dart';
import '../modules/home/views/preferences_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/landing_page.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/edit_profile_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/rooms/bindings/rooms_binding.dart';
import '../modules/rooms/views/rooms_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/startup/bindings/startup_binding.dart';
import '../modules/startup/views/onboard_view.dart';
import '../modules/startup/views/splash_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: StartupBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => const OnBoardView(),
      binding: StartupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      // ignore: prefer_const_constructors
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const MyHomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PREFERENCES,
      page: () => const PreferencesView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.DATE_REQUESTED_REQUESTS,
      page: () => const DateRequestsView(),
      binding: DateRequestsBinding(),
      parameters: const {'pg': 'requested'},
    ),
    GetPage(
      name: _Paths.DATE_PENDING_REQUESTS,
      page: () => const DateRequestsView(),
      binding: DateRequestsBinding(),
      parameters: const {'pg': 'pending'},
    ),
    GetPage(
      name: _Paths.DATE_EXPIRED_REQUESTS,
      page: () => const DateRequestsView(),
      binding: DateRequestsBinding(),
      parameters: const {'pg': 'expired'},
    ),
    GetPage(
      name: _Paths.ACTIVITIES,
      page: () => const ActivitiesView(),
      binding: ActivitiesBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_PENDING_REQUESTS,
      page: () => const BookingRequestsView(),
      binding: BookingRequestsBinding(),
      parameters: const {'pg': 'pending'},
    ),
    GetPage(
      name: _Paths.BOOKING_UPCOMING_REQUESTS,
      page: () => const BookingRequestsView(),
      binding: BookingRequestsBinding(),
      parameters: const {'pg': 'upcoming'},
    ),
    GetPage(
      name: _Paths.BOOKING_COMPLETED_REQUESTS,
      page: () => const BookingRequestsView(),
      binding: BookingRequestsBinding(),
      parameters: const {'pg': 'completed'},
    ),
    GetPage(
      name: _Paths.ROOMS,
      page: () => const RoomsView(),
      binding: RoomsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
        name: _Paths.LANDING,
        page: () =>  LandingPage(),
        binding: LandingBinding()),
  ];
}
