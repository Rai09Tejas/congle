import 'dart:developer';
import 'dart:io';

import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/appbar/appbar.dart';
import 'package:congle/app/modules/signup/views/components/step_7.dart';
import 'package:congle/app/modules/signup/views/components/step_8.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../controllers/signup_controller.dart';
import 'components/allow_permissions.dart';
import 'components/step_1.dart';
import 'components/step_2.dart';
import 'components/step_3.dart';
import 'components/step_4.dart';
import 'components/step_5.dart';
import 'components/step_6.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpList = [
      AllowPermissions(controller: controller),
      Step1(controller: controller),
      Step2(controller: controller),
      Step3(controller: controller),
      Step4(controller: controller),
      Step5(controller: controller),
      Step6(controller: controller),
      Step7(controller: controller),
      Step8(controller: controller),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kcOffwhiteBg,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () => showSnackBar('Progress will be gone!',
              isError: true,
              mainButton: InkWell(
                  onTap: () => exit(0),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('Exit'),
                  ))),
          child: GestureDetector(
            onTap: (() {
              if (controller.isDateSelection.value) {
                controller.isDateSelection.toggle();
              }
            }),
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Obx(() => !controller.isPermissionScreen.value
                        ? MyAppBar(
                            customTitle: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'STEP ${controller.pageNo.value}',
                                    style: const TextStyle(
                                      color: Color(0xFF292929),
                                      fontSize: 20,
                                      fontFamily: 'Hanken Grotesk',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' OF',
                                    style: TextStyle(
                                      color: Color(0xFF292929),
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'TestDomaine',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' 8',
                                    style: TextStyle(
                                      color: Color(0xFF292929),
                                      fontSize: 20,
                                      fontFamily: 'Hanken Grotesk',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            leftImg: controller.pageNo.value == 1
                                ? svg_cross
                                : svg_left_arrow,
                            leftFun: () {
                              controller.pageNo.value > 1
                                  ? controller.prevPage()
                                  : null;
                            },
                            hPadding: 16,
                            vPadding: 28,
                          )
                        : const SizedBox()),
                    Obx(
                      () => !controller.isPermissionScreen.value
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 48),
                              child: LinearProgressIndicator(
                                backgroundColor: const Color(0x33747474),
                                color: const Color(0xFF292929),
                                minHeight: 4,
                                value: controller.pageNo.value / 8,
                              ),
                            )
                          : const SizedBox(),
                    ),
                    Obx(
                      () => SizedBox(
                        height: controller.isPermissionScreen.value
                            ? Get.height * 0.8
                            : Get.height * 0.7,
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: signUpList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => signUpList[index],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    child: Obx(
                      () => controller.isDateSelection.value
                          ? SizedBox(
                              height: 200,
                              width: Get.width,
                              child: ScrollDatePicker(
                                selectedDate: controller.dob.value,
                                locale: const Locale('en'),
                                onDateTimeChanged: (DateTime value) {
                                  controller.addDate(value);
                                },
                              ),
                            )
                          : Container(
                              height: 56,
                              width: Get.width - 78,
                              margin: const EdgeInsets.only(
                                  left: 39, right: 39, bottom: 24),
                              child: Obx(() => KButton(
                                    title: controller.isPermissionScreen.value
                                        ? "Enable Permissions"
                                        : controller.pageNo.value == 8
                                            ? "I Agree"
                                            : "Continue ${controller.pageNo.value == 7 ? "${controller.totalImages}/3" : ""}",
                                    bRadius: 16,
                                    fontSize: 16,
                                    onPressed: () {
                                      controller.isPermissionScreen.value
                                          ? controller.allowPermissions()
                                          : controller.canContinue.value
                                              ? controller.nextPage()
                                              : null;
                                    },
                                    solidColor: controller.canContinue.value
                                        ? const Color(0xFF292929)
                                        : const Color(0xFFADADAD),
                                  )),
                            ),
                    ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
