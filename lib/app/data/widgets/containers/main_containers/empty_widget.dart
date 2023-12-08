import 'package:congle/app/data/config/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.title, this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            img_empty,
            height: 150,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: Get.textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) const SizedBox(height: 5),
          if (subtitle != null)
            Text(
              subtitle!,
              style: Get.textTheme.bodyText2!.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
