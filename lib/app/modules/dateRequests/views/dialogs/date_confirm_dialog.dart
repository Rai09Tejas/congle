import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateConfirmDialog extends StatelessWidget {
  const DateConfirmDialog({
    Key? key,
    required this.title,
    required this.subtitle,
    this.showGif = true,
    this.button,
  }) : super(key: key);

  // final ShortProfile profile;
  final String title;
  final String subtitle;
  final bool showGif;
  final KButton? button;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // insetAnimationCurve: Curves.easeInOutCubic,
      child: Container(
          alignment: Alignment.center,
          height: 300,
          width: Get.width * 0.7,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Get.theme.backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showGif)
                SizedBox(
                  height: 100,
                  child: Image.asset(
                    "assets/gifs/confirm.gif",
                    fit: BoxFit.contain,
                  ),
                ),
              const SizedBox(height: 30),
              Text(
                title,
                style: Get.textTheme.headline6,
              ),
              SizedBox(height: showGif ? 10 : 30),
              Text(
                subtitle,
                style: Get.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: button != null ? 30 : 0),
              if (button != null) button!,
            ],
          )),
    );
  }
}
