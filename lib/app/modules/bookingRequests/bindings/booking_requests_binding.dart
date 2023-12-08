import 'package:get/get.dart';

import '../controllers/booking_requests_controller.dart';

class BookingRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingRequestsController>(
      () => BookingRequestsController(),
    );
  }
}
