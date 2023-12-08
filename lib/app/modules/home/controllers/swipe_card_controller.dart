// ignore_for_file: unnecessary_overrides

import 'package:congle/app/data/data.dart';
import 'package:congle/packages/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SwipeCardController extends GetxController {
  /// this signifies that no more profile is left in the data to show
  RxBool nothingLeft = false.obs;

  OverlayEntry? spotifyEntry;
  OverlayEntry? instaEntry;

  /// if `infoProfile` is true then user has navigated to Profile info page
  RxBool infoProfile = false.obs;

  OverlayEntry? overlayEntry;
  Offset? indicatorOffset;

  /// list of profiles to show on swipe screen
  List<Profile> profiles = [];

  /// these 5 feilds are for handling prefrences with these default values
  Rx<Gender> showMeGender = Gender.MALE.obs;
  RxList<String> selectedIntrests = RxList.empty();
  RxDouble distanceLimit = 20.0.obs;
  RxDouble lAgeLimit = 20.0.obs;
  RxDouble uAgeLimit = 27.0.obs;

  final datesApi = Get.find<DatesApi>();

  bool isPrefChanged = false;

  @override
  void onInit() {
    if (Congle.currentUser != null) {
      showMeGender.value = Congle.currentUser!.gender == Gender.FEMALE
          ? Gender.MALE
          : Gender.FEMALE;
    }
    super.onInit();
  }

  @override
  void onClose() {
    Overlay.of(Get.overlayContext!)!.dispose();
    super.onClose();
  }

  /// gets profiles from server and handles it
  Future<void> addProfiles() async {
    // if (nothingLeft.isTrue) nothingLeft.toggle();
    profiles = await datesApi.getSwipeInfo(
        distance: distanceLimit.value,
        gender: showMeGender.value,
        intrests: selectedIntrests,
        lAgeLimit: lAgeLimit.value,
        uAgeLimit: uAgeLimit.value);
    if (profiles.isEmpty && nothingLeft.isFalse) nothingLeft.toggle();
    // print(nothingLeft.value);
  }

  void getBackAndRefresh() async {
    if (isPrefChanged) {
      Get.dialog(
        const LoadingDots.long(
          color: kcWhite,
        ),
        barrierDismissible: false,
      );
      profiles = [];
      await addProfiles();
      Get.back();
    }
    Get.back();
  }

  /// Info button callback
  void iButtonCallback() {
    if (infoProfile.value == false) infoProfile.toggle();
    update();
    Get.to(() => ProfileDetailsScreen(
              profile: profiles.first.aboutUser,
              mainButton: KButton(
                title: 'Send Request',
                onPressed: () {
                  myCallbackEnd(
                      Decision.like,
                      Match(decision: Decision.like, profile: profiles.first),
                      (profiles.length <= 1));
                  Get.back();
                },
              ),
              secButton: KOutlineButton(
                title: 'Reject',
                onPressed: () {
                  myCallbackEnd(
                      Decision.nope,
                      Match(decision: Decision.nope, profile: profiles.first),
                      (profiles.length <= 1));
                  Get.back();
                },
                isTextWhite: false,
              ),
            ))!
        .whenComplete(() {
      if (infoProfile.value == true) infoProfile.toggle();
      update();
    });
  }

  /// Spotify callback i.e., in profile card when spotify is tapped
  void spotifyButtonCallback() {
    Get.log('Spotify Pressed');
    spotifyEntry = OverlayEntry(
        builder: (context) => KBottomDialogContainer(
            onTap: removeEntry,
            child: KSpotifyContainer(
              spotify: profiles.first.aboutUser.spotify,
            )));
    Overlay.of(Get.overlayContext!)!.insert(spotifyEntry!);
    update();
  }

  /// Insta button callback i.e., in profile card when insta is tapped
  void instaButtonCallback() {
    Get.log('INSTAGRAM Pressed');
    instaEntry = OverlayEntry(
        builder: (context) => KBottomDialogContainer(
            height: Get.width * 0.8,
            onTap: removeEntry,
            child: KInstagramContainer(
                instaProfile: profiles.first.aboutUser.instagram)));
    Overlay.of(Get.overlayContext!)!.insert(instaEntry!);
    update();
  }

  void removeEntry() {
    if (instaEntry?.mounted ?? false) instaEntry!.remove();
    if (spotifyEntry?.mounted ?? false) spotifyEntry!.remove();
  }

  /// when user starts to drag
  void myCallbackStart(double dx) {}

  /// when user is draging the card
  void myCallbackDistance(double dx) {}

  /// when user swipes a card
  /// does all api calls from here
  void myCallbackEnd(
      Decision? decision, Match? match, bool nothingAvailableNext) async {
    Get.log(decision.toString());
    if (match != null) Get.log(match.profile!.aboutUser.name);
    profiles.removeAt(0);
    update();

    /// Right Swipe: Add User to date entry
    if (decision == Decision.like) {
      await datesApi.viewProfile(match!.profile!.aboutUser.uid).then((value) {
        if (!value) KErrorToast();
      });
      await datesApi.requestDate(match.profile!.aboutUser.uid).then((value) {
        if (!value) KErrorToast();
      });
    }

    /// Left Swipe: Add User to view of the other one
    if (decision == Decision.nope) {
      await datesApi.viewProfile(match!.profile!.aboutUser.uid).then((value) {
        if (!value) KErrorToast();
      });
    }

    /// if no other user left
    if (nothingAvailableNext || profiles.isEmpty) {
      if (nothingLeft.value == true) nothingLeft.toggle();
    }
  }

  /// handling distance from pref
  void onDistanceChange(dynamic value) {
    distanceLimit.value = value;
    isPrefChanged = true;
    update();
  }

  /// handling age from pref
  void onAgeChange(SfRangeValues range) {
    lAgeLimit.value = range.start;
    uAgeLimit.value = range.end;
    isPrefChanged = true;
    update();
  }

  /// handling intrests from pref
  void addOrRemoveIntrest(String s) {
    isPrefChanged = true;
    selectedIntrests.contains(s)
        ? selectedIntrests.remove(s)
        : selectedIntrests.add(s);
  }

  /// handling gender from pref
  void changeGender(Gender? value) {
    if (value != null) {
      showMeGender.value = value;
      showMeGender.refresh();
    }
    isPrefChanged = true;
    Get.back();
  }

  void onGenderChangeCallback() {
    Get.bottomSheet(KGenderSwitchBottomSheet(
      rxGender: showMeGender,
      onChanged: changeGender,
      onTap: removeEntry,
    ));
  }

  /// Animations Handled here
  ///
  /// Changes the indicator according to the drag made by user
  /// and maxifies it when users drag is greater than 80% of the card width
  /// and returns new Offset
  Offset getIndicatorOffset(Offset dragOffset) {
    final double tempdx = dragOffset.dx.abs() > Get.width * 0.8
        ? Get.width
        : dragOffset.dx.abs() * 1.2;
    final double x = Get.width - tempdx;
    return Offset(x, dragOffset.dx);
  }
}
