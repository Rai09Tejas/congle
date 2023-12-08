import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/appbar/appbar.dart';
import 'package:congle/app/data/widgets/containers/small_containers/preference_containers.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import 'package:congle/app/modules/home/controllers/swipe_card_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PreferencesView extends GetView<SwipeCardController> {
  const PreferencesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isPrefChanged = false;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          color: kcOffwhiteBg,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: const MyAppBar(
                    leftImg: svg_left_arrow,
                    customTitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Y',
                            style: TextStyle(
                              color: Color(0xFF292929),
                              fontSize: 20,
                              fontFamily: 'Hanken Grotesk',
                              fontWeight: FontWeight.w400,
                              height: 0.07,
                            ),
                          ),
                          TextSpan(
                            text: 'O',
                            style: TextStyle(
                              color: Color(0xFF292929),
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'TestDomaine',
                              fontWeight: FontWeight.w600,
                              height: 0.07,
                            ),
                          ),
                          TextSpan(
                            text: 'UR PREFERENCES',
                            style: TextStyle(
                              color: Color(0xFF292929),
                              fontSize: 20,
                              fontFamily: 'Hanken Grotesk',
                              fontWeight: FontWeight.w400,
                              height: 0.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PreferenceContainers(
                  title: customHankenText('SHOW ME', kcBlack, 16,
                      FontWeight.w400, TextAlign.center),
                  radius: 16,
                  trailing: Row(
                    children: [
                      Obx(() => Text(
                            getGenderString(controller.showMeGender.value),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: controller.onGenderChangeCallback,
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 36,
                          color: kcBlack,
                          weight: 1,
                        ),
                      ),
                    ],
                  ),
                  isborder: true,
                ),
                PreferenceContainers(
                  title: customHankenText('DISTANCE', kcBlack, 16,
                      FontWeight.w400, TextAlign.center),
                  radius: 16,
                  trailing: PreferenceContainers(
                    title: Text(
                      'Within ${controller.distanceLimit.value.ceil()}km',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    radius: 12,
                    isborder: true,
                  ),
                  bottom: Column(
                    children: [
                      SfSlider(
                        value: controller.distanceLimit.value,
                        onChanged: controller.onDistanceChange,
                        max: maxDistance,
                        min: minDistance,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey.withOpacity(0.5),
                        thumbIcon: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      PreferenceContainers(
                        title: customHankenText('AGE', kcBlack, 16,
                            FontWeight.w400, TextAlign.center),
                        radius: 16,
                        mHorizontal: 0,
                        trailing: PreferenceContainers(
                          title: Text(
                            '${controller.lAgeLimit.value.toInt()}-${controller.uAgeLimit.value.toInt()} Years',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          radius: 12,
                          isborder: true,
                        ),
                        isborder: false,
                      ),
                    ],
                  ),
                  isborder: true,
                ),
                Container(
                  width: Get.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.6), width: 1.7),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white70),
                  child: Column(
                    children: [
                      Obx(
                        () => KSliderTile(
                          title: 'Distance',
                          slider: SfSlider(
                            value: controller.distanceLimit.value,
                            onChanged: controller.onDistanceChange,
                            max: maxDistance,
                            min: minDistance,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey.withOpacity(0.5),
                            thumbIcon: const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          subtitle:
                              'Upto ${controller.distanceLimit.value.ceil()} kilometers away',
                        ),
                      ),
                      Obx(
                        () => KSliderTile(
                          title: 'Age',
                          slider: SfRangeSlider(
                            values: SfRangeValues(controller.lAgeLimit.value,
                                controller.uAgeLimit.value),
                            onChanged: controller.onAgeChange,
                            max: maxAge,
                            min: minAge,
                            interval: maxAge - minAge,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey.withOpacity(0.5),
                            startThumbIcon: const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 20,
                            ),
                            endThumbIcon: const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          subtitle:
                              'Between ${controller.lAgeLimit.value.toInt()} to ${controller.uAgeLimit.value.toInt()}',
                        ),
                      ),
                    ],
                  ),
                ),
                // if (Congle.currentUser!.interests != null)
                //   KListTile(
                //     child: TitleNContent(
                //       title: 'Interests',
                //       child: Wrap(
                //         runSpacing: 5,
                //         spacing: 5,
                //         children: [
                //           for (var interest in Congle.currentUser!.interests!)
                //             Obx(() => KFilterChip(
                //                   text: interest,
                //                   onSelected: (val) =>
                //                       controller.addOrRemoveIntrest(interest),
                //                   isSelected: controller.selectedIntrests
                //                       .contains(interest),
                //                 )),
                //         ],
                //       ),
                //     ),
                //   ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
