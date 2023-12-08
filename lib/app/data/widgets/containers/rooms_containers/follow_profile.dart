import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data.dart';

class FollowProfileTile extends StatelessWidget {
  FollowProfileTile({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final ShortProfile profile;

  final RxBool isFollowed = false.obs;
  void onFollowToggle() => isFollowed.toggle();

  @override
  Widget build(BuildContext context) {
    return KListTile(
      onTap: () => Get.to(() => ProfileDetailsScreen(id: profile.id)),
      leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(profile.dp),
          backgroundColor: Get.theme.backgroundColor),
      title: profile.name,
      titleStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.black),
      subtitle: profile.work,
      trailing: Obx(() => AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            duration: 400.milliseconds,
            width: isFollowed.value ? 100 : 80,
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
    );
  }
}

class FollowProfileContainer extends StatelessWidget {
  FollowProfileContainer({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final ShortProfile profile;

  final RxBool isFollowed = false.obs;
  void onFollowToggle() => isFollowed.toggle();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ProfileDetailsScreen(id: profile.id)),
      borderRadius: BorderRadius.circular(17.0),
      child: Container(
        width: 140,
        height: 185,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.fromLTRB(10, 10, 5, 10),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
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
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(profile.dp),
              backgroundColor: Get.theme.backgroundColor,
            ),
            Text(
              profile.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyText1!.copyWith(color: Colors.black),
            ),
            Text(
              '30 Followers',
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
