import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data.dart';

class UpcomingRoomTile extends StatelessWidget {
  const UpcomingRoomTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(
                  '11:00 PM',
                  style: Get.textTheme.caption!.copyWith(fontSize: 14),
                ),
              ),
              const InkWell(child: Icon(Icons.notifications)),
            ],
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5), child: Divider()),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              'Medical Student Only Connect Now',
              style: Get.textTheme.headline6!.copyWith(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Row(
              children: [
                Text(
                  'Doctors Club'.toUpperCase(),
                  style: Get.textTheme.bodyText1,
                ),
                const SizedBox(width: 10),
                Icon(Icons.home,
                    color: Get.theme.colorScheme.secondary, size: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              'Discussion on how Medical Students do after MMBS',
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodyText2!.copyWith(color: Colors.black87),
            ),
          ),
          const ManyMergedImageContainer(
            images: [
              'https://images.unsplash.com/photo-1571224736343-7182962ae3e7?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDk0fHRvd0paRnNrcEdnfHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
              'https://images.unsplash.com/photo-1556908153-a685b0352d59?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDEzMXx0b3dKWkZza3BHZ3x8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
              'https://images.unsplash.com/photo-1586953620693-54c3249107ad?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE0MHx0b3dKWkZza3BHZ3x8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
              'https://images.unsplash.com/photo-1622559924472-2c2f69abb854?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE3OHx0b3dKWkZza3BHZ3x8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
            ],
            widthFactor: 0.6,
            extraCounts: 20,
          ),
        ],
      ),
    );
  }
}
