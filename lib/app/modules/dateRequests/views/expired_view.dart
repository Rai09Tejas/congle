import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/dateRequests/controllers/date_requests_controller.dart';
import 'package:congle/packages/loading_dots/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

class ExpiredView extends GetView<DateRequestsController> {
  const ExpiredView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Text(
              'These profiles have requested you for a meeting some days ago. Request them for a connection once again.',
              style: Get.textTheme.caption,
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, bottomNavBarHeight),
            child: GetBuilder<DateRequestsController>(
              init: DateRequestsController(),
              builder: (_cr) {
                return FutureBuilder<List<DateRequest>>(
                  future: _cr.getExpiredProfiles(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DateRequest>> snapshot) {
                    if (!snapshot.hasData) return const LoadingDots.long();

                    List<DateRequest> _list = snapshot.data!;
                    if (_list.isEmpty) {
                      return const EmptyWidget(
                          title: 'No Expired Requests Yet!');
                    }

                    return AnimationLimiter(
                      child: GridView.builder(
                        itemCount: _list.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: (5 / 8),
                        ),
                        itemBuilder: (context, index) {
                          if (index >= _list.length) return const SizedBox();

                          DateRequest _dateRequest = _list[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: (_list.length * 0.5).ceil(),
                            child: FadeInAnimation(
                              child: ScaleAnimation(
                                child: DatesProfileCard(
                                  profile: _dateRequest.profile,
                                  onTap: () =>
                                      Get.to(() => ProfileDetailsScreen(
                                            id: _dateRequest.profile.id,
                                            mainButton: KButton(
                                              title: 'Send Request',
                                              onPressed: () {
                                                Get.back();
                                                _cr.sendRequestExpiredProfile(
                                                    _dateRequest);
                                              },
                                            ),
                                            secButton: KOutlineButton(
                                              title: 'Remove',
                                              onPressed: () {
                                                Get.back();
                                                _cr.removeExpiredProfile(
                                                    _dateRequest);
                                              },
                                              isTextWhite: false,
                                            ),
                                          )),
                                  firstButton: 'Send Request',
                                  firstButtonCallback: () => _cr
                                      .sendRequestExpiredProfile(_dateRequest),
                                  time: _dateRequest.dateTime,
                                  removeCard: () =>
                                      _cr.removeExpiredProfile(_dateRequest),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
