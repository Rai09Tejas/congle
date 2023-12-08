import 'package:flutter/material.dart';

Widget customHankenText(String text, Color color, double size,
    FontWeight weight, TextAlign? textAlign) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontFamily: "Hanken Grotesk",
        fontSize: size,
        fontWeight: weight),
  );
}

Widget customTestDomaineText(
    String text, Color color, double size, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontFamily: "TestDomaine",
        fontSize: size,
        fontWeight: weight),
  );
}
