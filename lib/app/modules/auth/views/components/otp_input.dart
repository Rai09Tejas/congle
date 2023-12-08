import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/appbar/appbar.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class OTPInput extends StatelessWidget {
  const OTPInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(color: kcOffwhiteBg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
              child: MyAppBar(
                  title: "otp verification", leftImg: svg_left_arrow, size: 20),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32),
              alignment: Alignment.center,
              child: Text(
                "Enter the 6-digit OTP we've sent you to your mobile number ending with ****${controller.phoneController.text.substring(controller.phoneController.text.length - 3, controller.phoneController.text.length)}. ",
                style: Get.textTheme.bodyMedium!.copyWith(color: kcBlack),
                textAlign: TextAlign.center,
              ),
            ),
            otpInputField(),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive any code? ",
                    style: Get.textTheme.bodyMedium!.copyWith(color: kcBlack),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: controller.resendOTP,
                          child: Text(
                            "Resend",
                            style: Get.textTheme.bodyLarge!.copyWith(
                                color: kcBlack,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Visibility(
                          visible: !controller.expired.value,
                          child: Text(
                            " code in ",
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: kcBlack),
                          ),
                        ),
                        Visibility(
                          visible: !controller.expired.value,
                          child: Countdown(
                            seconds: 60,
                            onFinish: () => controller.expired.toggle(),
                            textStyle: Get.textTheme.bodyLarge!
                                .copyWith(color: kcBlack),
                          ),
                        ),
                        Visibility(
                          visible: !controller.expired.value,
                          child: Text(
                            " sec",
                            style: Get.textTheme.bodyLarge!
                                .copyWith(color: kcBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.isOtploading.value
                  ? const LoadingDots(
                      numberOfDots: 5,
                      color: kcAccent,
                    )
                  : SizedBox(
                      height: 56,
                      width: 312,
                      // margin: const EdgeInsets.symmetric(horizontal: 14),
                      child: KButton(
                          title: "Verify",
                          fontSize: 16,
                          bRadius: 16,
                          solidColor: const Color(0xFF292929),
                          onPressed: controller.confirmOTP),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  otpInputField() {
    return PinCodeFields(
      length: 6,
      fieldBorderStyle: FieldBorderStyle.square,
      margin: const EdgeInsets.only(right: 0, left: 0),
      padding: const EdgeInsets.all(0.0),
      responsive: false,
      fieldHeight: 48.0,
      fieldWidth: 48.0,
      borderWidth: 1.0,
      activeBorderColor: const Color(0xFFFF4545),
      activeBackgroundColor: kcWhite,
      borderRadius: BorderRadius.circular(12.0),
      keyboardType: TextInputType.number,
      autoHideKeyboard: false,
      autofocus: true,
      fieldBackgroundColor: kcWhite,
      borderColor: const Color(0xFFADADAD),
      textStyle: const TextStyle(
        color: kcBlack,
        fontSize: 16,
        fontFamily: 'Hanken Grotesk',
        fontWeight: FontWeight.w400,
      ),
      onComplete: (output) {
        controller.otpController.text = output;
        controller.confirmOTP();
      },
    );
  }
}
