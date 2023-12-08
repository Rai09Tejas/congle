import 'package:congle/app/data/widgets/appbar/appbar.dart';
import 'package:congle/app/modules/home/views/home_view.dart';
import 'package:congle/app/modules/landing/views/components/explore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../packages/packages.dart';
import '../../data/data.dart';
import 'controllers/landing_controller.dart';
import 'views/components/stories.dart';

class LandingPage extends GetView<LandingController> {
  const LandingPage({Key? key}) : super(key: key);

  Color getIconColor(int page) => controller.pageIndex == page
      ? Get.theme.colorScheme.secondary
      : Get.theme.focusColor;
  @override
  Widget build(BuildContext context) {
    Get.put(LandingController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: MyAppBar(
                  title: "Congle",
                  leftImg: svg_profile,
                  rightImg: svg_bell,
                  size: 36,
                ),
              ),
              ExploreTabs(),
              const StoriesWidget(),
            ],
          ),
        ),
      ),
    );
  }

  SnakeNavigationBar snakeNavBar(LandingController controller) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      elevation: 0.0,
      backgroundColor: Get.theme.bottomAppBarColor,
      snakeShape: SnakeShape(
          centered: true,
          padding: const EdgeInsets.all(5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      currentIndex: controller.pageIndex!,
      onTap: controller.updatePageIndex,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      snakeViewColor: Get.theme.bottomAppBarColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: KSvgIcon(
            assetName: svg_card_icon,
            size: 30,
            color: getIconColor(0),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: KSvgIcon(
            assetName: svg_heart,
            size: 25,
            color: getIconColor(1),
          ),
          label: 'Date Requests',
        ),
        BottomNavigationBarItem(
          icon: KSvgIcon(
            assetName: svg_calender,
            size: 25,
            color: getIconColor(2),
          ),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: KSvgIcon(
            assetName: svg_user,
            size: 25,
            color: getIconColor(3),
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: KSvgIcon(
            assetName: svg_user,
            size: 25,
            color: getIconColor(3),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
