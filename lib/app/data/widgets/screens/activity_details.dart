import 'package:congle/app/data/data.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetailsScreen extends StatelessWidget {
  const ActivityDetailsScreen(
      {Key? key,
      this.id,
      this.activity,
      this.mainButton,
      this.secButton,
      this.onSave,
      this.isSaved,
      this.showSave = true})
      : assert((id != null || activity != null) &&
            ((onSave != null && isSaved != null) || showSave == false)),
        super(key: key);
  final String? id;
  final Activity? activity;
  final KButton? mainButton;
  final KOutlineButton? secButton;
  final Function? onSave;
  final RxBool? isSaved;
  final bool showSave;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Activity?>(
        future: activity != null
            ? Future.value(activity)
            : Get.find<ActivityApi>().getActivityById(id!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.black),
                ),
              ),
              body: const Center(child: LoadingDots.long()),
            );
          }

          Activity activity = snapshot.data!;

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Header(
                            activity: activity,
                            isSaved: isSaved,
                            showSave: showSave),
                        const SizedBox(height: 10),
                        _ActivityDetails(activity: activity),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      if (secButton != null)
                        Expanded(
                            child: SizedBox(height: 55, child: secButton!)),
                      if (secButton != null && mainButton != null)
                        const SizedBox(
                          width: 5,
                        ),
                      if (mainButton != null)
                        Expanded(
                            child: SizedBox(height: 55, child: mainButton!)),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ActivityDetails extends StatelessWidget {
  const _ActivityDetails({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActivityNameNInfoContainer(activity: activity),
        const SizedBox(height: 10),
        TitleNContent(
          title: 'Discription',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              activity.desc,
              style: Get.textTheme.bodyText2,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (activity.tags != null)
          TitleNContent(
            title: 'Category',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: Get.width,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.spaceEvenly,
                runSpacing: 0,
                spacing: 10,
                verticalDirection: VerticalDirection.down,
                children: [
                  for (var item in activity.tags!) KFilterChip(text: item),
                ],
              ),
            ),
          ),
        TitleNContent(
          title: 'Other info',
          trailing: SizedBox(
            width: 100,
            child: KOutlineButton(
              title: 'Contact',
              isTextWhite: false,
              onPressed: () {
                {
                  var urlString = "tel:${activity.phno}";
                  canLaunch(urlString).then((value) {
                    if (value) {
                      launch(urlString);
                      return;
                    }
                  });
                }
              },
              icon: const Icon(
                Icons.call_outlined,
                size: 15,
                color: kcAccent,
              ),
              borderColor: kcAccent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                        child: Text(
                          '₹',
                          style: Get.textTheme.headline6!.copyWith(
                              fontSize: 25, color: Get.theme.focusColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Average Cost',
                            style: Get.textTheme.bodyText2!.copyWith(
                                fontSize: 18, color: Get.theme.focusColor),
                          ),
                          Text(
                            'Cost for two - ₹${activity.cost} approx',
                            style: Get.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                        child: Icon(
                          Icons.schedule,
                          color: Get.theme.focusColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Timing',
                            style: Get.textTheme.bodyText2!.copyWith(
                                fontSize: 18, color: Get.theme.focusColor),
                          ),
                          Text(
                            "${activity.openTime.hour}:${activity.openTime.minute} - ${activity.closeTime.hour}:${activity.closeTime.minute}",
                            style: Get.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (activity.photos != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 25,
                          child: Icon(
                            Icons.collections,
                            color: Get.theme.focusColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Photos',
                              style: Get.textTheme.bodyText2!.copyWith(
                                  fontSize: 18, color: Get.theme.focusColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (activity.photos != null)
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: activity.photos!.length,
                      itemBuilder: (context, index) => Container(
                        width: 150,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Get.theme.backgroundColor,
                          image: DecorationImage(
                            image: NetworkImage(activity.photos![index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.activity,
    required this.isSaved,
    required this.showSave,
  }) : super(key: key);

  final Activity activity;
  final RxBool? isSaved;
  final bool showSave;

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: activity.id,
          child: Container(
            height: Get.height * 0.45 + Get.mediaQuery.padding.top,
            decoration: BoxDecoration(
              color: Get.theme.backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(44.0),
                bottomLeft: Radius.circular(44.0),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: PageView.builder(
              controller: _pageController,
              itemCount: activity.dp.length,
              itemBuilder: (context, index) {
                return Image.network(
                  activity.dp[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        Positioned(
          top: Get.mediaQuery.padding.top,
          right: 0,
          left: 0,
          child: Container(
            height: Get.height * 0.45,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.0),
                          color: const Color(0x99ffffff),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.black),
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: showSave,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            color: const Color(0x99ffffff),
                          ),
                          child: Obx(() => Icon(Icons.bookmark,
                              color: isSaved?.value ?? false
                                  ? kcAccent
                                  : Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0x47868181),
            ),
            child: DotsIndicator(
              color: Colors.white,
              controller: _pageController,
              itemCount: activity.dp.length,
              onPageSelected: (index) => _pageController.animateToPage(index,
                  duration: 400.milliseconds, curve: Curves.easeInOutQuint),
            ),
          ),
        ),
      ],
    );
  }
}
