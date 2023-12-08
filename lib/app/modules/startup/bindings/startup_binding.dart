import 'package:congle/app/modules/startup/controllers/splash_controller.dart';
import 'package:get/get.dart';

import '../controllers/onboard_controller.dart';

class StartupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<OnBoardController>(
      () => OnBoardController(),
    );
  }
}
