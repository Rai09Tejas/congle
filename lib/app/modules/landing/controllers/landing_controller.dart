import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../activities/controllers/activities_controller.dart';
import '../../bookingRequests/controllers/booking_requests_controller.dart';
import '../../bookingRequests/views/booking_requests_view.dart';
import '../../dateRequests/controllers/date_requests_controller.dart';
import '../../dateRequests/views/date_requests_view.dart';
import '../../home/views/home_view.dart';
import '../../notifications/controllers/notifications_controller.dart';
import '../../profile/views/profile_view.dart';

class LandingController extends GetxController {
  // Add your controller logic here
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

  getCurrentPage() {
    switch (pageIndex) {
      case 0:
        return HomeView();
      case 1:
        return const DateRequestsView();
      // case 2:
      //   return RoomsView();
      case 2:
        return const BookingRequestsView();
      case 3:
        return const ProfileView();
      default:
        return Container();
    }
  }
}
