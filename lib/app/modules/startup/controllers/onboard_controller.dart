import 'dart:developer';

import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardController extends GetxController {
  final onBoardItems = [
    _OnBoardModel(img_onBoard_1, 'Ready to Expand Your Circle?',
        'Feeling a bit alone in this big world?  It\'s time to \nconnect, make friends, and meet locals who get you!'),
    _OnBoardModel(img_onBoard_2, 'Get Out There, Meet New Friends',
        'Say goodbye to “Online profiles” and hello to authentic \nconnections. Send connection requests, and let\'s get \nreal over coffee or a latte!'),
    _OnBoardModel(img_onBoard_3, 'Find Love, Fast \nand Furious',
        'Fridays are for speed dating! Swipe right on local \nevents, meet your matches, and who knows, love might \njust be in the air!'),
  ];

  final PageController pageController = PageController();
  final _duration = 300.milliseconds;
  final _curve = Curves.decelerate;
  Rx<int> currentPage = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page!.round();
      Get.log(currentPage.toString());
    });
  }

  @override
  void onClose() {}

  updatePage() {
    currentPage.value = pageController.page!.round();
  }

  Future<void> animateToNextPage() async {
    await pageController.nextPage(duration: _duration, curve: _curve);
    updatePage();
  }

  Future<void> autoScroll() async {
    await Future.delayed(1000.milliseconds);
    if (pageController.hasClients) {
      Future.delayed(3.seconds).then((value) {
        if (pageController.hasClients &&
            pageController.page != onBoardItems.length - 1) {
          pageController.nextPage(duration: _duration, curve: _curve);
          autoScroll();
        }
      });
    }
  }
}

class _OnBoardModel {
  final String image;
  final String title;
  final String subtitle;

  _OnBoardModel(this.image, this.title, this.subtitle);
}
