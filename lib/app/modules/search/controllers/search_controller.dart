import 'dart:async';

import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchsController extends GetxController {
  TabController? tabController;
  TextEditingController searchController = TextEditingController();
  List<ShortProfile> profileList = [];

  @override
  void onInit() {
    super.onInit();
    profileList.addAll(demoProfilesShort);
    profileList.addAll(demoProfilesShort);
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

  Future<List<ShortProfile>> getHumansToFollow() async =>
      await Future.value(profileList);
  Future<List<ShortClub>> getClubsToFollow() async =>
      await Future.value(demoClubsShort);
}
