import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/bookingRequests/controllers/booking_requests_controller.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

class UpcomingView extends GetView<BookingRequestsController> {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QueueContainer(controller: controller),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text('Meetings',
                style: Get.textTheme.headline6!.copyWith(color: Colors.black)),
          ),
          Expanded(
            child: AnimationLimiter(
              child: FutureBuilder<List<Booking>>(
                future: controller.getUpcommingMeets(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Booking>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: LoadingDots.long());
                  }

                  List<Booking> bookings = snapshot.data!;
                  if (bookings.isEmpty) {
                    return const EmptyWidget(
                        title: 'No Upcomming Bookings Yet!');
                  }

                  return ListView.builder(
                    itemCount: bookings.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= bookings.length) {
                        return const SizedBox(height: bottomNavBarHeight + 10);
                      }

                      Booking booking = bookings.reversed.toList()[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ActivityBookingTile(
                              onTap: () => controller.onBookingTileTap(booking),
                              index: index,
                              booking: booking,
                              mainButton: KButton(
                                title: 'Call Cafe',
                                onPressed: () =>
                                    controller.callCafe(booking.activity!),
                                leading: const Icon(Icons.call,
                                    size: 15, color: Colors.white),
                              ),
                              secButton: booking.isRescheduled
                                  ? null
                                  : KOutlineButton(
                                      title: 'Reshedule',
                                      onPressed: () =>
                                          controller.reschedule(booking),
                                      icon: const Icon(
                                          Icons.calendar_today_rounded,
                                          size: 15,
                                          color: Colors.white),
                                      borderColor: Colors.white,
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
          ),
        ],
      ),
    );
  }
}

class QueueContainer extends StatelessWidget {
  const QueueContainer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BookingRequestsController controller;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: FutureBuilder<List<ShortProfile>>(
        future: controller.getQueueMeets(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ShortProfile>> snapshot) {
          if (!snapshot.hasData) return const Center(child: LoadingDots.long());

          List<ShortProfile> profiles = snapshot.data!;
          if (profiles.isEmpty) return const Center();
          // return Center(child: Text('No one have you in Queue Yet'));
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text('Queue',
                      style: Get.textTheme.headline6!
                          .copyWith(color: Colors.black)),
                ),
              ),
              SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: profiles.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= profiles.length) {
                        return const SizedBox(width: bottomNavBarHeight);
                      }

                      ShortProfile profile = profiles[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () => Get.to(
                                  () => ProfileDetailsScreen(id: profile.id)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 35 - 2,
                                    backgroundColor: Get.theme.backgroundColor,
                                    backgroundImage: NetworkImage(profile.dp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          );
        },
      ),
    );
  }
}
