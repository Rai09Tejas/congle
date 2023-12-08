import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/enums/reason.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import '../../../../data/widgets/containers/small_containers/select_one_from_three.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {
  Step1({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupController controller;

  final List<Map<String, dynamic>> containerDetails = [
    {
      'index': 0,
      'image': img_step1_1,
      'title': 'Just Browsing\n🤓',
      'enum': Reason.BROWSING
    },
    {
      'index': 1,
      'image': img_step1_2,
      'title': 'New Friends \nPlease 🙋',
      'enum': Reason.FRIENDS
    },
    {
      'index': 2,
      'image': img_step1_3,
      'title': 'Searching for \nLove 💖',
      'enum': Reason.LOVE
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 4,
        ),
        customHeadingText("welcome to the\ncongle family!", kcBlack, 36,FontWeight.w700),
        const SizedBox(
          height: 16,
        ),
        customHankenText(
            "We've Been Waiting for You 🚀. But first, let's make\nyour journey even more incredible by personalising it",
            kcBlack,
            14,
            FontWeight.w300,
            TextAlign.center),
        const SizedBox(
          height: 48,
        ),
        customHeadingText("why are you here?", kcBlack, 20,FontWeight.w700),
        const SizedBox(
          height: 32,
        ),
        SelectOneWidget(
          containerDetails: containerDetails,
          callback: (Reason reason) {
            controller.addReason(reason);
          },
        )
      ],
    );
  }
}
