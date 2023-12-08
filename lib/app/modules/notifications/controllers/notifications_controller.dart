// ignore_for_file: unnecessary_overrides

import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  List<NotificationModel> generalNotifications = [];
  List<NotificationModel> roomsNotifications = [];

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void initTabController({required TickerProvider vsync}) {
    int initIndex = 0;

    tabController = TabController(
      initialIndex: initIndex,
      length: 2,
      vsync: vsync,
    );
  }

  Future<List<NotificationModel>> getGeneralNotifications() async =>
      await Future.value(generalNotifications.reversed.toList());
  Future<List<NotificationModel>> getRoomsNotifications() async =>
      await Future.value(roomsNotifications.reversed.toList());

  void addNotification(NotificationModel n) {
    generalNotifications.add(n);
    update();
  }

  void readNotification(NotificationModel n, bool visitPage) {
    int _i = generalNotifications.indexOf(n);
    if (!generalNotifications[_i].isRead) {
      if (visitPage || generalNotifications[_i].route != null) {
        Get.toNamed(generalNotifications[_i].route!);
      }
      generalNotifications[_i].isRead = true;
    }
    update();
  }
}
