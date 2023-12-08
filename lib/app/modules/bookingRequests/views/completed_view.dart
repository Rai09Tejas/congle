import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/bookingRequests/controllers/booking_requests_controller.dart';
import 'package:congle/packages/loading_dots/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

class CompletedView extends GetView<BookingRequestsController> {
  const CompletedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Introduce yourself via our audio call feature before your meeting Relax! we will not show your number to them. Only you can call.',
              style: Get.textTheme.caption,
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: GetBuilder<BookingRequestsController>(
              init: BookingRequestsController(),
              builder: (_cr) {
                return AnimationLimiter(
                  child: FutureBuilder<List<Booking>>(
                    future: _cr.getCompletedMeets(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Booking>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: LoadingDots.long());
                      }

                      List<Booking> meets = snapshot.data!;
                      if (meets.isEmpty) {
                        return const EmptyWidget(
                            title: 'No Completed Bookings Yet!');
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
                                  moreOptions: () =>
                                      controller.completedMoreOptions(meet),
                                  mainButton: KButton(
                                    title: 'Meet Again',
                                    onPressed: () =>
                                        controller.completedMeetAgain(meet),
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
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
