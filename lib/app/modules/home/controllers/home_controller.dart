import 'package:congle/app/modules/bookingRequests/controllers/booking_requests_controller.dart';
import 'package:congle/app/modules/bookingRequests/views/booking_requests_view.dart';
import 'package:congle/app/modules/activities/controllers/activities_controller.dart';
import 'package:congle/app/modules/dateRequests/controllers/date_requests_controller.dart';
import 'package:congle/app/modules/dateRequests/views/date_requests_view.dart';
import 'package:congle/app/modules/landing/landing_page.dart';
import 'package:congle/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:congle/app/modules/profile/views/profile_view.dart';
// import 'package:congle/app/modules/rooms/views/rooms_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/home_view.dart';

class HomeController extends GetxController {
  int? pageIndex;
  @override
  onInit() {
    super.onInit();
    Get.lazyPut(() => DateRequestsController(), fenix: true);
    Get.lazyPut(() => BookingRequestsController(), fenix: true);
    Get.lazyPut(() => ActivitiesController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);

    if (Get.arguments == 'booking') {
      pageIndex = 2;
    } else if (Get.arguments == 'profile') {
      pageIndex = 3;
    } else if (Get.arguments == 'date') {
      pageIndex = 1;
    } else {
      pageIndex = 0;
    }
  }

  updatePageIndex(int pg) {
    pageIndex = pg;
    update();
  }

  Widget getCurrentPage() {
    switch (pageIndex) {
      case 0:
        return const LandingPage();
      case 1:
        // return HomeView();
        return Container();
      case 2:
        return const DateRequestsView();
      // return Container();
      case 3:
        return Container();
      case 4:
        return Container();
      default:
        return Container();
    }
  }
}
