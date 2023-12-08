import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView>
    with SingleTickerProviderStateMixin {
  final controller =
      Get.put<NotificationsController>(NotificationsController());

  @override
  void initState() {
    controller.initTabController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        elevation: 0,
        centerTitle: true,
        // title: Text(
        //   'Notifications',
        //   style: Get.textTheme.headline1!.copyWith(color: Colors.black),
        // ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                'Notifications',
                style: Get.textTheme.headline1,
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //       child: Text(
            //         'Notifications',
            //         style: Get.textTheme.headline1,
            //       ),
            //     ),
            //     // Spacer(),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 8.0),
            //       child: Icon(
            //         Icons.notifications_none_rounded,
            //         color: Get.theme.focusColor,
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Column(
            //   children: [
            //     Container(
            //       color: Colors.transparent,
            //       child: TabBar(
            //         unselectedLabelColor: Colors.black87,
            //         labelColor: Get.theme.colorScheme.secondary,
            //         controller: controller.tabController,
            //         indicatorColor: Get.theme.colorScheme.secondary,
            //         indicatorSize: TabBarIndicatorSize.label,
            //         tabs: [
            //           new Tab(
            //             text: 'General'.toUpperCase(),
            //           ),
            //           new Tab(
            //             text: 'Rooms'.toUpperCase(),
            //           ),
            //         ],
            //       ),
            //     ),
            //     // Divider(),
            //   ],
            // ),
            // Expanded(
            //   child: TabBarView(
            //     controller: controller.tabController,
            //     children: [
            //       GeneralNotificationsView(),
            //       GeneralNotificationsView(),
            //     ],
            //   ),
            // ),
            const Expanded(child: GeneralNotificationsView()),
          ],
        ),
      ),
    );
  }
}

class GeneralNotificationsView extends StatelessWidget {
  const GeneralNotificationsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (_cr) {
        return AnimationLimiter(
          child: FutureBuilder<List<NotificationModel>>(
            future: _cr.getGeneralNotifications(),
            builder: (BuildContext context,
                AsyncSnapshot<List<NotificationModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              List<NotificationModel> _notifyList = snapshot.data!;

              if (_notifyList.isEmpty) {
                return const EmptyWidget(title: 'No Notifications!');
              }

              return ListView.builder(
                itemCount: _notifyList.length,
                itemBuilder: (BuildContext context, int index) {
                  NotificationModel _notify = _notifyList[index];
                  if (_notify.exipireTime.compareTo(DateTime.now()) < 0) {
                    _cr.readNotification(_notify, false);
                  }
                  return KListTile(
                    color: !_notify.isRead
                        ? Get.theme.backgroundColor
                        : Get.theme.cardColor,
                    leading: ProfileImageContainer(
                      image: NetworkImage(_notify.imageUrl),
                      size: 60,
                    ),
                    title: _notify.title,
                    subtitle: _notify.subTitle,
                    time: _notify.time,
                    onTap: () => _cr.readNotification(_notify, true),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
