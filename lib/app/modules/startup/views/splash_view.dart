import 'package:congle/app/data/data.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292929),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Obx(() {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (!controller.isLogoAnimated.value)
                AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    final scale = controller.animationController.isAnimating
                        ? (controller.animationController.value * 15)
                        : 1.0;
                    final colorTween = ColorTween(
                      begin: kcWhite,
                      end: kcGreen,
                    );
                    final color = colorTween
                            .transform(controller.animationController.value) ??
                        kcWhite;

                    return Transform.scale(
                      scale: scale,
                      child: KSvgIcon(
                        assetName: svg_logo,
                        size: 125,
                        color: color,
                      ),
                    );
                  },
                ),
              if (controller.isLogoAnimated.value)
                AnimatedBuilder(
                  animation: controller.titleController,
                  builder: (context, child) {
                    return AnimatedOpacity(
                      opacity: controller.titleController.value,
                      duration: const Duration(seconds: 2),
                      child: Transform.translate(
                          offset: Offset(
                              0.0, -10.0 * controller.titleController.value),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Congle",
                                style: TextStyle(
                                    fontSize: 46,
                                    color: kcGreen,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "TestDomaine"),
                              ),
                              Text(
                                '®',
                                style: TextStyle(
                                  color: Color(0xFFF2F0E4),
                                  fontSize: 16,
                                  fontFamily: 'Hanken Grotesk',
                                  fontWeight: FontWeight.w300,
                                  height: 0,
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              if (controller.isLogoAnimated.value)
                AnimatedBuilder(
                  animation: controller.subTitleController,
                  builder: (context, child) {
                    return AnimatedOpacity(
                      opacity: controller.titleController.value,
                      duration: const Duration(seconds: 2),
                      child: Transform.translate(
                          offset: Offset(
                              0.0, 30.0 * controller.subTitleController.value),
                          child: const Text(
                            'Connecting People',
                            style: TextStyle(
                              color: kcWhite,
                              fontSize: 16,
                              fontFamily: 'Hanken Grotesk',
                              height: 0,
                            ),
                          )),
                    );
                  },
                ),
              if (controller.isLogoAnimated.value)
                Positioned(
                  bottom: 10,
                  child: AnimatedBuilder(
                    animation: controller.bottomTextController,
                    builder: (context, child) {
                      return Opacity(
                          opacity: controller.bottomTextController.value,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              const Text(
                                'A Hyper-Local Social Networking App',
                                style: TextStyle(
                                  color: kcGreen,
                                  fontSize: 16,
                                  fontFamily: 'Hanken Grotesk',
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.1,
                                child: const KSvgIcon(
                                  assetName: svg_onboarding_element_1,
                                  size: 230,
                                  color: kcWhite,
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
