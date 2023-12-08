import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/startup/controllers/onboard_controller.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/onboard_container.dart';

class OnBoardView extends GetView<OnBoardController> {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardController());
    // controller.autoScroll();
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        PageView.builder(
          controller: controller.pageController,
          itemCount: controller.onBoardItems.length,
          itemBuilder: (context, index) => OnBoardContainer(
            title: controller.onBoardItems[index].title,
            subtitle: controller.onBoardItems[index].subtitle,
            image: controller.onBoardItems[index].image,
            stackChild: null,
          ),
        ),
        Positioned(
          bottom: 50,
          child: SizedBox(
            width: Get.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChipDotsIndicator(
                  controller: controller.pageController,
                  itemCount: controller.onBoardItems.length,
                  color: kcWhite,
                ),
                KIconButton(
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: kcBlack,
                    size: 30,
                    weight: 100.0,
                    fill: 1,
                  ),
                  onPressed: () => controller.currentPage == 2
                      ? Get.offAllNamed(Routes.LOGIN)
                      : controller.animateToNextPage(),
                  color: kcGreen,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
