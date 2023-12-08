import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar(
      {Key? key,
      this.title,
      this.customTitle,
      required this.leftImg,
      this.rightImg,
      this.size,
      this.isTtileBold = true,
      this.hPadding,
      this.vPadding,
      this.leftFun,
      this.rightFun})
      : super(key: key);
  final String? title, leftImg;
  final String? rightImg;
  final double? size, hPadding, vPadding;
  final bool? isTtileBold;
  final Widget? customTitle;
  final Function? leftFun, rightFun;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: hPadding ?? 0, vertical: vPadding ?? 0),
        width: Get.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if (leftFun != null) {
                  leftFun!();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black26, width: 1)),
                child: Container(
                    padding: const EdgeInsets.all(6),
                    child: KSvgIcon(
                      assetName: leftImg,
                      size: 24,
                    )),
              ),
            ),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: customTitle ??
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: title!.runes.map((int rune) {
                          final character =
                              String.fromCharCode(rune).toUpperCase();
                          final fontFamily = character == 'O'
                              ? 'TestDomaine'
                              : 'Hanken Grotesk';
                          final style = Get.textTheme.titleLarge!.copyWith(
                            color: kcBlack,
                            fontSize: size,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w600,
                          );

                          return TextSpan(
                            text: character,
                            style: style,
                          );
                        }).toList(),
                      ),
                    ),
              ),
            ),
            const Spacer(),
            if (rightImg != null)
              InkWell(
                onTap: () {
                  rightFun!();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black26, width: 1)),
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      child: KSvgIcon(assetName: rightImg, size: 24)),
                ),
              ),
          ],
        ));
  }
}
