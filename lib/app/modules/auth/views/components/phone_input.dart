import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import 'package:get/get.dart';

import '../../../../data/widgets/containers/text_feild_tiles/custom_input_fied.dart';
import '../../controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kcBlack,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: Get.height * 0.5,
              width: Get.width,
              child: Image.asset(
                img_login,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              left: 8,
              child: Container(
                height: Get.height * 0.5,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: kcWhite, borderRadius: BorderRadius.circular(32)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customHeadingText(
                        "ready, set,\ncongle!", kcBlack, 36, FontWeight.w700),
                    customHankenText(
                        "Enter your phone number and let the adventure begin!",
                        kcBlack,
                        14,
                        FontWeight.w300,
                        TextAlign.center),
                    CustomInputField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      hint: 'Enter your mobile number',
                      pretext: '+91 ',
                    ),
                    Container(
                      height: 56,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      child: Obx(() => controller.isPhoneLoading.value
                          ? const Center(
                              child: SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: CircularProgressIndicator(
                                    color: kcBlack,
                                  )))
                          : KButton(
                              title: "Continue with Phone",
                              fontSize: 16,
                              bRadius: 16,
                              solidColor: const Color(0xFF292929),
                              onPressed: controller.getOTP)),
                    ),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Your data is completely safe with us. \nRead our ',
                            style: TextStyle(
                              color: Color(0xFF292929),
                              fontSize: 12,
                              fontFamily: 'Hanken Grotesk',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyle(
                              color: kcBlack,
                              fontSize: 12,
                              fontFamily: 'Hanken Grotesk',
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )

            // Obx(() => controller.isPhoneLoading.value
            //     ? const LoadingDots(
            //         numberOfDots: 5,
            //         color: kcAccent,
            //       )
            //     : KButton(
            //         title: 'Get OTP',
            //         onPressed: controller.getOTP,
            //         fontSize: 20,
            //         padding: const EdgeInsets.all(18),
            //       )),
          ],
        ),
      ),
    );
  }
}
