import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/models/user/user_data.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class SplashController extends GetxController {
  late AnimationController animationController;
  late AnimationController titleController;
  late AnimationController subTitleController;
  late AnimationController bottomTextController;
  final isAnimationComplete = false.obs;
  final textOpacity = 0.0.obs;
  var isLogoAnimated = false.obs;

  @override
  void onInit() {
    super.onInit();
    declareControllers();

    Future.delayed(1.seconds).then((value) {
      animationController.forward().whenComplete(() {
        isAnimationComplete.value = true;
        animateText();
      });

      animationController.addStatusListener((status) async {
        isLogoAnimated.value = true;
        titleController.forward();
        titleController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            subTitleController.forward();
          }
        });

        bottomTextController.forward().whenComplete(() async {
          if (status == AnimationStatus.completed) {
            var fireUser = Get.find<PhoneAuthService>().fireUser;

            if (fireUser == null) {
              Get.offNamed(Routes.ONBOARD);
            } else {
              bool loginSuccess = await Get.find<Api>().login();
              if (!loginSuccess) {
                SignupApi api = SignupApi();
                api.init();

                await api.signUp(UserData.empty());
                Get.offNamed(Routes.PREFERENCES
                    // () => const NoConnectivity.apiError()  //Change this to NoConnectivity.apiError() if you want to show the error message
                    );

                return;
              }
              Congle.currentUser =
                  await Get.find<ProfileApi>().getCurrentUserProfile();

              if (Congle.currentUser == null) {
                Get.offNamed(Routes.SIGNUP);
              } else if (Congle.currentUser!.photos == null ||
                  Congle.currentUser!.photos!.length < 3) {
                Get.offNamed(Routes.SIGNUP, arguments: 2);
              } else {
                LocationData? loc = await getLocation();
                if (loc == null) {
                  Get.off(() =>
                      LocationPermissionPage(onLocationGet: (location) async {
                        loc = location;
                        await Get.find<SignupApi>().setLocation(loc!);
                        // print(location.toString());
                        Get.offNamed(Routes.HOME);
                      }));
                } else {
                  await Get.find<SignupApi>().setLocation(loc);
                  // Get.offNamed(Routes.SIGNUP);
                  Get.offNamed(Routes.HOME);
                }
              }
            }
          }
        });
      });
    });
  }

  @override
  void onClose() {
    // animationController.dispose();
    // titleController.dispose();
    // subTitleController.dispose();
    // bottomTextController.dispose();
    // super.onClose();
  }

  animateText() {
    Future.delayed(const Duration(seconds: 1), () {
      textOpacity.value = 1.0; // Gradually increase text opacity
    });
  }

  declareControllers() {
    animationController = AnimationController(
      vsync: SplashTickerProvider(),
      duration: const Duration(seconds: 1),
    );

    titleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: SplashTickerProvider(),
    );

    subTitleController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: SplashTickerProvider(),
    );

    bottomTextController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: SplashTickerProvider(),
    );
  }
}

class SplashTickerProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
