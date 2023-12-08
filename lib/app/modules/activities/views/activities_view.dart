import 'package:congle/app/modules/activities/views/saved_view.dart';
import 'package:congle/packages/packages.dart';
import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/activities_controller.dart';
import 'components/explore_card.dart';

class ActivitiesView extends GetView<ActivitiesController> {
  const ActivitiesView({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: Get.textTheme.headline1,
                        children: [
                          const TextSpan(
                            text: 'Discover Places\nwith ',
                          ),
                          TextSpan(
                            text: 'new people',
                            style: TextStyle(
                              color: Get.theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15.0),
                      onTap: () {
                        Get.to(() => const SavedView());
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Get.theme.backgroundColor,
                        ),
                        child: Icon(
                          Icons.bookmark,
                          color: Get.theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: KTextField(
                leading: Icon(
                  Icons.search,
                  color: Get.theme.focusColor,
                  size: 30,
                ),
                hintText: 'Search...',
                borderRadius: 75,
                trailing: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75.0),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    color: Get.theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
            _AdsWidget(controller: controller),
            _ExploreSection(controller: controller),
            _RecommendedSection(controller: controller),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class _RecommendedSection extends StatelessWidget {
  const _RecommendedSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ActivitiesController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended',
                style: Get.textTheme.headline6!.copyWith(color: Colors.black),
              ),
              // Text(
              //   'See All',
              //   style: Get.textTheme.bodyText2!
              //       .copyWith(color: Get.theme.colorScheme.secondary),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        FutureBuilder<List<ShortActivity>>(
          future: controller.getRecommended(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const LoadingDots.long();
            final List<ShortActivity> cafes = snapshot.data!;
            return Container(
              width: Get.width + 50,
              alignment: Alignment.centerLeft,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                  aspectRatio: 33 / 40,
                  autoPlay: false,
                  pageSnapping: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                ),
                items: cafes.map((activity) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ActivityContainer(
                        isSaved: controller.savedActivities
                            .contains(activity.id)
                            .obs,
                        activity: ShortActivity.fromJson(activity.toJson()),
                        onSave: () => controller.saveCafe(activity.id),
                        onTap: () => controller.onActivityTap(activity),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ExploreSection extends StatelessWidget {
  const _ExploreSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ActivitiesController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            'Explore',
            style: Get.textTheme.headline6!.copyWith(color: Colors.black),
          ),
        ),
        SizedBox(
          height: 160,
          child: FutureBuilder<List<ActivityCategory>>(
            future: controller.getCategories(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const LoadingDots(color: kcAccent);
              }
              final List<ActivityCategory> categories = snapshot.data!;
              return ListView.builder(
                itemCount: exploreImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) => ExploreCard(
                  category: categories[i],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AdsWidget extends StatelessWidget {
  const _AdsWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ActivitiesController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: controller.getAds(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const LoadingDots(color: kcAccent);
        }
        final List<String> ads = snapshot.data!;
        if (ads.isEmpty) return Container();

        return CarouselSlider.builder(
          itemCount: ads.length,
          itemBuilder: (context, index, realIndex) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              image: DecorationImage(
                image: NetworkImage(ads[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          options: CarouselOptions(
            height: 140,
            aspectRatio: 5 / 2,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1,
          ),
        );
      },
    );
  }
}
