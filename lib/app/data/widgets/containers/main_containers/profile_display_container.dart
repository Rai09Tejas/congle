import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data.dart';

class PhotoDisplayContainer extends StatelessWidget {
  const PhotoDisplayContainer({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final AboutUser profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      width: Get.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: NetworkImage(
                      profile.dp,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.vertical,
                      ),
                      items: profile.photos!.map((i) {
                        return Image.network(
                          i,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    // height: 270 / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.vertical,
                      ),
                      items: profile.photos!.reversed.map((i) {
                        return Image.network(
                          i,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
