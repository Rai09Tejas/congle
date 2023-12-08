import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Create an effect of overlapping images in horizontal direction
///
/// Send more all images in list & set `imageLimit` to add counter at the last image
/// like `+5` inside the circle
///
/// Or directly send the extra count it will display it at the end
class ManyMergedImageContainer extends StatelessWidget {
  const ManyMergedImageContainer({
    Key? key,
    required this.images,
    this.imageLimit,
    this.widthFactor = 0.7,
    this.radius = 30,
    this.height = 70,
    this.extraCounts = 0,
  }) : super(key: key);

  final List<String> images;
  final int? imageLimit;

  /// If non-null, sets its width to the child's width multiplied by this factor.
  /// Can be both greater and less than 1.0 but must be non-negative.
  final double widthFactor;
  final double radius;
  final double height;

  final int extraCounts;

  @override
  Widget build(BuildContext context) {
    int limit = imageLimit ?? images.length;
    if (limit > images.length) limit = images.length;
    if (extraCounts > 0) limit++;
    return Container(
      height: height,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: limit,
        itemBuilder: (context, index) {
          if (index == limit - 1) {
            if (index < limit && (images.length - limit) > 0) {
              return Align(
                widthFactor: widthFactor,
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: Get.theme.backgroundColor,
                  child: Center(
                      child: Text(
                    '+${images.length - limit}',
                    style: Get.textTheme.bodyText2,
                  )),
                ),
              );
            } else if (extraCounts > 0) {
              return Align(
                widthFactor: widthFactor,
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: radius - 2,
                    backgroundColor: Colors.white,
                    child: Center(
                        child: Text(
                      '+$extraCounts',
                      style: Get.textTheme.bodyText2,
                    )),
                  ),
                ),
              );
            }
          }
          return Align(
            widthFactor: widthFactor,
            child: CircleAvatar(
              radius: radius,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: radius - 2,
                backgroundColor: Get.theme.backgroundColor,
                backgroundImage: NetworkImage(images[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
