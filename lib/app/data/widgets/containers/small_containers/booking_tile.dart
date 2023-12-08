import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({
    Key? key,
    required this.reciver,
    required this.sender,
    required this.time,
    this.secButton,
    this.mainButton,
    this.index = 0,
    this.moreOptions,
  }) : super(key: key);

  final ShortProfile reciver;
  final ShortProfile sender;
  final KOutlineButton? secButton;
  final KButton? mainButton;
  final DateTime time;
  final int index;
  final Function()? moreOptions;

  @override
  Widget build(BuildContext context) {
    final List<Color> colorList = [
      const Color(0xffd2e6ff),
      const Color(0xffFFF1D5),
      const Color(0xffFFDADA),
      const Color(0xffDAFFE4)
    ];
    final _color = colorList[index % 4];
    final ShortProfile profile = reciver == mainProfileShort ? sender : reciver;
    return Container(
      height: 145,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: _color,
        boxShadow: const [
          BoxShadow(
            color: Color(0x2b000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Get.to(() => ProfileDetailsScreen(id: profile.id)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name.toString() + ', ' + profile.age.toString(),
                    style: Get.textTheme.headline6!.copyWith(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 10,
                        color: Get.theme.focusColor,
                      ),
                      const SizedBox(width: 5),
                      Text(TimeFormat(time), style: Get.textTheme.caption!),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ManyMergedImageContainer(
                    images: [
                      sender.dp,
                      reciver.dp,
                    ],
                    widthFactor: 0.75,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (moreOptions != null)
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: moreOptions,
                        child: const Icon(
                          Icons.more_horiz_rounded,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                if (secButton != null) SizedBox(height: 45, child: secButton!),
                // if (secButton != null)
                // SizedBox(height: 20),
                if (mainButton != null)
                  SizedBox(height: 45, child: mainButton!),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class ActivityBookingTile extends StatelessWidget {
  const ActivityBookingTile({
    Key? key,
    required this.booking,
    this.secButton,
    this.mainButton,
    this.index = 0,
    this.onTap,
  }) : super(key: key);

  final Booking booking;
  final KOutlineButton? secButton;
  final KButton? mainButton;
  final int index;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double _height = 175;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.0),
      child: Stack(
        children: [
          Container(
            height: _height,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              image: DecorationImage(
                image: NetworkImage(booking.activity!.dp.first),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2b000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          Container(
            height: _height,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              gradient: const LinearGradient(
                begin: Alignment(0.33, -2.43),
                end: Alignment(0.17, 1.22),
                colors: [Color(0x42525456), Color(0xff101111)],
                stops: [0.0, 1.0],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x2b000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManyMergedImageContainer(
                        images: [
                          booking.bookie.dp,
                          if (booking.attendies.length == 1)
                            booking.attendies.first.dp
                        ],
                        extraCounts: booking.attendies.length - 1,
                        widthFactor: 0.75,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        booking.activity!.name.toString(),
                        style: Get.textTheme.headline6!
                            .copyWith(fontSize: 18, color: Colors.white),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 15, color: Colors.white),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat('E, dd MMM yyyy')
                                .format(booking.bookingTime!),
                            style: Get.textTheme.headline6!
                                .copyWith(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 15, color: Colors.white),
                          const SizedBox(width: 5),
                          Text(
                            DateFormat.jm().format(booking.bookingTime!),
                            style: Get.textTheme.headline6!
                                .copyWith(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (secButton != null)
                          SizedBox(height: 45, child: secButton!),
                        // if (secButton != null)
                        // SizedBox(height: 20),
                        if (mainButton != null)
                          SizedBox(height: 45, child: mainButton!),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
