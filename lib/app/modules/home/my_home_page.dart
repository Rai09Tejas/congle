import 'package:congle/app/data/data.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/widgets/navigation_bar/navigation_bar.dart';
import 'controllers/home_controller.dart';

class MyHomePage extends GetView<HomeController> {
  const MyHomePage({Key? key}) : super(key: key);
  Color getIconColor(int page) => controller.pageIndex == page
      ? Get.theme.colorScheme.secondary
      : Get.theme.focusColor;

  @override
  Widget build(BuildContext context) {
    // Get.put(() => PreferenceSettingsController(), permanent: true);
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: DoubleBackToExit(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                margin: EdgeInsets.only(
                  top: Get.context!.mediaQueryPadding.top,
                  bottom: Get.context!.mediaQueryPadding.bottom, // + 45,
                ),
                child: controller.getCurrentPage(),
              ),
              Positioned(
                bottom: 8,
                left: 24,
                right: 24,
                child: BottomNavBar(
                  listOfIcons: const [
                    svg_home,
                    svg_discover,
                    svg_navbar_heart,
                    svg_chat,
                    svg_requests,
                  ],
                  currentIndex: controller.pageIndex ?? 0,
                  onTap: (index) {
                    controller.updatePageIndex(index);
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
