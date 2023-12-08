import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/modules/startup/controllers/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardContainer extends GetView<OnBoardController> {
  const OnBoardContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.child,
    this.stackChild,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final Widget? child;
  final Widget? stackChild;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: Get.height * 0.6,
            width: Get.width,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              gradient: const LinearGradient(
                begin: Alignment(0, -1.0),
                end: Alignment(0, 1),
                colors: [Colors.transparent, kcBlack],
                stops: [0.0, 1.0],
              ),
            )),
        Positioned(
          bottom: 0,
          child: Container(
            height: Get.height * 0.4,
            width: Get.width,
            decoration: const BoxDecoration(color: kcBlack),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customHeadingText(title, kcWhite, 36, FontWeight.w700),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    subtitle,
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: kcWhite,
                      fontSize: 14,
                      fontFamily: 'Hanken Grotesk',
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (child != null) child!,
                ],
              ),
            ),
          ),
        ),
        if (stackChild != null) stackChild!,
        Obx(
          () => (controller.currentPage.value == 0)
              ? screenOneWidgetOne()
              : Container(),
        ),
        Obx(
          () => (controller.currentPage.value == 0)
              ? screenOneWidgetTwo()
              : Container(),
        ),
        Obx(
          () => (controller.currentPage.value == 1)
              ? screenTwoWidget()
              : Container(),
        ),
        Obx(
          () => (controller.currentPage.value == 2)
              ? screenThreeWidget()
              : Container(),
        ),
      ],
    );
  }

  screenOneWidgetOne() {
    return Positioned(
        top: Get.height * 0.08,
        left: Get.width * 0.3,
        child: const KSvgIcon(
          assetName: svg_obscreen1_1,
          color: kcWhite,
          size: 100,
        ));
  }

  screenOneWidgetTwo() {
    return Positioned(
        top: Get.height * 0.4,
        left: Get.width * 0.05,
        child: const KSvgIcon(
          assetName: svg_obscreen1_2,
          color: kcWhite,
          size: 75,
        ));
  }

  screenTwoWidget() {
    return Positioned(
        bottom: Get.height * 0.23,
        left: Get.width * 0.03,
        child: const KSvgIcon(
          assetName: svg_obscreen2,
          color: kcWhite,
          size: 120,
        ));
  }

  screenThreeWidget() {
    return Positioned(
        top: Get.height * 0.45,
        child: const KSvgIcon(
          assetName: svg_obscreen3,
          color: kcWhite,
          size: 120,
        ));
  }
}
