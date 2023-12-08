import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/bookingRequests/controllers/booking_requests_controller.dart';
import 'package:congle/packages/loading_dots/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

class PendingView extends GetView<BookingRequestsController> {
  const PendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Intorduce yourself via our chat option and get to know each other in a better way. Once you’re ready plan a meet-up at our cafes.',
              style: Get.textTheme.caption,
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: AnimationLimiter(
              child: FutureBuilder<List<Booking>>(
                future: controller.getPendingMeets(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Booking>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: LoadingDots.long());
                  }

                  List<Booking> meets = snapshot.data!;
                  if (meets.isEmpty) {
                    return const EmptyWidget(title: 'No Pending Bookings Yet!');
                  }

                  return ListView.builder(
                    itemCount: meets.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= meets.length) {
                        return const SizedBox(height: bottomNavBarHeight);
                      }
                      Booking meet = meets.reversed.toList()[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: BookingTile(
                              index: index,
                              reciver: meet.attendies.first,
                              sender: meet.bookie,
                              time: meet.initTime,
                              secButton: KOutlineButton(
                                title: 'Interact via chat',
                                isTextWhite: false,
                                borderColor: Colors.white,
                                textColor: Colors.black,
                                // icon: Icon(Icons.call, size: 15),
                                onPressed: () =>
                                    controller.pendingChat(meet.bookie),
                              ),
                              mainButton: KButton(
                                title: 'Book Your Meeting',
                                onPressed: () => controller.pendingBookMeeting(
                                    DateRequest(
                                        id: meet.id,
                                        dateTime: meet.initTime,
                                        profile: meet.bookie)),
                                solidColor: Colors.white,
                                textColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // child: GetBuilder<BookingRequestsController>(
            //   init: BookingRequestsController(),
            //   builder: (_cr) {
            //     return FutureBuilder<List<AboutUser>>(
            //       future: _cr.getRequestedProfiles(),
            //       builder: (BuildContext context,
            //           AsyncSnapshot<List<AboutUser>> snapshot) {
            //         if (!snapshot.hasData)
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         List<AboutUser> _list = snapshot.data!;
            //         if (_list.length == 0)
            //           return Center(child: Text('No Requested Profiles Yet.'));
            //         return Container();
            //       },
            //     );
            //   },
            // ),
          )),
        ],
      ),
    );
  }
}
