import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'components/otp_input.dart';
import 'components/phone_input.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 2,
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return PhoneInput(controller: controller);
              } else {
                return OTPInput(controller: controller);
              }
            },
          ),
        ],
      ),
    );
  }
}
