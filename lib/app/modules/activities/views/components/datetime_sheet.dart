import 'package:congle/app/data/data.dart';
import '../../controllers/activities_controller.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeSheet extends StatelessWidget {
  const DateTimeSheet({
    Key? key,
    this.activity,
    this.id,
    required this.dateRequest,
    this.onReschedule,
    this.initDateTime,
  })  : assert(id != null || activity != null),
        super(key: key);

  final Activity? activity;
  final String? id;
  final DateRequest dateRequest;
  final Function()? onReschedule;
  final DateTime? initDateTime;

  @override
  Widget build(BuildContext context) {
    final ActivitiesController controller = Get.find<ActivitiesController>();
    if (initDateTime != null) controller.dateTime = initDateTime!;
    return FutureBuilder<Activity?>(
        future: id == null
            ? Future.value(activity)
            : Get.find<ActivityApi>().getActivityById(id!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: LoadingDots.long(
              color: kcWhite,
            ));
          }
          if (snapshot.data == null) return const Center(child: Text("Error"));
          Activity activity = snapshot.data!;
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            height: Get.height * 0.8,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TitleNContent(
                          title: 'Hint',
                          titleIcon: Icon(
                            Icons.lightbulb,
                            size: 17,
                            color: Get.theme.focusColor,
                          ),
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    'Activity is open between: ${activity.openTime.hour}:${activity.openTime.minute} to ${activity.closeTime.hour}:${activity.closeTime.minute}',
                                    style: Get.textTheme.bodyText2),
                              ],
                            ),
                          ),
                        ),
                        TitleNContent(
                          title: 'Select Date',
                          child: DatePicker(
                            controller.dateTime,
                            initialSelectedDate: controller.dateTime,
                            selectionColor: Get.theme.colorScheme.secondary,
                            selectedTextColor: Colors.white,
                            onDateChange: controller.onDateChange,
                            height: 90,
                            daysCount: 7,
                            monthTextStyle:
                                Get.textTheme.bodyText2!.copyWith(fontSize: 12),
                          ),
                        ),
                        TitleNContent(
                          title: 'Select Time',
                          child: Container(
                            height: 90,
                            width: 250,
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: 200,
                              child: CupertinoDatePicker(
                                onDateTimeChanged: controller.onTimeChange,
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime: controller.dateTime,
                                // use24hFormat: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: KButton(
                    title: 'Confirm',
                    onPressed: onReschedule ??
                        () => controller.confirmBooking(dateRequest,
                            ShortActivity.fromJson(activity.toJson())),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
