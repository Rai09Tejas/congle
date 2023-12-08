import 'package:congle/app/data/data.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  late AboutUser profile;
  RxInt percentage = 0.obs;
  @override
  void onInit() {
    super.onInit();
    profile = Congle.currentUser!;
    getPercentage();
  }

  @override
  void onClose() {}

  void settings() {
    // if (profile.value.instagram != null)
    //   profile.update((val) {
    //     if (val != null) {
    //       val.instagram = null;
    //       val.spotify = null;
    //       val.linkedin = null;
    //     }
    //   });
    // else
    //   profile.update((val) {
    //     if (val != null) {
    //       val.instagram = sample_instagram;
    //       val.spotify = sample_spotify;
    //       val.linkedin =
    //           "https://in.linkedin.com/company/congle-india?trk=public_profile_topcard-current-company";
    //     }
    //   });
    Get.toNamed(Routes.SETTINGS);
  }

  RxBool isLoading = false.obs;
  editProfile() async {
    isLoading.toggle();
    await Get.find<SignupApi>().getProfile();
    // bool x = await Get.find<EditProfileController>().initialized;
    // if (!x) await Get.find<EditProfileController>().initImages();
    Get.toNamed(Routes.EDIT_PROFILE);
    getPercentage();
    isLoading.toggle();
  }

  Future<void> updateProfile() async {
    Congle.currentUser = await Get.find<ProfileApi>().getCurrentUserProfile();
    profile = Congle.currentUser!;
    getPercentage();
    update();
  }

  void getPercentage() {
    percentage = 0.obs;
    if (profile.jobTitle != null) percentage += 13;
    if (profile.about != null) percentage += 13;
    if (profile.interests != null && profile.interests!.isNotEmpty) {
      percentage += 14;
    }
    if (profile.linkedin != null) percentage += 20;
    if (profile.instagram != null) percentage += 20;
    if (profile.spotify != null) percentage += 20;
  }
}
