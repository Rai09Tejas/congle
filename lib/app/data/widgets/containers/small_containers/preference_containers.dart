import 'package:congle/app/data/config/colors.dart';
import 'package:flutter/material.dart';

class PreferenceContainers extends StatelessWidget {
  final Widget? title;
  final Widget? trailing;
  final Widget? bottom;
  final double radius;
  final bool isborder;
  final double? pHorizontal, pVertical, mHorizontal, mVertical;

  const PreferenceContainers({
    Key? key,
    this.title,
    this.trailing,
    this.bottom,
    required this.radius,
    required this.isborder,
    this.pHorizontal,
    this.pVertical,
    this.mHorizontal,
    this.mVertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: pHorizontal ?? 10, vertical: pVertical ?? 10),
      margin: EdgeInsets.symmetric(
          vertical: mVertical ?? 8.0, horizontal: mHorizontal ?? 8.0),
      decoration: BoxDecoration(
          border: isborder ? Border.all(color: kcBlack, width: 1) : null,
          color: kcWhite,
          borderRadius: BorderRadius.circular(radius)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Row for Title and Trailing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (title != null) title!,
              if (trailing != null) trailing!,
            ],
          ),
          // Bottom widget
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}
