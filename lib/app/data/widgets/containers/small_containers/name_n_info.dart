import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data.dart';

class NameNInfoContainer extends StatelessWidget {
  const NameNInfoContainer(
      {Key? key, required this.profile, this.isSmall = false})
      : super(key: key);
  final ShortProfile profile;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            profile.name.toString().split(' ')[0] +
                                ', ' +
                                profile.age.toString() +
                                ' ',
                            style: Get.textTheme.headline6!.copyWith(
                                color: Colors.black,
                                fontSize: isSmall ? 18 : 25),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (profile.work != null)
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: isSmall ? 15 : 30,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.work,
                            size: isSmall ? 14 : 25,
                            color: isSmall
                                ? Get.theme.focusColor
                                : Get.theme.colorScheme.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          profile.work!,
                          style: Get.textTheme.bodyText2!
                              .copyWith(fontSize: isSmall ? 12 : 16),
                          maxLines: isSmall ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                // if (isSmall)
                //   Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Container(
                //         width: 15,
                //         alignment: Alignment.centerLeft,
                //         child: Padding(
                //           padding: const EdgeInsets.all(2),
                //           child: Icon(
                //             Icons.near_me,
                //             color: isSmall
                //                 ? Get.theme.focusColor
                //                 : Get.theme.accentColor,
                //             size: 14,
                //           ),
                //         ),
                //       ),
                //       SizedBox(width: 4),
                //       Expanded(
                //         child: Text(
                //           profile.location.split(' ').first + ' km away',
                //           style: Get.textTheme.bodyText2!
                //               .copyWith(fontSize: isSmall ? 12 : 16),
                //           maxLines: isSmall ? 1 : 2,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ),
                //     ],
                //   ),
              ],
            ),
          ),
          // if (!isSmall)
          //   KButton(
          //       leading: Icon(
          //         Icons.location_pin,
          //         color: Colors.white.withOpacity(0.7),
          //       ),
          //       title: profile.location.split(' ').first + ' km',
          //       onPressed: () {}),
        ],
      ),
    );
  }
}

class ActivityNameNInfoContainer extends StatelessWidget {
  const ActivityNameNInfoContainer(
      {Key? key, this.activity, this.activityShort, this.time})
      : assert(activity != null || activityShort != null),
        super(key: key);
  final Activity? activity;
  final ShortActivity? activityShort;
  // final bool isSmall;
  final DateTime? time;

  @override
  Widget build(BuildContext context) {
    bool isSmall = activityShort != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSmall
                          ? activityShort!.name.toString()
                          : activity!.name.toString(),
                      style: Get.textTheme.headline6!.copyWith(
                          color: Colors.black, fontSize: isSmall ? 22 : 25),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: isSmall ? 15 : 30,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.near_me,
                              size: isSmall ? 14 : 20,
                              color: Get.theme.focusColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            isSmall
                                ? activityShort!.location
                                : activity!.location,
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: isSmall ? 14 : 16),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isSmall)
                Column(
                  children: [
                    KButton(
                      solidColor: Get.theme.cardColor,
                      title: '${activity!.distance} km',
                      textColor: Colors.black,
                      onPressed: () {},
                    ),
                    InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Directions',
                            style: Get.textTheme.bodyText2!.copyWith(
                                color: Get.theme.colorScheme.secondary,
                                fontSize: 12),
                          ),
                        ))
                  ],
                ),
            ],
          ),
          if (isSmall && time != null)
            Row(
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat('E, dd MMM yyyy').format(time!),
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 14, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat.jm().format(time!),
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
