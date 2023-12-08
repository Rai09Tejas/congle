import 'package:congle/app/data/data.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NoMatchLeft extends StatelessWidget {
  const NoMatchLeft({
    Key? key,
    required this.onButtonPress,
  }) : super(key: key);

  final Function() onButtonPress;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //   height: 90.0,
          //   width: 90.0,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(100))),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(120.0),
          //     child: CachedNetworkImage(
          //       // aboutUser.photos[0] ??
          //       imageUrl:
          //           'https://images.unsplash.com/photo-1581803118522-7b72a50f7e9f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8bWFufGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
          //       // 'assets/profilepic.jpg',
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          ProfileImageContainer(image: NetworkImage(Congle.currentUser!.dp)),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Hey, ${Congle.currentUser!.name}',
            style: Get.textTheme.headline6!
                .copyWith(color: Get.theme.colorScheme.secondary),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "You have Viewed all nearby people.\nCome back later or modify your preferences.",
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyText1,
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: onButtonPress,
            style: ElevatedButton.styleFrom(
              onPrimary: Get.theme.colorScheme.secondary,
              primary: Colors.white,
              onSurface: Colors.grey,
              elevation: 0,
              minimumSize: const Size(200, 40),
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
            ),
            child: Text(
              'Change my Preferences',
              style: Get.textTheme.button!.copyWith(color: Colors.black),
            ).paddingSymmetric(horizontal: 10),
          ),
        ],
      ),
    );
  }
}
