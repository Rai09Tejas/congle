import 'package:congle/packages/packages.dart';
import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  final Function? ibutton;
  final Function? instaButton;
  final Function? spotifyButton;
  final bool isSecond;
  final double? opacity;
  final String? text;
  final bool? direction;

  /// right for true & left for false

  const ProfileCard(
      {Key? key,
      required this.profile,
      this.ibutton,
      this.isSecond = false,
      this.opacity,
      this.text,
      this.direction,
      this.instaButton,
      this.spotifyButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          )
        ],
        color: const Color(0xffF6E4F2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45.0),
        child: Material(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              PhotoBrowser(
                photoAssetPaths: profile.aboutUser.photos,
                visiblePhotoIndex: 0,
              ),
              ProfileSynopsis(ibutton: ibutton, profile: profile),
              Positioned(
                  top: 50,
                  left: 50,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: Padding(
                                padding: EdgeInsets.all(2),
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundColor: kcGreen,
                                )),
                          ),
                          const SizedBox(width: 2),
                          AutoSizeText(
                            'Active Now', //change need to integrate backend
                            style: Get.textTheme.bodySmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                            // maxFontSize: 20,
                          ),
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: KSvgIcon(
                                assetName: svg_location,
                                fit: BoxFit.contain,
                                // size: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          AutoSizeText(
                            '${profile.distance} KM away',
                            style: Get.textTheme.bodySmall!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                            // maxFontSize: 20,
                          ),
                        ],
                      ),
                    ],
                  )),
              if (!isSecond)
                Positioned(
                  top: 60,
                  right: 10,
                  child: Column(
                    children: [
                      if (profile.aboutUser.instagram != null)
                        IconButton(
                          icon: const KSvgIcon(
                            assetName: svg_instagram,
                            size: 25,
                            color: kcLameGrey,
                          ),
                          splashColor: Get.theme.colorScheme.secondary,
                          onPressed: instaButton as void Function()?,
                        ),
                      if (profile.aboutUser.spotify != null)
                        IconButton(
                          icon: const KSvgIcon(
                            assetName: svg_spotify,
                            size: 25,
                            color: kcLameGrey,
                          ),
                          splashColor: Get.theme.colorScheme.secondary,
                          onPressed: spotifyButton as void Function()?,
                        ),
                      if (profile.aboutUser.linkedin != null)
                        IconButton(
                          icon: const KSvgIcon(
                            assetName: svg_linkedin,
                            size: 25,
                            color: kcLameGrey,
                          ),
                          splashColor: Get.theme.colorScheme.secondary,
                          onPressed: () async => await canLaunch(
                                  profile.aboutUser.linkedin!)
                              ? await launch(profile.aboutUser.linkedin!)
                              : showSnackBar(
                                  'Could not launch ${profile.aboutUser.linkedin!}',
                                  isError: true),
                        ),
                    ],
                  ),
                ),
              if (!isSecond && (opacity ?? 1) > 0)
                Positioned(
                  top: 10,
                  right: direction! ? null : 10,
                  left: direction! ? 10 : null,
                  child: Opacity(
                    alwaysIncludeSemantics: true,
                    opacity: opacity!,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          direction! ? kcGreen : Get.theme.colorScheme.error,
                      child: KSvgIcon(
                        assetName:
                            direction! ? svg_check_outline : svg_cross_outline,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSynopsis extends StatelessWidget {
  const ProfileSynopsis({
    Key? key,
    required this.ibutton,
    required this.profile,
  }) : super(key: key);

  final Function? ibutton;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: GestureDetector(
        onTap: ibutton as void Function()?,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.9),
              ],
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Row(
            // mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 40),
                        Text(
                          '${profile.aboutUser.name.toString().split(' ')[0]}/ ${profile.aboutUser.age}',
                          style: const TextStyle(
                            color: Color(0xFFF0F0F0),
                            fontSize: 32,
                            fontFamily: 'Test Domaine Display',
                            fontWeight: FontWeight.w400,
                            height: 0.03,
                          ),
                        ),
                      ],
                    ),
                    if (profile.aboutUser.jobTitle != null)
                      const SizedBox(
                        height: 5,
                      ),
                    if (profile.aboutUser.jobTitle != null)
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Icon(
                                Icons.work,
                                color: Get.theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              profile.aboutUser.jobTitle!.replaceAll('at', '@'),
                              style: const TextStyle(
                                color: Color(0xFFF0F0F0),
                                fontSize: 16,
                                fontFamily: 'Hanken Grotesk',
                                fontWeight: FontWeight.w300,
                                height: 0.12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              // maxFontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 5),
                child: KSvgIcon(
                  assetName: svg_info_button, //change icon here
                  color: Colors.white54,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
