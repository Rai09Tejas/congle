import 'package:congle/app/data/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Shows SnackBar with custom msg & `duration` is in milliseconds
showSnackBar(String msg,
        {bool isError = false,
        num duration = 2500,
        bool isDismissible = true,
        Widget? mainButton}) =>
    Get.showSnackbar(GetSnackBar(
      message: msg,
      duration: duration.milliseconds,
      backgroundColor: isError ? Colors.red : const Color(0xFF292929),
      isDismissible: isDismissible,
      mainButton: mainButton,
    ));
