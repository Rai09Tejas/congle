import 'package:congle/app/data/data.dart';
import 'package:congle/packages/packages.dart';
import '../../../../data/widgets/containers/small_containers/permission_list_tile.dart';
import '../../../../data/widgets/texts/custom_heading_text.dart';
import '../../../../data/widgets/texts/custom_texts.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllowPermissions extends StatelessWidget {
  const AllowPermissions({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupController controller;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(() => (controller.isLocationPermissionMissing.value ||
              controller.isMediaPermissionMissing.value)
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(color: Color(0xFFFF4545)),
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'We noticed you didn\'t enable location access. Please enable it in your settings to continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Hanken Grotesk',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ),
            )
          : const SizedBox(
              height: 66,
            )),
      const SizedBox(
        height: 18,
      ),
      customHeadingText("Let's Get You Connected!", kcBlack, 24,FontWeight.w700),
      const SizedBox(
        height: 16,
      ),
      customHankenText(
          "To ensure you're getting the most out of Congle, we\nneed just a couple of quick permissions:",
          kcBlack,
          14,
          FontWeight.w300,
          TextAlign.center),
      const SizedBox(
        height: 48,
      ),
      KPermissionListTile(
        leftImg: svg_location_access,
        title: 'Location Access',
        subtitle1: 'Connect Locally:',
        subtitle2:
            'Find and join nearby meet ups to build real, face-to-face connections',
        controller: controller,
      ),
      KPermissionListTile(
        leftImg: svg_media_access,
        title: 'media access',
        subtitle1: 'Share Your World:',
        subtitle2:
            "Upload photos to showcase your interests and personality to the community",
        controller: controller,
      ),

      const SizedBox(height: 60),
      const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Remember you\'re in control ',
              style: TextStyle(
                color: Color(0xFF292929),
                fontSize: 10,
                fontFamily: 'Hanken Grotesk',
                fontWeight: FontWeight.w600,
                height: 0.13,
              ),
            ),
            TextSpan(
              text:
                  ' - You can change these settings anytime in your\napp preferences. Let\'s start building real, lasting connections today!',
              style: TextStyle(
                color: Color(0xFF292929),
                fontSize: 10,
                fontFamily: 'Hanken Grotesk',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
          ],
        ),
      ),

      const Spacer(),
      Container(
        width: Get.width,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 25),
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
      // Obx(() => controller.isLoading.value
      //     ? const LoadingDots(
      //         numberOfDots: 5,
      //         color: kcAccent,
      //       )
      //     : KButton(
      //         title: 'Allow Permissions',
      //         onPressed: controller.allowPermissions,
      //         fontSize: 20,
      //         padding: const EdgeInsets.all(15),
      //       )),
      // const SizedBox(
      //   height: 10,
      // )
    ]);
  }
}
