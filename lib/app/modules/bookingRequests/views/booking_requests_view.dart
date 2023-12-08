import 'package:congle/app/modules/bookingRequests/views/completed_view.dart';
import 'package:congle/app/modules/bookingRequests/views/upcoming_view.dart';
import 'package:congle/app/modules/bookingRequests/views/pending_view.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/booking_requests_controller.dart';

class BookingRequestsView extends StatefulWidget {
  const BookingRequestsView({Key? key}) : super(key: key);

  @override
  _BookingRequestsViewState createState() => _BookingRequestsViewState();
}

class _BookingRequestsViewState extends State<BookingRequestsView>
    with SingleTickerProviderStateMixin {
  final controller =
      Get.put<BookingRequestsController>(BookingRequestsController());

  @override
  void initState() {
    controller.initTabController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Get.parameters.isEmpty || Get.currentRoute == Routes.HOME
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  )),
              elevation: 0,
            ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: Get.textTheme.headline1,
                      children: [
                        const TextSpan(
                          text: 'Let\'s ',
                        ),
                        TextSpan(
                          text: 'meet',
                          style: TextStyle(
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),
                        const TextSpan(
                          text: ' \nnew people !',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                  borderRadius: BorderRadius.circular(17),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: Get.theme.backgroundColor,
                    ),
                    child: Icon(
                      Icons.notifications_active_outlined,
                      size: 30,
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.transparent,
                child: TabBar(
                  unselectedLabelColor: Get.theme.focusColor,
                  physics: const BouncingScrollPhysics(),
                  labelColor: Get.theme.colorScheme.secondary,
                  tabs: [
                    Tab(child: Text('Pending'.toUpperCase())),
                    Tab(child: Text('Upcoming'.toUpperCase())),
                    Tab(child: Text('Completed'.toUpperCase())),
                  ],
                  controller: controller.tabController,
                  indicatorColor: Get.theme.colorScheme.secondary,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: Get.textTheme.bodyText1!.copyWith(fontSize: 12),
                ),
              ),
              const Divider(),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              physics: const BouncingScrollPhysics(),
              children: const [
                PendingView(),
                UpcomingView(),
                CompletedView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
