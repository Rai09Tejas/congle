import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/containers/rooms_containers/upcoming_room_tile.dart';
import 'package:congle/app/modules/rooms/controllers/rooms_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UpcommingView extends GetView<RoomsController> {
  const UpcommingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleNContent(
              title: 'Today'.toUpperCase(),
              titleColor: Get.theme.focusColor,
              child: Column(
                children: const [
                  UpcomingRoomTile(),
                  UpcomingRoomTile(),
                ],
              ),
            ),
            TitleNContent(
              title: 'Tommorow'.toUpperCase(),
              titleColor: Get.theme.focusColor,
              child: Column(
                children: const [
                  UpcomingRoomTile(),
                  UpcomingRoomTile(),
                  UpcomingRoomTile(),
                  UpcomingRoomTile(),
                ],
              ),
            ),
            TitleNContent(
              title: 'SUGGESTIONS',
              titleColor: Get.theme.focusColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var club in demoClubsShort)
                      FollowClubContainer(
                        club: club,
                      ),
                  ],
                ),
              ),
            ),
            TitleNContent(
              title: 'Others'.toUpperCase(),
              titleColor: Get.theme.focusColor,
              child: Column(
                children: const [
                  UpcomingRoomTile(),
                  UpcomingRoomTile(),
                  UpcomingRoomTile(),
                  UpcomingRoomTile(),
                  UpcomingRoomTile(),
                ],
              ),
            ),
            const SizedBox(height: bottomNavBarHeight)
          ],
        ),
      ),
    );
  }
}
