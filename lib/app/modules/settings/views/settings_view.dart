import 'package:congle/app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _kSvgAddIcon = KSvgIcon(
      assetName: svg_add,
      color: Get.theme.focusColor,
      size: 25,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  'Settings',
                  style: Get.textTheme.headline1,
                ),
              ),
              // KListTile(
              //   title: 'Hide Your Profile From Congle Social',
              //   titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
              //   trailing: Obx(() => CupertinoSwitch(
              //         activeColor: Get.theme.colorScheme.secondary,
              //         onChanged: controller.toggleShowMyProfileSwitch,
              //         value: controller.hideProfile.value,
              //       )),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //   child: Text(
              //     'Your Profile Would Still Be Visible To Others In Congle Rooms',
              //     style: Get.textTheme.caption,
              //   ),
              // ),
              KListTile(
                color: Colors.transparent,
                title: 'App Notifications',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: Obx(() => CupertinoSwitch(
                      activeColor: Get.theme.colorScheme.secondary,
                      onChanged: controller.toggleShowNotificationSwitch,
                      value: controller.showNotification.value,
                    )),
              ),
              KListTile(
                title: 'Community Guidelines',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: Icon(
                  Icons.open_in_new,
                  size: 30,
                  color: Get.theme.focusColor,
                ),
              ),
              KListTile(
                title: 'Terms of Service',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: Icon(
                  Icons.open_in_new,
                  size: 30,
                  color: Get.theme.focusColor,
                ),
              ),
              KListTile(
                title: 'Privacy Policy',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: Icon(
                  Icons.open_in_new,
                  size: 30,
                  color: Get.theme.focusColor,
                ),
              ),
              KListTile(
                title: 'Contact Us',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: Icon(
                  Icons.open_in_new,
                  size: 30,
                  color: Get.theme.focusColor,
                ),
              ),
              KListTile(
                title: 'Invite Friends',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: InkWell(
                  child: Icon(
                    Icons.share,
                    size: 30,
                    color: Get.theme.focusColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text('Accounts',
                    style: Get.textTheme.bodyText1!
                        .copyWith(color: Colors.black, fontSize: 16)),
              ),
              KListTile(
                title: controller.isLinkedinAvailable()
                    ? 'Disconnect Your LinkedIn'
                    : 'Connect Your LinkedIn',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: InkWell(
                  child:
                      controller.isLinkedinAvailable() ? kiCross : _kSvgAddIcon,
                  onTap: controller.isLinkedinAvailable()
                      ? controller.unlinkLinkedIn
                      : controller.linkLinkedIn,
                ),
              ),
              KListTile(
                title: controller.isInstagramAvailable()
                    ? 'Disconnect Your Instagram'
                    : 'Connect Your Instagram',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: InkWell(
                  child: controller.isInstagramAvailable()
                      ? kiCross
                      : _kSvgAddIcon,
                  onTap: controller.isInstagramAvailable()
                      ? controller.unlinkInstagram
                      : controller.linkInstagram,
                ),
              ),
              KListTile(
                title: controller.isSpotifyAvailable()
                    ? 'Disconnect Your Spotify'
                    : 'Connect Your Spotify',
                titleStyle: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                trailing: InkWell(
                  child:
                      controller.isSpotifyAvailable() ? kiCross : _kSvgAddIcon,
                  onTap: controller.isSpotifyAvailable()
                      ? controller.unlinkSpotify
                      : controller.linkSpotify,
                ),
              ),
              KListTile(
                child: Center(
                    child: Text(
                  'Log Out',
                  style: Get.textTheme.headline6,
                )),
                onTap: controller.logout,
              ),
              KListTile(
                child: Center(
                    child: Text(
                  'Delete Account',
                  style: Get.textTheme.headline6!
                      .copyWith(color: Get.theme.errorColor),
                )),
                onTap: controller.deleteAccountDetails,
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: KSvgIcon(
                assetName: svg_logo,
                size: 35,
              )),
              Center(
                child: Text(
                  'Version 2.0.1',
                  style: Get.textTheme.caption!.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
