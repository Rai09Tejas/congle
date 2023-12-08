import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/rooms/controllers/rooms_controller.dart';
import 'package:congle/app/modules/rooms/views/live_view.dart';
import 'package:congle/app/modules/rooms/views/upcomming_view.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({Key? key}) : super(key: key);

  @override
  _RoomsViewState createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView>
    with SingleTickerProviderStateMixin {
  final controller = Get.put<RoomsController>(RoomsController());

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton.extended(
          onPressed: () {},
          isExtended: true,
          label: const Text('Start Room'),
          icon: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.toNamed(Routes.SEARCH),
                  borderRadius: BorderRadius.circular(17),
                  child: Icon(
                    Icons.search,
                    size: 30,
                    color: Get.theme.focusColor,
                  ),
                ),
                const Expanded(
                  child: Center(
                      child: KSvgIcon(
                    assetName: svg_logo,
                    size: 30,
                    color: Colors.black,
                  )),
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
                  borderRadius: BorderRadius.circular(17),
                  child: Icon(
                    Icons.notifications_active_outlined,
                    size: 30,
                    color: Get.theme.focusColor,
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
                  unselectedLabelColor: Colors.black87,
                  labelColor: Get.theme.colorScheme.secondary,
                  controller: controller.tabController,
                  indicatorColor: Get.theme.colorScheme.secondary,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: const [
                    Tab(
                      text: 'LIVE NOW',
                    ),
                    Tab(
                      text: 'UPCOMMING',
                    ),
                  ],
                ),
              ),
              // Divider(),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                LiveView(),
                UpcommingView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
