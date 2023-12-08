import 'package:congle/app/modules/home/controllers/swipe_card_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SwipeCardController>(
      () => SwipeCardController(),
    );
  }
}
