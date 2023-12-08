import 'package:congle/packages/loading_dots/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:congle/app/data/data.dart';

import 'no_match_left.dart';
import '../../controllers/swipe_card_controller.dart';

class SwipeCardsContainer extends StatelessWidget {
  const SwipeCardsContainer({
    Key? key,
    required this.prefButton,
  }) : super(key: key);
  final Function() prefButton;

  @override
  Widget build(BuildContext context) {
    Get.put(SwipeCardController());
    return GetBuilder<SwipeCardController>(builder: (_sc) {
      return _sc.infoProfile.value
          ? Container()
          : Obx(() => _sc.nothingLeft.value
              ? NoMatchLeft(
                  onButtonPress: prefButton,
                )
              : FutureBuilder(
                  future: (_sc.profiles.isEmpty) ? _sc.addProfiles() : null,
                  builder: (context, snapshot) {
                    if (_sc.profiles.isNotEmpty) {
                      return TinderSwipeCard(
                        demoProfiles: _sc.profiles,
                        noMatchLeftButton: prefButton,
                        myCallbackend: _sc.myCallbackEnd,
                        myCallbackDistance: _sc.myCallbackDistance,
                        myCallbackStart: _sc.myCallbackStart,
                        ibutton: _sc.iButtonCallback,
                        instaButton: _sc.instaButtonCallback,
                        spotifyButton: _sc.spotifyButtonCallback,
                      );
                    } else {
                      return const LoadingDots.long();
                    }
                  }));
    });
  }
}

// class SwipeAnimationWidget extends StatelessWidget {
//   const SwipeAnimationWidget({
//     Key key,
//     @required this.indicatorOffset,
//   }) : super(key: key);

//   final Offset indicatorOffset;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       // height: 35,
//       top: Get.height * 0.47,
//       bottom: Get.height * 0.47,
//       right: !indicatorOffset.dy.isNegative ? indicatorOffset.dx : 0,
//       left: indicatorOffset.dy.isNegative ? indicatorOffset.dx : 0,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: AnimatedContainer(
//           alignment: Alignment.center,
//           duration: Duration(milliseconds: 300),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.white, width: 2),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Center(),
//         ),
//       ),
//     );
//   }
// }
