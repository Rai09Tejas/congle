import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final PageController pageController = PageController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  RxBool expired = false.obs;
  final _phoneAuth = Get.find<PhoneAuthService>();
  // ignore: prefer_typing_uninitialized_variables
  var verificationId;

  RxBool isPhoneLoading = false.obs, isOtploading = false.obs;

  @override
  void onClose() {}

  Future<void> getOTP() async {
    if (phoneController.text != "" && phoneController.text.length == 10) {
      isPhoneLoading.toggle();
      FocusScope.of(Get.context!).requestFocus(FocusNode());

      final phoneNum = '+91 ${phoneController.text}';
      await _phoneAuth.verifyPhone(
          phoneNumber: phoneNum,
          onSmsSent: (String verId) {
            verificationId = verId;
            showSnackBar('OTP Sent to $phoneNum');
            pageController.nextPage(
                duration: 300.milliseconds, curve: Curves.decelerate);
          });
      Future.delayed(10.seconds).then((value) => isPhoneLoading.toggle());
    } else {
      showSnackBar('Invalid Phone Number', isError: true);
    }
  }

  void confirmOTP() {
    if (otpController.text != "" && otpController.text.length == 6) {
      isOtploading.toggle();
      FocusScope.of(Get.context!).requestFocus(FocusNode());

      _phoneAuth.signInWithOTP(otpController.text, verificationId);
      Future.delayed(10.seconds).then((value) => isOtploading.toggle());
    } else {
      showSnackBar('Incorrect OTP. Please check and try again', isError: true);
    }
  }

  void changeNumber() => pageController.previousPage(
      duration: 300.milliseconds, curve: Curves.decelerate);

  void resendOTP() => expired.toggle();
}
