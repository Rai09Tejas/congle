import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/home/controllers/home_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
            GetMaterialApp(
              title: "Congle",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              theme: AppThemes.lightTheme,
              builder: (context, widget) {
                return ScrollConfiguration(
                    behavior: const ScrollBehaviorModified(),
                    child: widget ?? const Center());
              },
              onInit: initApp,
              onDispose: disposeApp,
            ),
          ));
}

late final StreamSubscription<ConnectivityResult> _subscription;

initServices() async {
  Get.log('starting services ...');
  await Firebase.initializeApp();

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  ///
  // await Get.putAsync(() => RemoteConfigService().init());
  // await Get.putAsync(() => AnalyticsService().init());

  await Get.putAsync(() => FCMService().init());
  await Get.putAsync(() => PhoneAuthService().init());
  // await Get.putAsync(() => ReceiveIntentService().init());

  /// Initialize APIS
  await Get.putAsync(() => Api().init());
  await Get.putAsync(() => SignupApi().init());
  await Get.putAsync(() => ProfileApi().init());
  // await Get.putAsync(() => ClubApi().init());
  await Get.putAsync(() => DatesApi().init());
  await Get.putAsync(() => ActivityApi().init());
  await Get.putAsync(() => BookingsApi().init());
  Get.log('All services started...');
}

void disposeApp() => _subscription.cancel();

void initApp() async {
  Get.log('Init App');
  Connectivity().checkConnectivity().then((value) {
    if (value == ConnectivityResult.none) Get.to(() => const NoConnectivity());
  });

  _subscription =
      Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    Get.log(result.toString());
    if (result == ConnectivityResult.none) {
      try {
        if (Get.find<HomeController>().pageIndex == 0) {
          Get.find<HomeController>().updatePageIndex(3);
        }
      } on Exception catch (e) {
        Get.log(e.toString());
      }
      Get.to(() => const NoConnectivity());
    } else {
      Get.back();
    }
  });
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
