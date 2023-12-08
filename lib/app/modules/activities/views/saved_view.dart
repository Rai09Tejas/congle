import 'package:congle/app/data/data.dart';
import 'package:congle/packages/packages.dart';
import '../controllers/activities_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedView extends GetView<ActivitiesController> {
  const SavedView({Key? key}) : super(key: key);

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
      ),
      body: controller.savedActivities.isEmpty
          ? Center(
              child: SizedBox(
                height: Get.height * 0.7,
                child: const EmptyWidget(
                  title: "No Saved Cafes",
                  subtitle: "You haven't saved any of the cafes",
                ),
              ),
            )
          : ListView.builder(
              itemCount: controller.savedActivities.length,
              itemBuilder: (context, index) {
                String id = controller.savedActivities[index];
                return FutureBuilder<Activity?>(
                  future: controller.getActivity(id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingDots(
                        color: kcAccent,
                      );
                    }
                    // else if(snapshot.connectionState == ConnectionState.).
                    if (snapshot.data == null) return Container();
                    final Activity activity = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActivityContainer(
                        activity: ShortActivity.fromJson(activity.toJson()),
                        onSave: () => controller.saveCafe(activity.id),
                        isSaved: controller.savedActivities
                            .contains(activity.id)
                            .obs,
                        onTap: () => Get.to(() => ActivityDetailsScreen(
                              activity: activity,
                              isSaved: controller.savedActivities
                                  .contains(activity.id)
                                  .obs,
                              onSave: () => controller.saveCafe(activity.id),
                              mainButton: KButton(
                                title: 'Book Your Meating',
                                onPressed: () => controller.bookMeeting(
                                    ShortActivity.fromJson(activity.toJson())),
                                fontSize: 20,
                              ),
                            )),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
/**
 *  CustomScrollView(
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
                  title: "Saved",
                  desc: "All your saved cafes are listed down here",
                  imageUrl: "category.dp",
                  heroTag: "saved",
                ),
              ),
            ),
          ),
          FutureBuilder<List<ShortActivity>>(
              future: controller.getCategoryActivities(category),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return SliverToBoxAdapter(child: LoadingDots.long());
                final List<ShortActivity> activities = snapshot.data!;

                if (activities.length == 0)
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        height: Get.height * 0.7,
                        child: EmptyWidget(
                          title: "No ${category.title} nearby",
                          subtitle:
                              "Sorry can’t find places near you. We are working very hard to bring more cafes and meet-up venues on our platform. Thank you for your patience.",
                        ),
                      );
                    }, childCount: 1),
                  );

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final ShortActivity activity = activities[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActivityContainer(
                        activity: activity,
                        onTap: () => Get.to(() => ActivityDetailsScreen(
                              id: activity.id,
                              mainButton: KButton(
                                title: 'Book Your Meeting',
                                onPressed: () =>
                                    controller.bookMeeting(activity),
                                fontSize: 20,
                              ),
                            )),
                      ),
                    );
                  }, childCount: activities.length),
                );
              }),
        ],
      ),
 */