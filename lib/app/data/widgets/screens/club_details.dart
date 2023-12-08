import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data.dart';

class ClubDetailsScreen extends StatelessWidget {
  ClubDetailsScreen({
    Key? key,
    this.club,
    this.id,
  })  : assert(id != null || club != null),
        super(key: key);
  final AboutClub? club;
  final String? id;

  final RxBool isFollowed = false.obs;
  void onFollowToggle() => isFollowed.toggle();

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<AboutClub?>(
          future: id != null
              ? Get.find<ClubApi>().getClubByID(id!)
              : Future.value(club),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LoadingDots.long();
            // if (snapshot.hasError)
            //   return EmptyWidget(title: 'Profile Not Found!');
            final AboutClub club = snapshot.data!;
            Get.log(club.toString());

            return SingleChildScrollView(
              child: Column(
                children: [
                  KListTile(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(club.dp),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                club.name,
                                style: Get.textTheme.headline6,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    FormatNumber(club.followersCount),
                                    style: Get.textTheme.bodyText1,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Followers',
                                    style: Get.textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => AnimatedContainer(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        duration: 1000.milliseconds,
                        child: isFollowed.value
                            ? KButton(
                                title: 'Following',
                                textColor: Colors.white,
                                onPressed: onFollowToggle,
                              )
                            : KOutlineButton(
                                title: 'Follow',
                                onPressed: onFollowToggle,
                                isTextWhite: false,
                              ),
                      )),
                  KListTile(
                    child: Column(
                      children: [
                        TitleNContent(
                          title: 'About',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              club.about,
                              style: Get.textTheme.bodyText2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TitleNContent(
                          title: 'Interests',
                          child: Wrap(
                            runSpacing: 5,
                            spacing: 5,
                            children: [
                              for (var interest in club.tags)
                                KFilterChip(
                                  text: interest,
                                  color: Colors.white,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        TitleNContent(
                          title: 'Club Information',
                          child: KListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(club.creator.dp),
                              radius: 25,
                            ),
                            title: club.creator.name,
                            subtitle:
                                'Created on ${DateFormat.yMMMMd().format(club.creationDate)}',
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (club.followersCount > 0)
                    TitleNContent(
                      title: 'Followers | ${club.followersCount}',
                      child: FutureBuilder<List<ShortProfile>>(
                        future:
                            Get.find<ClubApi>().getFollowersByClubID(club.id),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) const LoadingDots.long();
                          if (snapshot.data == null) {
                            return const EmptyWidget(title: 'No Followers Yet');
                          }
                          List<ShortProfile> profiles = snapshot.data;
                          if (profiles.isEmpty) {
                            return const EmptyWidget(title: 'No Followers Yet');
                          }
                          return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              ShortProfile profile = profiles[index];
                              return FollowProfileTile(profile: profile);
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
