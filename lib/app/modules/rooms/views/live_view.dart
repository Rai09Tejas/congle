import 'package:congle/app/modules/rooms/controllers/rooms_controller.dart';
import 'package:flutter/material.dart';
import 'package:congle/app/data/data.dart';

import 'package:get/get.dart';

class LiveView extends GetView<RoomsController> {
  const LiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            welcomeWidget(),
            TitleNContent(
              title: 'Trending Rooms'.toUpperCase(),
              titleColor: Get.theme.focusColor,
              child: const Column(
                children: [
                  LiveRoomContainer(),
                  LiveRoomContainer(),
                ],
              ),
            ),
            TitleNContent(
              title: 'Categories'.toUpperCase(),
              titleColor: Get.theme.focusColor,
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryContainer(
                      title: 'Adventure ROOMS',
                      assetName: svg_cat_adventure,
                      noOfRooms: 5,
                    ),
                    CategoryContainer(
                      title: 'EVENTS IN THE CITY',
                      assetName: svg_cat_events,
                      noOfRooms: 10,
                    ),
                    CategoryContainer(
                      title: 'Dating & Love Rooms',
                      assetName: svg_cat_dating,
                      noOfRooms: 1,
                    ),
                    CategoryContainer(
                      title: 'Fitness Rooms',
                      assetName: svg_cat_fitness,
                      noOfRooms: 1,
                    ),
                    CategoryContainer(
                      title: 'Networking Rooms',
                      assetName: svg_cat_networking,
                      noOfRooms: 3,
                    ),
                    CategoryContainer(
                      title: 'Find New Friends',
                      assetName: svg_cat_friendship,
                      noOfRooms: 3,
                    ),
                    CategoryContainer(
                      title: 'Stocks & Crypto Rooms',
                      assetName: svg_cat_stocks,
                      noOfRooms: 3,
                    ),
                    CategoryContainer(
                      title: 'Start-Ups & Business',
                      assetName: svg_cat_startup,
                      noOfRooms: 3,
                    ),
                  ],
                ),
              ),
            ),
            TitleNContent(
              title: 'Humans to Follow'.toUpperCase(),
              titleColor: Get.theme.focusColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var profile in demoProfilesShort)
                      FollowProfileContainer(profile: profile),
                  ],
                ),
              ),
            ),
            TitleNContent(
              title: 'LIVE NOW',
              titleColor: Get.theme.focusColor,
              child: const Column(
                children: [
                  LiveRoomContainer(),
                  LiveRoomContainer(),
                  LiveRoomContainer(),
                  LiveRoomContainer(),
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
            const SizedBox(height: bottomNavBarHeight)
          ],
        ),
      ),
    );
  }

  Container welcomeWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: Get.theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: kcLightGrey.withOpacity(0.4),
            offset: const Offset(2, 5),
            spreadRadius: 2,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome to Congle Rooms 👋🏼',
                style: Get.textTheme.titleLarge!
                    .copyWith(color: Colors.black, fontSize: 16),
              ),
              const Icon(Icons.close),
            ],
          ),
          Text(
            'Create or join live audio conversations to connect with humans around your location across meaningfultopics and also plan a in-person meetings with them.',
            style: Get.textTheme.bodyMedium!.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            'Don\'t Worry You Join Silently',
            style: Get.textTheme.bodyMedium!.copyWith(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
