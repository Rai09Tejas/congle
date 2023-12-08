import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityContainer extends StatelessWidget {
  const ActivityContainer({
    Key? key,
    required this.activity,
    required this.isSaved,
    this.isCardLong = false,
    required this.onTap,
    required this.onSave,
  }) : super(key: key);

  final ShortActivity activity;
  final RxBool isSaved;
  final bool isCardLong;
  final Function()? onTap;
  final Function()? onSave;

  @override
  Widget build(BuildContext context) {
    const margin = EdgeInsets.fromLTRB(0, 0, 0, 0);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.zero,
        height: 200,
        child: Stack(
          children: [
            Container(
              margin: margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                    image: NetworkImage(activity.dp.first), fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(31.0),
                gradient: const LinearGradient(
                  begin: Alignment(0.0, 0.23),
                  end: Alignment(0.0, 0.77),
                  colors: [
                    Color(0x007c7878),
                    Color(0xff060505),
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Positioned(
              right: 15 + margin.right,
              top: 15,
              child: GestureDetector(
                onTap: onSave,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color(0xff656060),
                  ),
                  child: Obx(() => Icon(
                        Icons.bookmark,
                        color: isSaved.value ? kcAccent : Colors.white,
                      )),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 17 + margin.left,
              right: 17 + margin.right,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.name,
                          style: Get.textTheme.headline6!
                              .copyWith(color: Colors.white, fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          activity.category,
                          style: Get.textTheme.bodyText2!
                              .copyWith(color: Colors.white, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          color: const Color(0x66817776),
                        ),
                        child: Text(
                          ' ₹ ${activity.cost} ',
                          style: Get.textTheme.bodyText2!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '*average for 2 person',
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: Colors.white, fontSize: 4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
