import 'package:congle/app/data/data.dart';
import '../controllers/activities_controller.dart';
import 'package:congle/packages/loading_dots/loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreView extends GetView<ActivitiesController> {
  final ActivityCategory category;
  const ExploreView({Key? key, required this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    KAppBar kappbar = KAppBar(collapsedHeight: 56, expandedHeight: 200);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            expandedHeight: 200.0,
            collapsedHeight: 60,
            automaticallyImplyLeading: false,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) => kappbar.appBarContainer(
                KAppBarContent(
                  animation: kappbar.getAnimation(constraints),
                  title: category.title,
                  desc: category.desc,
                  imageUrl: category.dp,
                  heroTag: category.title,
                ),
              ),
            ),
          ),
          FutureBuilder<List<ShortActivity>>(
              future: controller.getCategoryActivities(category),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(child: LoadingDots.long());
                }
                final List<ShortActivity> activities = snapshot.data!;

                if (activities.isEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return SizedBox(
                        height: Get.height * 0.7,
                        child: EmptyWidget(
                          title: "No ${category.title} nearby",
                          subtitle:
                              "Sorry can’t find places near you. We are working very hard to bring more cafes and meet-up venues on our platform. Thank you for your patience.",
                        ),
                      );
                    }, childCount: 1),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final ShortActivity activity = activities[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActivityContainer(
                        activity: activity,
                        isSaved: controller.savedActivities
                            .contains(activity.id)
                            .obs,
                        onSave: () => controller.saveCafe(activity.id),
                        onTap: () => controller.onActivityTap(activity),
                      ),
                    );
                  }, childCount: activities.length),
                );
              }),
        ],
      ),
    );
  }
}
