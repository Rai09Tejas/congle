import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/containers/text_feild_tiles/custom_input_fied.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step8 extends StatelessWidget {
  const Step8({
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
        customHeadingText(
            "Welcome to congle🌟".toUpperCase(), kcBlack, 24, FontWeight.w700),
        const SizedBox(
          height: 16,
        ),
        customHankenText(
            "Are you ready for real connections? Join us in keeping Congle safe and inclusive by following our guidelines.",
            kcBlack,
            14,
            FontWeight.w300,
            TextAlign.center),
        const SizedBox(
          height: 36,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 19.0),
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: '✨ Be yourself'.toUpperCase(),
                style: Get.textTheme.bodyLarge!
                    .copyWith(color: kcBlack, height: 3)),
            TextSpan(
                text:
                    '\nEnsure your photos, age, and bio authentically represent you\n',
                style: Get.textTheme.bodyMedium),
            TextSpan(
                text: '🛡️ Stay safe'.toUpperCase(),
                style: Get.textTheme.bodyLarge!
                    .copyWith(color: kcBlack, height: 3)),
            TextSpan(
                text:
                    '\nAvoid hastily sharing personal information on chat before your meet-up\n',
                style: Get.textTheme.bodyMedium),
            TextSpan(
                text: '🤝 Connect first, then plan!'.toUpperCase(),
                style: Get.textTheme.bodyLarge!
                    .copyWith(color: kcBlack, height: 3)),
            TextSpan(
                text:
                    '\nChat and vibe with the profile before scheduling a \nmeet up\n',
                style: Get.textTheme.bodyMedium),
            TextSpan(
                text: '📍 Meet at our approved spots!'.toUpperCase(),
                style: Get.textTheme.bodyLarge!
                    .copyWith(color: kcBlack, height: 3)),
            TextSpan(
                text: '\nStay secure by choosing our trusted venues\n',
                style: Get.textTheme.bodyMedium),
            TextSpan(
                text: '🚨 Be proactive'.toUpperCase(),
                style: Get.textTheme.bodyLarge!
                    .copyWith(color: kcBlack, height: 3)),
            TextSpan(
                text: '\nAlways report any inappropriate behaviour\n',
                style: Get.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300)),
          ])),
        )
      ],
    );
  }
}
