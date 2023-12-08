import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data.dart';

class KFilterChip extends StatelessWidget {
  const KFilterChip({
    Key? key,
    required this.text,
    this.assetName,
    this.isSelected = false,
    this.tooltip,
    this.color,
    this.onSelected,
  }) : super(key: key);

  final String text;
  final String? assetName;
  final bool isSelected;
  final String? tooltip;
  final Color? color;
  final Function(bool val)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(text),
      onSelected: onSelected ?? (val) {},
      backgroundColor: color ?? (isSelected ? kcAccent : kcBg),
      shape:
          // ignore: unnecessary_const
          isSelected
              ? null
              : const StadiumBorder(side: BorderSide(color: kcBlack)),
      avatar: assetName != null
          ? KSvgIcon(
              assetName: assetName,
              color: Colors.black,
            )
          : null,
      tooltip: tooltip,
      labelStyle: Get.textTheme.bodyText2!
          .copyWith(color: isSelected ? kcWhite : kcBlack),
      selected: isSelected,
      selectedColor: kcAccent,
      showCheckmark: false,
    );
  }
}
