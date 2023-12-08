import 'package:congle/app/data/data.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen(
      {Key? key, this.profile, this.mainButton, this.secButton, this.id})
      : assert(id != null || profile != null),
        super(key: key);
  final AboutUser? profile;
  final KButton? mainButton;
  final KOutlineButton? secButton;
  final String? id;

  // final RxBool isFollowed = false.obs;
  // void onFollowToggle() => isFollowed.toggle();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile?>(
        future: profile != null
            ? Future.value(Profile(aboutUser: profile!))
            : Get.find<ProfileApi>().getProfileByID(id!),
        builder: (context, snapshot) {
          // print(snapshot.connectionState);
          if (snapshot.connectionState != ConnectionState.done &&
              !snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                      )),
                  actions: const [
                    // IconButton(
                    //     onPressed: () {

                    //     },
                    //     icon: Icon(
                    //       Icons.more_vert_rounded,
                    //       color: Colors.black,
                    //     )),
                  ],
                  elevation: 0,
                ),
                body: const LoadingDots.long());
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
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
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert_rounded,
                          color: Colors.black,
                        )),
                  ],
                  elevation: 0,
                ),
                body: const EmptyWidget(title: 'Profile Not Found!'));
          }
          final Profile profile = snapshot.data!;
          // if (profile.isFollowing) isFollowed.toggle();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  )),
              title: Text(
                profile.aboutUser.username,
                style: Get.textTheme.bodyText2!.copyWith(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                        KMoreOptionSheet(
                          tiles: [
                            SheetOptionTile(() {}, 'Hide Profile'),
                            SheetOptionTile(() {}, 'Block & Report', true)
                          ],
                        ),
                        backgroundColor: Colors.transparent,
                      );
                    },
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.black,
                    )),
              ],
              elevation: 0,
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KListTile(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10),
                              ProfileImageContainer(
                                  image: NetworkImage(profile.aboutUser.dp)),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile.aboutUser.name,
                                      style: Get.textTheme.headline6,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Age',
                                              style: Get.textTheme.bodyText2,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "${profile.aboutUser.age}",
                                              style: Get.textTheme.bodyText1,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Obx(() => AnimatedContainer(
                        //       margin: EdgeInsets.symmetric(
                        //           horizontal: 10, vertical: 5),
                        //       duration: 1000.milliseconds,
                        //       child: isFollowed.value
                        //           ? KButton(
                        //               title: 'Following',
                        //               textColor: Colors.white,
                        //               onPressed: onFollowToggle,
                        //             )
                        //           : KOutlineButton(
                        //               title: 'Follow',
                        //               onPressed: onFollowToggle,
                        //               isTextWhite: false,
                        //             ),
                        //     )),
                        KListTile(
                          child: Column(
                            children: [
                              if (profile.aboutUser.about != null)
                                TitleNContent(
                                  title: 'About',
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      profile.aboutUser.about!,
                                      style: Get.textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              if (profile.aboutUser.jobTitle != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          profile.aboutUser.jobTitle!,
                                          style: Get.textTheme.caption,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: KSvgIcon(
                                          assetName: svg_location,
                                          fit: BoxFit.contain,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        '${profile.distance} KM away',
                                        style: Get.textTheme.caption,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (profile.aboutUser.interests != null &&
                                  profile.aboutUser.interests!.isNotEmpty)
                                const SizedBox(height: 10),
                              if (profile.aboutUser.interests != null &&
                                  profile.aboutUser.interests!.isNotEmpty)
                                TitleNContent(
                                  title: 'Interests',
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    alignment: Alignment.centerLeft,
                                    child: Wrap(
                                      runSpacing: 5,
                                      spacing: 5,
                                      children: [
                                        for (var interest
                                            in profile.aboutUser.interests!)
                                          KFilterChip(
                                            text: interest,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child:
                              PhotoDisplayContainer(profile: profile.aboutUser),
                        ),

                        // if (profile.aboutUser.clubs != null &&
                        //     profile.aboutUser.clubs!.length > 0)
                        //   SizedBox(height: 10),
                        // if (profile.aboutUser.clubs != null &&
                        //     profile.aboutUser.clubs!.length > 0)
                        //   KListTile(
                        //       child: TitleNContent(
                        //     title: 'Clubs Following',
                        //     child: Container(
                        //       width: Get.width,
                        //       height: 75,
                        //       child: ListView.builder(
                        //         scrollDirection: Axis.horizontal,
                        //         itemCount: profile.aboutUser.clubs!.length,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           ShortClub club =
                        //               profile.aboutUser.clubs![index];
                        //           return ProfileImageContainer(
                        //             onTap: () => Get.to(
                        //                 () => ClubDetailsScreen(id: club.id)),
                        //             image: NetworkImage(club.dp),
                        //             size: 65,
                        //             borderRadius: 50,
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //     trailing: (profile.aboutUser.clubs!.length >= 5)
                        //         ? Text(
                        //             'See All',
                        //             style: Get.textTheme.bodyText2!.copyWith(
                        //                 color: Get.theme.colorScheme.secondary),
                        //           )
                        //         : null,
                        //   )),

                        if (profile.aboutUser.linkedin != null)
                          TitleNContent(
                            title:
                                'Visit ${profile.aboutUser.name.split(' ')[0]}\'s LinkedIn',
                            titleIcon: const KSvgIcon(
                              assetName: svg_linkedin,
                              size: 18,
                            ),
                            trailing: InkWell(
                                onTap: () async => await canLaunch(
                                        profile.aboutUser.linkedin!)
                                    ? await launch(profile.aboutUser.linkedin!)
                                    : throw 'Could not launch ${profile.aboutUser.linkedin!}',
                                child: const Icon(Icons.open_in_new_rounded)),
                          ),
                        if (profile.aboutUser.instagram != null &&
                            profile.aboutUser.instagram!.posts != null)
                          TitleNContent(
                            title: 'Instagram Profile',
                            titleIcon: const KSvgIcon(
                              assetName: svg_instagram,
                              size: 18,
                            ),
                            child: SizedBox(
                              height: Get.width * 0.65,
                              width: Get.width,
                              child: KInstagramContainer(
                                  instaProfile: profile.aboutUser.instagram,
                                  isDialog: false),
                            ),
                          ),
                        if (profile.aboutUser.spotify != null &&
                            profile.aboutUser.spotify!.recentSongs != null)
                          TitleNContent(
                            title: 'Spotify Profile',
                            titleIcon: const KSvgIcon(
                              assetName: svg_spotify,
                              size: 18,
                            ),
                            child: SizedBox(
                                height: Get.height * 0.5,
                                width: Get.width,
                                child: KSpotifyContainer(
                                    spotify: profile.aboutUser.spotify,
                                    isDialog: false)),
                          ),

                        // SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      if (secButton != null)
                        Expanded(
                            child: SizedBox(height: 40, child: secButton!)),
                      if (secButton != null && mainButton != null)
                        const SizedBox(
                          width: 5,
                        ),
                      if (mainButton != null)
                        Expanded(
                            child: SizedBox(height: 40, child: mainButton!)),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
