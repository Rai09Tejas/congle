import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/appbar/appbar.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/swipe_card_container.dart';

class HomeView extends StatelessWidget {
  /// this show profile is to hide the container
  /// and add another page over it as this card stacks are made using overlay
  final RxBool showProfile = true.obs;

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const MyAppBar(title: "Discover"),
          Expanded(
              child: Obx(() => showProfile.value
                  ? SwipeCardsContainer(
                      prefButton: _prefButtonCallback,
                    )
                  : const Center(child: CircularProgressIndicator()))),
          const SizedBox(
            height: bottomNavBarHeight + 5,
          ),
        ],
      ),
    );
  }

  void _prefButtonCallback() {
    if (showProfile.value == true) showProfile.toggle();
    Get.toNamed(
      Routes.PREFERENCES,
    )!
        .whenComplete(() async {
      await Future.delayed(Get.defaultTransitionDuration);
      if (showProfile.value == false) showProfile.toggle();
    });
  }
}
