import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/dateRequests/views/expired_view.dart';
import 'package:congle/app/modules/dateRequests/views/pending_view.dart';
import 'package:congle/app/modules/dateRequests/views/requested_view.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/date_requests_controller.dart';

class DateRequestsView extends StatefulWidget {
  const DateRequestsView({Key? key}) : super(key: key);

  @override
  _DateRequestsViewState createState() => _DateRequestsViewState();
}

class _DateRequestsViewState extends State<DateRequestsView>
    with SingleTickerProviderStateMixin {
  final controller = Get.put<DateRequestsController>(DateRequestsController());
  late double _containerPosition;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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
      body:
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // Expanded(
          //       //   child: Text(
          //       //     'Your Connection Requests',
          //       //     style: Get.textTheme.headline1,
          //       //   ),
          //       // ),
          //       // ProfileImageContainer(
          //       //     size: 70, image: NetworkImage(Congle.currentUser!.dp)),
          //     ],
          //   ),
          // ),
          SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: 0,
              left: _currentPage * (MediaQuery.of(context).size.width / 3),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 50,
                color: Colors.black,
                alignment: Alignment.center,
                child: Text(
                  'Tab $_currentPage',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Tabs
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        setState(() {
                          _currentPage = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              _currentPage == 0 ? Colors.black : Colors.white,
                        ),
                        child: Text(
                          'Tab 1',
                          style: TextStyle(
                            color:
                                _currentPage == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        setState(() {
                          _currentPage = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              _currentPage == 1 ? Colors.black : Colors.white,
                        ),
                        child: Text(
                          'Tab 2',
                          style: TextStyle(
                            color:
                                _currentPage == 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        setState(() {
                          _currentPage = 2;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              _currentPage == 2 ? Colors.black : Colors.white,
                        ),
                        child: Text(
                          'Tab 3',
                          style: TextStyle(
                            color:
                                _currentPage == 2 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Column(
            //   children: [
            //     Container(
            //       color: Colors.transparent,
            //       child: TabBar(
            //         unselectedLabelColor: Get.theme.focusColor,
            //         labelColor: Get.theme.colorScheme.secondary,
            //         physics: const BouncingScrollPhysics(),
            //         tabs: [
            //           Tab(child: Text('Requested'.toUpperCase())),
            //           Tab(child: Text('Pending'.toUpperCase())),
            //           Tab(child: Text('Expired'.toUpperCase())),
            //         ],
            //         controller: controller.tabController,
            //         indicatorColor: Get.theme.colorScheme.secondary,
            //         indicatorSize: TabBarIndicatorSize.label,
            //         labelStyle: Get.textTheme.bodyLarge!.copyWith(fontSize: 12),
            //       ),
            //     ),
            //     const Divider(),
            //   ],
            // ),
            // AnimatedContainer(
            //   duration: const Duration(milliseconds: 300),
            //   alignment: Alignment(_containerPosition * 2 / 3, 0),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width / 3,
            //     height: 4,
            //     color: Colors.blue, // Change this color as needed
            //   ),
            // ),
            TabBar(
              controller: controller.tabController,
              indicatorColor: Colors.transparent,
              tabs: [
                _buildTab(0, 'Tab 1'),
                _buildTab(1, 'Tab 2'),
                _buildTab(2, 'Tab 3'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                physics: const BouncingScrollPhysics(),
                children: const [
                  RequestedView(),
                  PendingView(),
                  ExpiredView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTab(int index, String title) {
    return Container(
      color: controller.tabController!.index == index
          ? kcBlack
          : kcLameGrey, // Adjust colors as needed
      child: Tab(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
