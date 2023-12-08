import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/containers/text_feild_tiles/custom_input_fied.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import 'package:congle/packages/packages.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step2 extends StatelessWidget {
  const Step2({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        customHeadingText("Let's Get to Know You", kcBlack, 24,FontWeight.w700),
        const SizedBox(
          height: 16,
        ),
        customHankenText(
            "Let's keep it personal. We're ready to create a Congle\nexperience tailored to you",
            kcBlack,
            14,
            FontWeight.w300,
            TextAlign.center),
        const SizedBox(
          height: 48,
        ),
        customHeadingText("What’s your name?", kcBlack, 20,FontWeight.w700),
        const SizedBox(
          height: 32,
        ),
        CustomInputField(
          controller: controller.nameController,
          hint: 'Enter Your Full Name',
          callback: () => controller.checkName(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 8, left: 36),
            child: Text(
              'This is how it will appear on your profile',
              style: Get.textTheme.bodyMedium!.copyWith(
                color: const Color(0xFFADADAD),
                fontSize: 14,
                fontFamily: 'Hanken Grotesk',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        )
      ],
    );
  }
}
