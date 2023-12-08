// ignore_for_file: unnecessary_overrides

import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/dateRequests/views/dialogs/date_confirm_dialog.dart';
import 'package:congle/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateRequestsController extends GetxController {
  TabController? tabController;
  List<DateRequest> expiredDateRequests = [];
  List<DateRequest> pendingDateRequests = [];
  List<DateRequest> requestedDateRequests = [];
  String? _nav;

  final datesApi = Get.find<DatesApi>();

  @override
  void onInit() {
    super.onInit();
    // expiredProfiles.addAll(demoProfilesShort);
    // pendingProfiles.addAll(demoProfilesShort);
    // requestedProfiles.addAll(demoProfilesShort);
    _nav = Get.parameters['pg'].toString();
    // print(_nav);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> cancelRequestedDate(DateRequest dateRequest) async {
    await datesApi.removeDateProfile(dateRequest.id).then((value) {
      if (value) {
        Get.log('Canceled Request of ${dateRequest.profile.name}');
        requestedDateRequests.remove(dateRequest);
      } else {
        KErrorToast();
      }
    });
    update();
  }

  Future<void> removeExpiredProfile(DateRequest dateRequest) async {
    await datesApi.removeDateProfile(dateRequest.id).then((value) {
      if (value) {
        Get.log('Deleted Request of ${dateRequest.profile.name}');
        expiredDateRequests.remove(dateRequest);
      } else {
        KErrorToast();
      }
    });
    update();
  }

  Future<void> rejectPendingRequest(DateRequest dateRequest) async {
    await datesApi.removeDateProfile(dateRequest.id).then((value) {
      if (value) {
        pendingDateRequests.remove(dateRequest);
      } else {
        KErrorToast();
      }
    });
    update();
  }

  Future<void> acceptPendingProfile(DateRequest dateRequest) async {
    await datesApi.acceptDateRequest(dateRequest.id).then((value) {
      if (value) {
        // pendingDateRequests.remove(dateRequest);

        update();
        // Get.find<BookingRequestsController>().addMeeting(dateRequest.profile);
        Get.find<NotificationsController>().addNotification(NotificationModel(
            title: 'You Accepted Profile',
            subTitle: "You have accepted ${dateRequest.profile.name}",
            time: DateTime.now(),
            exipireTime: DateTime.now().add(10.minutes),
            route: Routes.BOOKING_PENDING_REQUESTS,
            imageUrl: dateRequest.profile.dp));
        Get.to(() => CongoScreen(dateRequest: dateRequest));
      } else {
        KErrorToast();
      }
    });
  }

  Future<void> sendRequestExpiredProfile(DateRequest dateRequest) async {
    Get.log('Request Sent to ${dateRequest.profile.name}');
    Get.dialog(
      const LoadingDots.long(
        color: kcWhite,
      ),
      barrierDismissible: false,
    );

    await datesApi.requestDate(dateRequest.profile.id).then((value) async {
      if (value) {
        await datesApi.removeDateProfile(dateRequest.id).then((value) async {
          if (value) {
            expiredDateRequests.remove(dateRequest);
            Get.back();
            Get.dialog(
              const DateConfirmDialog(
                title: 'Request Sent',
                subtitle: 'You have Greater Chance of matching then others.',
              ),
              transitionCurve: Curves.easeInOutSine,
            );
            update();
            await Future.delayed(10.seconds).then((value) => Get.back());
          } else {
            KErrorToast();
          }
        });
      } else {
        KErrorToast();
      }
    });
  }

  Future<List<DateRequest>> getExpiredProfiles() async =>
      await datesApi.getDateExpired();
  Future<List<DateRequest>> getPendingProfiles() async =>
      await datesApi.getDatePending();
  Future<List<DateRequest>> getRequestedProfiles() async =>
      await datesApi.getDateRequested();

  void initTabController({required TickerProvider vsync}) {
    _nav = Get.parameters['pg'].toString();
    int initIndex = 0;
    if (_nav != null) {
      // print(_nav);
      if (_nav == 'pending') {
        initIndex = 1;
      } else if (_nav == 'expired') {
        initIndex = 2;
      }
    }

    tabController = TabController(
      initialIndex: initIndex,
      length: 3,
      vsync: vsync,
    );
  }
}
