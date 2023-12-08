import 'package:congle/app/data/config/config.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    focusColor: kcGeryIcon,
    canvasColor: Colors.white,
    // buttonColor: kcAccent,
    cardColor: kcBg,
    disabledColor: kcGeryIcon,
    iconTheme: IconThemeData(color: kcGeryIcon),
    indicatorColor: kcAccent,
    dividerColor: Colors.black87,
    hintColor: kcGeryIcon,
    splashColor: kcLightGrey,
    // accentColorBrightness: Brightness.light,
    // accentIconTheme: IconThemeData(color: kcGeryIcon),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black)),
    fontFamily: 'Helvetica',
    textTheme: _textTheme,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color(0xFF292929))
        .copyWith(background: kcBgAccent),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
  );

  static const TextTheme _textTheme = TextTheme(
    bodySmall: TextStyle(
      fontFamily: 'HankRnd',
      fontSize: 12,
      color: Color(0xff1c1c1c),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 26,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontSize: 42,
      color: Colors.black,
      // fontFamily: 'HankRnd',
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      color: Colors.black,
      fontFamily: 'HankRnd',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontFamily: 'HankRnd',
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontFamily: 'HankRnd',
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      fontFamily: 'HankRnd',
      fontSize: 16,
      color: Color(0x523b3b3b),
      fontWeight: FontWeight.w700,
    ),
    labelLarge: TextStyle(
      fontFamily: 'HankRnd',
      fontSize: 14,
      color: Color(0xffffffff),
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      color: Color(0xff858585),
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'HankRnd',
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );
}
