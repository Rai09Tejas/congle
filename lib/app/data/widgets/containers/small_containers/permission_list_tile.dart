import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../modules/signup/controllers/signup_controller.dart';

class KPermissionListTile extends StatelessWidget {
  const KPermissionListTile({
    Key? key,
    this.leftImg,
    this.trailing,
    this.title,
    this.subtitle1,
    this.subtitle2,
    this.color,
    this.time,
    this.onTap,
    this.titleStyle,
    this.child,
    this.hasBorder = false,
    this.subtitleStyle,
    required this.controller,
  }) : super(key: key);

  final String? leftImg;
  final Widget? trailing;
  final String? title;
  final String? subtitle1;
  final String? subtitle2;
  final Color? color;
  final DateTime? time;
  final Function()? onTap;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? child;
  final bool hasBorder;

  final SignupController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color ?? Get.theme.cardColor,
          border: hasBorder ? Border.all() : null,
        ),
        child: child ??
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leftImg != null)
                  Obx(
                    () => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: leftImg == svg_location_access
                                    ? controller
                                            .isLocationPermissionMissing.value
                                        ? Colors.redAccent
                                        : kcBlack
                                    : controller.isMediaPermissionMissing.value
                                        ? Colors.redAccent
                                        : kcBlack,
                                width: 1)),
                        child: leftImg == svg_location_access
                            ? Container(
                                padding: const EdgeInsets.all(6),
                                child: KSvgIcon(
                                  assetName: leftImg,
                                  size: 24,
                                  color: controller
                                          .isLocationPermissionMissing.value
                                      ? Colors.redAccent
                                      : kcBlack,
                                ))
                            : Container(
                                padding: const EdgeInsets.all(6),
                                child: KSvgIcon(
                                  assetName: leftImg,
                                  size: 24,
                                  color:
                                      controller.isMediaPermissionMissing.value
                                          ? Colors.redAccent
                                          : kcBlack,
                                ))),
                  ),
                // if (leading != null)
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Row(
                          children: [
                            customHeadingText(
                              title!,
                              kcBlack,
                              20,FontWeight.w700
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            if (leftImg == svg_location_access)
                              Obx(() =>
                                  controller.isLocationPermissionMissing.value
                                      ? const KSvgIcon(
                                          assetName: svg_access_failed,
                                          size: 24,
                                          color: Colors.red,
                                        )
                                      : const SizedBox()),
                            if (leftImg == svg_media_access)
                              Obx(() =>
                                  controller.isMediaPermissionMissing.value
                                      ? const KSvgIcon(
                                          assetName: svg_access_failed,
                                          size: 24,
                                          color: Colors.red,
                                        )
                                      : const SizedBox()),
                          ],
                        ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (subtitle2 != null)
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '${subtitle1!} ',
                            style: Get.textTheme.bodyMedium!.copyWith(
                                color: kcBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: subtitle2!,
                            style: Get.textTheme.bodyMedium!.copyWith(
                                color: kcBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          )
                        ]))
                      // Text(
                      //   subtitle!,
                      //   style: subtitleStyle ??
                      //       (title == null
                      //           ? Get.textTheme.titleLarge!
                      //               .copyWith(fontSize: 16)
                      //           : Get.textTheme.bodyMedium!
                      //               .copyWith(color: Get.theme.focusColor)),
                      //   maxLines: 2,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
