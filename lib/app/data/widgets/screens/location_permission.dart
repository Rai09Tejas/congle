import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({
    Key? key,
    required this.onLocationGet,
  }) : super(key: key);

  final Function(LocationData? loc) onLocationGet;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.defaultDialog(
            textConfirm: 'Yes',
            confirmTextColor: Colors.white,
            textCancel: 'No',
            title: 'Do you want to Exit App?',
            onConfirm: () =>
                GetPlatform.isAndroid ? SystemNavigator.pop() : exit(0));
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          width: Get.width,
          color: kcBg,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_off_outlined,
                size: 40,
              ),
              const SizedBox(height: 30),
              Text(
                'Location Off!',
                style: Get.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              Text(
                'We need your location access to proceed',
                style: Get.textTheme.bodyText2!.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              KButton(
                title: 'Enable Location',
                padding: const EdgeInsets.all(16),
                onPressed: () async {
                  bool per = await Permission.location.isGranted;
                  if (per == false) await Permission.location.request();

                  LocationData? _loc = await getLocation();
                  if (_loc == null) {
                    showSnackBar(
                        "Please turn on GPS to let us know your location",
                        isError: true);
                    _loc = await getLocation();
                  }
                  // print(_loc.toString());

                  onLocationGet(_loc);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
