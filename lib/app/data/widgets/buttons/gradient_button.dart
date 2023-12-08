import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data.dart';

class KButton extends StatelessWidget {
  const KButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.padding = const EdgeInsets.all(8),
    this.leading,
    this.solidColor,
    this.textColor,
    this.bRadius = 50.0,
    this.fontSize = 14,
    this.heroTag,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  final EdgeInsets padding;
  final Widget? leading;
  final Color? solidColor;
  final Color? textColor;
  final double bRadius;
  final double fontSize;
  final String? heroTag;


  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(bRadius);
    return Material(
      borderRadius: borderRadius,
      elevation: 1,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        splashColor: Get.theme.splashColor,
        child: heroTag != null
            ? Hero(
                tag: heroTag!,
                child: _ButtonContainer(
                    padding: padding,
                    borderRadius: borderRadius,
                    solidColor: solidColor,
                    leading: leading,
                    title: title,
                    textColor: textColor,
                    fontSize: fontSize))
            : _ButtonContainer(
                padding: padding,
                borderRadius: borderRadius,
                solidColor: solidColor,
                leading: leading,
                title: title,
                textColor: textColor,
                fontSize: fontSize),
      ),
    );
  }
}

class _ButtonContainer extends StatelessWidget {
  const _ButtonContainer({
    Key? key,
    required this.padding,
    required this.borderRadius,
    required this.solidColor,
    required this.leading,
    required this.title,
    required this.textColor,
    required this.fontSize,
  }) : super(key: key);

  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final Color? solidColor;
  final Widget? leading;
  final String title;
  final Color? textColor;
  final double fontSize;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: solidColor == null ? kcgButton : null,
        color: solidColor,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            if (leading != null) const SizedBox(width: 5),
            
            Text(
              title,
              style: TextStyle(
                  fontFamily: "Hanken Grotesk",
                  color: textColor ?? Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
