import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KSliderTile extends StatelessWidget {
  const KSliderTile({
    Key? key,
    required this.title,
    this.subtitle,
    required this.slider,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget slider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(title, style: Get.textTheme.headline6),
              ),
              Expanded(flex: 2, child: slider),
            ],
          ),
          Text(subtitle!,
              style: Get.textTheme.bodyText2!
                  .copyWith(fontSize: 16, color: Get.theme.focusColor)),
        ],
      ),
    );
  }
}
