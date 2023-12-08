import 'package:get/get.dart';

import '../controllers/date_requests_controller.dart';

class DateRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DateRequestsController>(
      () => DateRequestsController(),
    );
  }
}
