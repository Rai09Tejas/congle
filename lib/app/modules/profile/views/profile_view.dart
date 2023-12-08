import 'package:congle/app/data/data.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:congle/packages/loading_dots/loading_dots.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<ProfileController>(ProfileController());
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      controller.profile.username,
                      style: Get.textTheme.bodyText2!.copyWith(
                          fontSize: 18, fontWeight: FontWeight.normal),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: controller.settings,
                    icon: KSvgIcon(
                      assetName: svg_settings,
                      color: Get.theme.focusColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  GetBuilder<ProfileController>(
                    init: ProfileController(),
                    initState: (_) {},
                    builder: (_) {
                      return ProfileImageContainer(
                          image: NetworkImage(_.profile.dp),
                          showBorder: true,
                          bottomCornerWidget: Obx(
                            () => Text('${_.percentage.value}%',
                                style: Get.textTheme.caption!.copyWith(
                                    fontSize: 9, color: Colors.white)),
                          ));
                    },
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          '${controller.profile.name}, ${controller.profile.age}',
                          style: Get.textTheme.headline6,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (controller.profile.jobTitle != null)
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                                child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.work,
                                    size: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  controller.profile.jobTitle!,
                                  style: Get.textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Obx(() => controller.isLoading.isTrue
                              ? const LoadingDots.long()
                              : KButton(
                                  title: 'Edit Profile',
                                  leading: const Icon(
                                    Icons.edit,
                                    color: Colors.black87,
                                  ),
                                  textColor: Colors.black87,
                                  solidColor:
                                      Get.theme.cardColor.withOpacity(0.7),
                                  onPressed: () =>
                                      Get.toNamed(Routes.EDIT_PROFILE))),
                        ),
                        // Row(
                        //   children: [
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           FormatNumber(controller.profile.followers),
                        //           style: Get.textTheme.bodyText1,
                        //         ),
                        //         Text(
                        //           'Followers',
                        //           style: Get.textTheme.bodyText2,
                        //         ),
                        //       ],
                        //     ),
                        //     SizedBox(width: 20),
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           FormatNumber(controller.profile.following),
                        //           style: Get.textTheme.bodyText1,
                        //         ),
                        //         Text(
                        //           'Following',
                        //           style: Get.textTheme.bodyText2,
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              if (controller.profile.about != null) const SizedBox(height: 10),
              if (controller.profile.about != null)
                TitleNContent(
                    title: 'About',
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(controller.profile.about!,
                            // maxLines: 4,
                            style: Get.textTheme.bodyText2,
                            overflow: TextOverflow.clip),
                      ),
                    )),
              if (controller.profile.interests != null &&
                  controller.profile.interests!.isNotEmpty)
                const SizedBox(height: 10),
              if (controller.profile.interests != null &&
                  controller.profile.interests!.isNotEmpty)
                TitleNContent(
                  title: 'Interests',
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: [
                        for (var interest in controller.profile.interests!)
                          KFilterChip(
                            text: interest,
                            color: kcWhite,
                          ),
                      ],
                    ),
                  ),
                ),
              if (controller.profile.photos != null &&
                  controller.profile.photos!.isNotEmpty)
                const SizedBox(height: 10),
              if (controller.profile.photos != null &&
                  controller.profile.photos!.isNotEmpty)
                GetBuilder<ProfileController>(
                  init: ProfileController(),
                  initState: (_) {},
                  builder: (_) {
                    return PhotoDisplayContainer(profile: _.profile);
                  },
                ),
              // if (controller.profile.clubs != null &&
              //     controller.profile.clubs!.length > 0)
              //   SizedBox(height: 10),
              // if (controller.profile.clubs != null &&
              //     controller.profile.clubs!.length > 0)
              //   KListTile(
              //       child: TitleNContent(
              //     title: 'Clubs Following',
              //     child: Container(
              //       width: Get.width,
              //       height: 75,
              //       child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: controller.profile.clubs!.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           ShortClub club = controller.profile.clubs![index];
              //           return ProfileImageContainer(
              //             onTap: () =>
              //                 Get.to(() => ClubDetailsScreen(id: club.id)),
              //             image: NetworkImage(club.dp),
              //             size: 65,
              //             borderRadius: 50,
              //           );
              //         },
              //       ),
              //     ),
              //     trailing: (controller.profile.clubs!.length >= 5)
              //         ? Text(
              //             'See All',
              //             style: Get.textTheme.bodyText2!
              //                 .copyWith(color: Get.theme.colorScheme.secondary),
              //           )
              //         : null,
              //   )),
              const SizedBox(
                height: 10,
              ),
              KListTile(
                title: (controller.profile.linkedin != null)
                    ? 'Your LinkedIn Profile'
                    : 'Connect Your LinkedIn',
                titleStyle: (controller.profile.linkedin != null)
                    ? Get.textTheme.headline6!.copyWith(color: Colors.white)
                    : null,
                color: (controller.profile.linkedin != null)
                    ? Get.theme.colorScheme.secondary
                    : Get.theme.cardColor,
                leading: SizedBox(
                  width: 35,
                  child: KSvgIcon(
                    assetName: svg_linkedin,
                    size: 25,
                    color: (controller.profile.linkedin != null)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                trailing: (controller.profile.linkedin != null)
                    ? null
                    : InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: KSvgIcon(
                            assetName: svg_add,
                            color: Get.theme.focusColor,
                            size: 25,
                          ),
                        ),
                      ),
              ),
              KListTile(
                title: (controller.profile.instagram != null)
                    ? 'Your Instagram Profile'
                    : 'Connect Your Instagram',
                leading: const SizedBox(
                  width: 35,
                  child: KSvgIcon(
                    assetName: svg_instagram,
                    size: 25,
                  ),
                ),
                trailing: (controller.profile.instagram != null)
                    ? null
                    : InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: KSvgIcon(
                            assetName: svg_add,
                            color: Get.theme.focusColor,
                            size: 25,
                          ),
                        ),
                      ),
              ),
              if (controller.profile.instagram == null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Connecting to Instagram will add your latest posts to your controller.profile. Your username won't be visible.",
                    style: Get.textTheme.caption,
                  ),
                ),
              if (controller.profile.instagram != null)
                SizedBox(
                    height: Get.width * 0.8,
                    child: KInstagramContainer(
                      instaProfile: sample_instagram,
                      isDialog: false,
                    )),
              KListTile(
                title: (controller.profile.spotify != null)
                    ? 'Your Spotify Profile'
                    : 'Connect Your Spotify',
                leading: const SizedBox(
                  width: 35,
                  child: KSvgIcon(
                    assetName: svg_spotify,
                    size: 25,
                  ),
                ),
                trailing: (controller.profile.spotify != null)
                    ? null
                    : InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: KSvgIcon(
                            assetName: svg_add,
                            color: Get.theme.focusColor,
                            size: 25,
                          ),
                        ),
                      ),
              ),
              if (controller.profile.spotify != null)
                SizedBox(
                    height: Get.height * 0.5,
                    child: KSpotifyContainer(
                      spotify: sample_spotify,
                      isDialog: false,
                    )),
              if (controller.profile.spotify == null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Connect your Spotify account to add your favourite artists to your profile . Your recent played will be selected based on your stream on Spotify.",
                    style: Get.textTheme.caption,
                  ),
                ),
              const SizedBox(
                height: bottomNavBarHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
