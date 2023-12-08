import 'package:congle/app/data/data.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool hideProfile = false.obs;
  RxBool showNotification = true.obs;

  @override
  void onClose() {}

  void toggleShowMyProfileSwitch(bool value) {
    hideProfile.toggle();
  }

  void toggleShowNotificationSwitch(bool value) {
    showNotification.toggle();
  }

  void logout() => Get.find<PhoneAuthService>().signOut();
  Future<void> deleteAccountDetails() async {
    Get.defaultDialog(
        textConfirm: 'Yes',
        confirmTextColor: Colors.white,
        textCancel: 'No',
        title: 'Do you want to Delete your data?',
        middleText: '',
        onConfirm: () async {
          Get.dialog(
            const LoadingDots.long(),
            barrierDismissible: false,
          );
          await Get.find<ProfileApi>().deleteProfile();
          Get.back();
          Get.find<PhoneAuthService>().signOut();
          // GetPlatform.isAndroid ? SystemNavigator.pop() : exit(0);
        });
  }

  bool isLinkedinAvailable() => Congle.currentUser!.linkedin != null;
  bool isInstagramAvailable() => Congle.currentUser!.instagram != null;
  bool isSpotifyAvailable() => Congle.currentUser!.spotify != null;

  void linkLinkedIn() {}
  void unlinkLinkedIn() {}
  void linkInstagram() {}
  void unlinkInstagram() {}
  void linkSpotify() {}
  void unlinkSpotify() {}
}
