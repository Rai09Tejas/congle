import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/containers/text_feild_tiles/custom_input_fied.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import 'package:congle/packages/packages.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step3 extends StatelessWidget {
  Step3({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupController controller;

  final DateTime _selectedDate = DateTime.now();

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
        customHeadingText("My date of Birth is", kcBlack, 20,FontWeight.w700),
        const SizedBox(
          height: 32,
        ),
        InkWell(
            onTap: () {
              Get.log('date toggled');
              controller.isDateSelection.toggle();
            },
            child: Container(
              width: 312,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFADADAD)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Obx(() {
                      bool isDateChanged = controller.checkIfDateIsChanged();
                      Future.delayed(Duration.zero, () {
                        controller.canContinue.value = true;
                      });
                      return customHankenText(
                          isDateChanged
                              ? DateFormat('dd/MM/yyyy')
                                  .format(controller.dob.value)
                              : 'Select Your Date of Birth',
                          isDateChanged ? kcBlack : const Color(0xFFADADAD),
                          16,
                          FontWeight.w400,
                          TextAlign.start);
                    }),
                  ),
                  const Spacer(),
                  const KSvgIcon(assetName: svg_dob_calendar)
                ],
              ),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 8, left: 36),
            child: Text(
              'Your age will be public',
              style: Get.textTheme.bodyMedium!.copyWith(
                color: const Color(0xFFADADAD),
                fontSize: 14,
                fontFamily: 'Hanken Grotesk',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
