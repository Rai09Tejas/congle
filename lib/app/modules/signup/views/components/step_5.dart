import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/containers/text_feild_tiles/custom_input_fied.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step5 extends StatelessWidget {
  const Step5({
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
        customHeadingText("Where do you work?", kcBlack, 20,FontWeight.w700),
        const SizedBox(
          height: 32,
        ),
        CustomInputField(
          controller: controller.workController,
          hint: 'Your Job Title',
          callback: () {
            controller.checkWork();
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 8, left: 36),
            child: Text(
              'Example: Student/ Designer / Teacher etc.',
              style: Get.textTheme.bodyMedium!.copyWith(
                color: const Color(0xFFADADAD),
                fontSize: 14,
                fontFamily: 'Hanken Grotesk',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        CustomInputField(
          controller: controller.companyController,
          hint: 'Company name',
          callback: () {
            controller.checkWork();
          },
        ),
      ],
    );
  }
}
