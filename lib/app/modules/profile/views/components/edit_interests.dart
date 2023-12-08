import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/models/others/new_interest_list.dart';
import 'package:congle/app/modules/profile/controllers/edit_profile_controller.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditInterests extends StatelessWidget {
  const EditInterests({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's your\nthing?",
                    style:
                        Get.textTheme.displaySmall!.copyWith(color: kcAccent),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Select minimum 5 from these categories that describes your interests & experience.",
                    style: Get.textTheme.bodyMedium!.copyWith(color: kcBlack),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<InterestCategory>>(
                  future: controller.getInterests(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const LoadingDots();
                    List<InterestCategory> data = snapshot.data!;
                    if (data.isEmpty) data = demoInterestsList.toList();

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        InterestCategory item = data[index];
                        return TitleNContent(
                          isBold: true,
                          title: item.interest.capitalizeFirst!,
                          fontSize: 14,
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: const Wrap(
                              runSpacing: 5,
                              spacing: 5,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              runAlignment: WrapAlignment.start,
                              children: [
                                // for (var interest in item.list)
                                //   Obx(() => KFilterChip(
                                //         text: interest,
                                //         color: kcBgAccent,
                                //         isSelected: controller.interests
                                //             .contains(interest),
                                //         onSelected: (val) => val
                                //             ? controller.interests.add(interest)
                                //             : controller.interests
                                //                 .remove(interest),
                                //       )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
            const SizedBox(height: 10),
            KButton(
              title: 'Continue',
              onPressed: () => Get.back(),
              fontSize: 20,
              padding: const EdgeInsets.all(15),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
