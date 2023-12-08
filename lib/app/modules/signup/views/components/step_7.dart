import 'dart:io';

import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import 'package:congle/packages/packages.dart';
import '../../../../data/widgets/containers/small_containers/add_images_profile.dart';
import '../../../../data/widgets/containers/small_containers/select_one_from_three.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step7 extends StatefulWidget {
  const Step7({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupController controller;

  @override
  State<Step7> createState() => _Step7State();
}

class _Step7State extends State<Step7> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customHeadingText("One last Step", kcBlack, 24, FontWeight.w700),
          const SizedBox(
            height: 16,
          ),
          customHankenText(
              "To make our platform safe and secure we want you to upload at-least 3 pictures of you. ",
              kcBlack,
              14,
              FontWeight.w300,
              TextAlign.center),
          const SizedBox(
            height: 48,
          ),
          customHeadingText("Add your photos", kcBlack, 20, FontWeight.w700),
          const SizedBox(
            height: 32,
          ),
          AddProfileImages(controller: widget.controller),
          const SizedBox(
            height: 40,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Quick tips while uploading photos:\n',
                      style: TextStyle(
                        color: Color(0xFF292929),
                        fontSize: 14,
                        fontFamily: 'Hanken Grotesk',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text:
                          '  ▪️  Selfies are good 📸😊\n  ▪️  Avoid group photos 🚫👥\n  ▪️  No pics with sunglasses 🚫😎',
                      style: TextStyle(
                        color: Color(0xFF292929),
                        fontSize: 14,
                        fontFamily: 'Hanken Grotesk',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: Get.width,
            height: 36,
            margin: const EdgeInsets.symmetric(horizontal: 7),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFE6E6E6),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                const KSvgIcon(
                    assetName: svg_secured, size: 16, color: kcLightGrey),
                const SizedBox(width: 4),
                customHankenText(
                    'Your data is secure with us – trust us on this! 🔒',
                    const Color(0xFFADADAD),
                    12,
                    FontWeight.w400,
                    TextAlign.center),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
