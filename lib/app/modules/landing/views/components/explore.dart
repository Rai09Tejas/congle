import 'package:congle/app/data/config/config.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';
import 'package:congle/app/modules/home/controllers/home_controller.dart';
import 'package:congle/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/widgets/tags/tags.dart';

class ExploreTabs extends StatelessWidget {
  ExploreTabs({Key? key}) : super(key: key);

  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: customHeadingText(
                      "EXplore", kcBlack, 24, FontWeight.w300)),
              Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    "assets/icons/subtract.svg",
                    height: 24,
                    width: 24,
                  ))
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [tabs(0), tabs(1)],
          )
        ],
      ),
    );
  }

  tabs(int i) {
    return InkWell(
      onTap: () => controller.pageIndex = 1,
      child: SizedBox(
        height: 200,
        width: 160,
        child: Stack(alignment: Alignment.topCenter, children: [
          Positioned(
            top: 10,
            child: Container(
              height: 166,
              width: 160,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.5, 0.5),
                  radius: 0.5,
                  colors: [
                    Colors.black.withOpacity(0.9), // Dark color in the center
                    Colors.transparent, // Transparent color to fade outside
                  ],
                  stops: const [0.5, 1.0],
                ),
                image: DecorationImage(
                    image: i == 0
                        ? const AssetImage("assets/images/one_on_one.png")
                        : const AssetImage("assets/images/audio_room.png"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(child: i == 0 ? oneOnOneTitle() : audioRoomTitle()),
            ),
          ),
          if (i == 1)
            const Positioned(
                top: 0,
                child: TagWidget(
                  child: Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: 'Coming s',
                        style: TextStyle(
                          color: Color(0xFF292929),
                          fontSize: 12,
                          fontFamily: 'Hanken Grotesk',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: 'oo',
                        style: TextStyle(
                          color: Color(0xFF292929),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'TestDomaine',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: 'n',
                        style: TextStyle(
                          color: Color(0xFF292929),
                          fontSize: 12,
                          fontFamily: 'Hanken Grotesk',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ],
                  )),
                ))
        ]),
      ),
    );
  }

  oneOnOneTitle() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '1 ',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 24,
              fontFamily: 'Hanken Grotesk',
              fontWeight: FontWeight.w600,
              height: 0.05,
            ),
          ),
          TextSpan(
            text: 'on',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontFamily: 'TestDomaine',
              fontWeight: FontWeight.w600,
              height: 0.05,
            ),
          ),
          TextSpan(
            text: ' 1',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 24,
              fontFamily: 'Hanken Grotesk',
              fontWeight: FontWeight.w600,
              height: 0.05,
            ),
          ),
        ],
      ),
    );
  }

  audioRoomTitle() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Audi',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 24,
              fontFamily: 'Hanken Grotesk',
              fontWeight: FontWeight.w400,
              height: 0.05,
            ),
          ),
          TextSpan(
            text: 'o-',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontFamily: 'TestDomaine',
              fontWeight: FontWeight.w600,
              height: 0.05,
            ),
          ),
          TextSpan(
            text: 'R',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 24,
              fontFamily: 'Hanken Grotesk',
              fontWeight: FontWeight.w600,
              height: 0.05,
            ),
          ),
          TextSpan(
            text: 'oo',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontFamily: 'TestDomaine',
              fontWeight: FontWeight.w600,
              height: 0.05,
            ),
          ),
          TextSpan(
            text: 'm',
            style: TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 24,
              fontFamily: 'Hanken Grotesk',
              fontWeight: FontWeight.w600,
              height: 0.05,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
