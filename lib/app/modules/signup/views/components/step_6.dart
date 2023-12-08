import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/data/widgets/texts/custom_texts.dart';
import 'package:hexagon/hexagon.dart';
import '../../../../data/models/others/new_interest_list.dart';
import '../../controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step6 extends GetView<SignupController> {
  Step6({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  final SignupController controller;

  var index = 0;

  InterestCategory? getDataForCoordinates(int index) {
    if (index >= 0 && index < 28) {
      return controller.dataList[index];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            customHeadingText("${controller.isInterestsUpdated.value}", kcBlack,
                24, FontWeight.w700),
            customHeadingText(
                "Let’s Find Your Tribe", kcBlack, 24, FontWeight.w700),
            const SizedBox(
              height: 16,
            ),
            customHankenText(
                "Let us know your favourite interests, and we'll help you\nconnect with others who share the same passions. ",
                kcBlack,
                14,
                FontWeight.w300,
                TextAlign.center),
            const SizedBox(
              height: 48,
            ),
            customHeadingText(
                "What makes you happy?", kcBlack, 20, FontWeight.w700),
            SizedBox(
                height: Get.height * 0.45,
                child: InteractiveViewer(
                  transformationController: controller.transformationController,
                  minScale: 3,
                  maxScale: 3,
                  constrained: false,
                  child: HexagonGrid.pointy(
                      color: kcOffwhiteBg,
                      depth: 3,
                      width: 300,
                      buildTile: (coordinates) {
                        final InterestCategory? data =
                            getDataForCoordinates(index++);
                        return HexagonWidgetBuilder(
                          padding: 0.0,
                          cornerRadius: 8.0,
                          color: kcOffwhiteBg,
                          child: GestureDetector(
                              onTap: () {
                                if (controller.myInterests.contains(data)) {
                                  controller.removeInterest(data!);
                                } else {
                                  controller.addInterest(data!);
                                }
                                controller.checkInterests();
                              },
                              child: data != null
                                  ? Obx(
                                      () => Container(
                                        width: 150,
                                        height: 150,
                                        decoration: ShapeDecoration(
                                          color: controller.myInterests
                                                  .contains(data)
                                              ? kcGreen
                                              : const Color(0xFFE6E6E6),
                                          shape: const CircleBorder(
                                              side: BorderSide(width: 0.3)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          data.interest,
                                          style: const TextStyle(fontSize: 6),
                                        )),
                                      ),
                                    )
                                  : Container()),
                        );
                      }),
                )),
          ],
        ));
  }
}
