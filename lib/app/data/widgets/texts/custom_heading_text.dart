import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customHeadingText(String title, Color color, double size, FontWeight fontWeight) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      children: title.runes.map((int rune) {
        final character = String.fromCharCode(rune).toUpperCase();
        final fontFamily = character == 'O' ? 'TestDomaine' : 'Hanken Grotesk';
        final style = Get.textTheme.titleLarge!.copyWith(
          color: color,
          fontSize: size,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
        );

        return TextSpan(
          text: character,
          style: style,
        );
      }).toList(),
    ),
  );
}
