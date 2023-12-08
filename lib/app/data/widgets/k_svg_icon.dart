import 'package:get/get.dart';

import '../config/config.dart';
import 'package:flutter/material.dart';

class KSvgIcon extends StatelessWidget {
  const KSvgIcon(
      {Key? key,
      required this.assetName,
      this.size = 20,
      this.color = Colors.black,
      this.fit = BoxFit.contain})
      : super(key: key);
  final String? assetName;
  final double size;
  final Color color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: SvgPicture.asset(
        assetName!,
        alignment: Alignment.center,
        fit: fit,
        color: color,
      ),
    );
  }
}

final Widget kiCross = CircleAvatar(
  backgroundColor: Get.theme.focusColor,
  radius: 12,
  child: CircleAvatar(
    backgroundColor: kcLameGrey,
    radius: 10,
    child: Icon(
      Icons.close,
      size: 17,
      color: Get.theme.focusColor,
    ),
  ),
);
