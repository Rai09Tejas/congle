import 'package:congle/app/modules/profile/controllers/edit_profile_controller.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
  }
}
