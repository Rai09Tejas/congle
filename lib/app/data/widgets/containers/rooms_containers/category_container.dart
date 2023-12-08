import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    Key? key,
    required this.title,
    this.assetName = svg_logo,
    required this.noOfRooms,
  }) : super(key: key);

  final String title;
  final String assetName;
  final int noOfRooms;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: Get.theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: kcLightGrey.withOpacity(0.4),
            offset: const Offset(2, 5),
            spreadRadius: 2,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Get.textTheme.bodyText1!.copyWith(color: Colors.black),
          ),
          Align(
              heightFactor: 0.8,
              alignment: Alignment.centerRight,
              child: KSvgIcon(
                assetName: assetName,
                color: const Color(0xff35AB78),
                size: 50,
              )),
          Text('$noOfRooms Active Rooms',
              style: Get.textTheme.bodyText2!
                  .copyWith(color: Get.theme.focusColor)),
        ],
      ),
    );
  }
}
