import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/dateRequests/controllers/date_requests_controller.dart';
import 'package:congle/packages/loading_dots/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

class RequestedView extends GetView<DateRequestsController> {
  const RequestedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AskTime(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(
              'Tap on the profile to know more. Your partner have only 24 hours to accept your requests.',
              style: Get.textTheme.caption,
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, bottomNavBarHeight),
            child: GetBuilder<DateRequestsController>(
              init: DateRequestsController(),
              builder: (_cr) {
                return FutureBuilder<List<DateRequest>>(
                  future: _cr.getRequestedProfiles(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DateRequest>> snapshot) {
                    if (!snapshot.hasData) return const LoadingDots.long();

                    List<DateRequest> _list = snapshot.data!;
                    if (_list.isEmpty) {
                      return const EmptyWidget(
                          title: 'No Requested Requests Yet!');
                    }

                    return AnimationLimiter(
                      child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: (5 / 8),
                        ),
                        itemBuilder: (context, index) {
                          if (index >= _list.length) return const SizedBox();
                          DateRequest _dateRequest = _list[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: (_list.length * 0.5).ceil(),
                            child: FadeInAnimation(
                              child: ScaleAnimation(
                                child: DatesProfileCard(
                                  profile: _dateRequest.profile,
                                  onTap: () =>
                                      Get.to(() => ProfileDetailsScreen(
                                            id: _dateRequest.profile.id,
                                            mainButton: KButton(
                                              title: 'Cancel',
                                              onPressed: () {
                                                Get.back();
                                                _cr.cancelRequestedDate(
                                                    _dateRequest);
                                              },
                                            ),
                                          )),
                                  firstButton: 'Cancel',
                                  firstButtonCallback: () =>
                                      _cr.cancelRequestedDate(_dateRequest),
                                  time: _dateRequest.dateTime,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}

// class AskTime extends StatelessWidget {
//   const AskTime({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.0),
//         color: const Color(0xfff5f5f5),
//       ),
//       padding: EdgeInsets.all(10),
//       margin: EdgeInsets.all(5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Tell us when are you free today \nfor meeting ?',
//                 style: Get.textTheme.bodyText1,
//               ),
//               Text(
//                 '03:00 pm - 07:00 pm',
//                 style: Get.textTheme.caption,
//               ),
//             ],
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.0),
//                 gradient: kcgButton),
//             child: Icon(
//               Icons.access_time,
//               color: Colors.white,
//               size: 35,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
