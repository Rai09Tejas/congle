import 'dart:io';

import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/profile/controllers/edit_profile_controller.dart';
import 'package:congle/packages/loading_dots/loading_dots.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'components/edit_interests.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(() => EditProfileController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        actions: [
          Obx(() => controller.isSaving.value
              ? const LoadingDots(color: kcAccent)
              : Container(
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: KButton(
                      title: 'Save', onPressed: controller.onProfileSave),
                ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              GetBuilder<EditProfileController>(
                init: EditProfileController(),
                initState: (_) {},
                builder: (_) {
                  return Align(
                    alignment: Alignment.center,
                    child: _.dpImage == null
                        ? ProfileImageContainer(
                            image: NetworkImage(_.profile.dp),
                            onTap: _.addDP,
                            showBorder: true,
                            bottomCornerWidget: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          )
                        : ProfileImageContainer(
                            image: FileImage(File(_.dpImage!.path)),
                            onTap: _.addDP,
                            showBorder: true,
                            bottomCornerWidget: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Change your Display Picture',
                  style: Get.textTheme.bodyText2,
                ),
              ),
              const SizedBox(height: 10),
              GetBuilder<EditProfileController>(
                init: EditProfileController(),
                initState: (_) {},
                builder: (_) {
                  return TitleNContent(
                    title: 'Edit your Photos',
                    child: KListTile(
                      child: SizedBox(
                        width: Get.width,
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            for (var i = 0; i < 6; i++)
                              ProfileImageContainer(
                                onTap: _.imageList.length <= i
                                    ? _.addOtherImage
                                    : null,
                                size: (Get.width * 0.25).clamp(50.0, 200.0),
                                image: _.imageList.length <= i
                                    ? null
                                    : FileImage(File(_.imageList[i].path)),
                                showBorder: true,
                                bottomCornerWidget: _.imageList.length <= i
                                    ? null
                                    : InkWell(
                                        onTap: () => controller
                                            .removeImage(_.imageList[i]),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              TitleNContent(
                title: 'About',
                child: GetBuilder<EditProfileController>(
                  init: EditProfileController(),
                  initState: (_) {},
                  builder: (_) {
                    return KTextField(
                      hintText:
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctu',
                      maxLines: 3,
                      fontSize: 16,
                      controller: _.aboutController,
                    );
                  },
                ),
              ),
              GetBuilder<EditProfileController>(
                init: EditProfileController(),
                initState: (_) {},
                builder: (_) {
                  return TitleNContent(
                    title: 'My Interests',
                    child: GestureDetector(
                      onTap: () =>
                          Get.to(() => EditInterests(controller: controller)),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.0),
                          color: Get.theme.cardColor,
                        ),
                        child: _.interests.isNotEmpty
                            ? Obx(() => Wrap(
                                  runSpacing: 5,
                                  spacing: 5,
                                  children: [
                                    for (var interest in _.interests)
                                      KFilterChip(
                                        text: interest,
                                      ),
                                  ],
                                ))
                            : Text(
                                'Add Some Interests to your profile',
                                style: Get.textTheme.bodyText2,
                              ),
                      ),
                    ),
                  );
                },
              ),
              GetBuilder<EditProfileController>(
                init: EditProfileController(),
                initState: (_) {},
                builder: (_) {
                  return TitleNContent(
                    title: 'Work',
                    child: KTextField(
                      maxLines: 1,
                      hintText: 'Studying at IIMB',
                      fontSize: 18,
                      controller: _.workController,
                    ),
                  );
                },
              ),
              const SizedBox(height: bottomNavBarHeight),
            ],
          ),
        ),
      ),
    );
  }
}
