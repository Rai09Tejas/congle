import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data.dart';

class FollowClubContainer extends StatelessWidget {
  FollowClubContainer({
    Key? key,
    required this.club,
    this.bgColor = kcBg,
  }) : super(key: key);

  final ShortClub club;
  final Color bgColor;

  final RxBool isFollowed = false.obs;
  Future<void> onFollowToggle() async {
    await Get.find<ClubApi>().followClubByID(club.id);
    isFollowed.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ClubDetailsScreen(id: club.id)),
      child: Container(
        width: 140,
        height: 185,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(17.0),
          boxShadow: [
            BoxShadow(
              color: kcLightGrey.withOpacity(0.4),
              offset: const Offset(3, 4),
              spreadRadius: 1,
              blurRadius: 3,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              club.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyText1!.copyWith(color: Colors.black),
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(club.dp),
              backgroundColor: Get.theme.backgroundColor,
            ),
            Text(
              club.about,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Get.textTheme.bodyText2!.copyWith(color: Colors.black),
            ),
            Obx(() => AnimatedContainer(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          ],
        ),
      ),
    );
  }
}
