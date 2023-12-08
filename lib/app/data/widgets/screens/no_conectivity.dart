import 'dart:io';

import 'package:congle/app/data/config/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NoConnectivity extends StatelessWidget {
  const NoConnectivity({Key? key, this.title, this.subtitle}) : super(key: key);
  const NoConnectivity.apiError(
      {Key? key,
      this.title = "Server Error",
      this.subtitle =
          "We are currently facing some issue. We are trying hard to resolve it as soon as possible.\nThanks For your patience"})
      : super(key: key);

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.defaultDialog(
            textConfirm: 'Yes',
            confirmTextColor: Colors.white,
            textCancel: 'No',
            title: 'Do you want to Exit App?',
            middleText: '',
            onConfirm: () =>
                GetPlatform.isAndroid ? SystemNavigator.pop() : exit(0));
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          width: Get.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                img_no_internet,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              Text(
                title ?? 'No Connectivity!',
                style: Get.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              Text(
                subtitle ?? 'Check your Internet Settings!',
                style: Get.textTheme.bodyText2!.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
