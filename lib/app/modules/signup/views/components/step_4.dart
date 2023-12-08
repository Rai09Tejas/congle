import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import 'package:congle/packages/packages.dart';
import '../../../../data/widgets/containers/small_containers/select_one_from_three.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step4 extends StatelessWidget {
  Step4({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupController controller;

  List<Map<String, dynamic>> containerDetails = [
    {'index': 0, 'image': img_male, 'title': 'MALE', 'enum': Gender.MALE},
    {'index': 1, 'image': img_female, 'title': 'FEMALE', 'enum': Gender.FEMALE},
    {
      'index': 2,
      'image': img_nonbinary,
      'title': 'NON-BINARY',
      'enum': Gender.OTHER
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        customHeadingText("I am a ", kcBlack, 20,FontWeight.w700),
        const SizedBox(
          height: 32,
        ),
        SelectOneWidget(
          containerDetails: containerDetails,
          callback: (Gender gender) {
            controller.addGender(gender);
          },
        )
      ],
    );
  }
}
