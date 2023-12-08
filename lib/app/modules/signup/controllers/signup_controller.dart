import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/models/others/new_interest_list.dart';
import 'package:congle/app/data/models/user/user_data.dart';
import 'package:congle/app/modules/signup/views/dialogs/info_confirm_dialog.dart';

import '../../../data/enums/reason.dart';
import '../../../data/helpers/asset_to_xfile.dart';

class SignupController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  RxInt pageNo = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLocationPermissionMissing = false.obs;
  RxBool isMediaPermissionMissing = false.obs;
  RxBool isPermissionScreen = true.obs;
  RxBool canContinue = false.obs;
  Rx<Gender> myGender = Gender.MALE.obs;
  RxBool isDateSelection = false.obs;
  RxBool isPermAsked = false.obs;

  List location = [];
  final TransformationController transformationController =
      TransformationController();

  Rx<DateTime> dob = DateTime.now().obs;
  TextEditingController dobController = TextEditingController();

  Function currentPageFunction = () {};
  SignupApi api = SignupApi();

  final PageController pageController = PageController();

  final UserData _userData = UserData.empty();

  @override
  void onInit() async {
    api.init();
    setInitialPage();
    setUid();
    super.onInit();
    pageController.addListener(() {
      pageNo.value = pageController.page!.round();
      if (pageNo.value == 7) {
        canContinue.value = true;
      }
    });
    getInterests();
    transformationController.value = Matrix4.identity()..scale(3.0);
  }

  setUid() {
    if (user != null) {
      _userData.uid = user!.uid;
    }
  }

  setInitialPage() async {
    var locStatus = await Permission.location.status;
    var mediaStatus = await Permission.storage.status;
    if (locStatus == PermissionStatus.denied ||
        mediaStatus == PermissionStatus.denied) {
      pageController.jumpToPage(0);
      canContinue.value = true;
    } else {
      isPermissionScreen.value = false;
      pageNo.value = 1;
      pageController.jumpToPage(1);
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) nextPage();
  }

  @override
  void onClose() {}

  /// Signup basic Data

  /// Basic data page controllers
  final nameController = TextEditingController();
  final usernameController = TextEditingController();

  logout() => Get.find<PhoneAuthService>().signOut();

  void onGenderChangeCallback() => Get.bottomSheet(KGenderSwitchBottomSheet(
        rxGender: myGender,
        onChanged: (value) {
          if (value != null) {
            myGender.value = value;
            myGender.refresh();
          }
          Get.back();
        },
        onTap: () {},
      ));

  void changeDate(DateTime date) {
    dob.value = date;
    Get.log(dob.toString());
  }

  Future<bool> validateUserName() async {
    final String username = usernameController.text;
    final regex = RegExp(r"^[a-z0-9_]{3,12}$");
    if (username.length < 5) {
      showSnackBar("Username can't be null or must be 5-12 chars",
          isError: true);
      return false;
    } else if (!regex.hasMatch(username)) {
      showSnackBar("Username Invalid: only lowercase with '_' is valid.",
          isError: true);
      return false;
    }
    bool isAvailable = await api.validateUsername(username);
    if (!isAvailable) showSnackBar("Username Unavailable", isError: true);
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    return isAvailable;
  }

  addBasicData() async {
    final String name = nameController.text;

    if (name.length < 3) {
      showSnackBar("Name can't be null or less than 3 chars", isError: true);
    } else if (dob == null) {
      showSnackBar("Date of Birth can't be null", isError: true);
    } else if (dob.value.year > (DateTime.now().year - 18)) {
      showSnackBar(
          "You are not elligible to use this app. Read our Terms & Conditions",
          isError: true);
    } else {
      if (await validateUserName()) {
        Get.bottomSheet(InfoConfirmDialogContainer(onAccept: acceptContinue));
      } else {
        showSnackBar("Username Unavailable", isError: true);
      }
    }
  }

  acceptContinue() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    isLoading.toggle();
    Get.back();
    await api.signUp(_userData);
    isLoading.toggle();
  }

  /// Add Photos
  List<XFile> imageList = [];
  List<String> convertedimageList = [];
  RxInt totalImages = 0.obs;

  Future<void> pickImages() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3 - imageList.length, // Limit to a maximum of 3 images
        enableCamera: false,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      log(e.toString());
    }

    if (resultList.isNotEmpty) {
      // Use Future.wait to wait for all assetToXFile calls to complete
      List<XFile> xFiles = await Future.wait(
        resultList.map((asset) => assetToXFile(asset)),
      );

      // Now you can use the xFiles list
      imageList.addAll(xFiles);
      totalImages.value = imageList.length;
    }
    if (totalImages.value == 3) {
      convertedimageList = [];
      imageList.map((data) async {
        convertedimageList.add(await convertXFileToBuffer(data) ?? '');
      }).toList();
      canContinue.value = true;
    }
  }

  void deleteImage(int index) {
    imageList.removeAt(index);
    totalImages.value = imageList.length;
  }

  addPhotos() async {
    // isLoading.toggle();
    if (imageList.length == 3) {
      _userData.dp = convertedimageList[0];
      _userData.photos = [];
      _userData.photos?.add(convertedimageList[1]);
      _userData.photos?.add(convertedimageList[2]);
      // nextPage();
      Get.log(_userData.toJson().toString());
    } else {
      showSnackBar("Display pic with 3 more photos are required",
          isError: true);
    }
    // isLoading.toggle();
  }

  void createTextFile(String content) async {
    try {
      // Get the application documents directory
      Directory appDocDir = await getApplicationDocumentsDirectory();

      // Specify the file path and name
      String filePath = '${appDocDir.path}/example.txt';

      // Create the file and write the content
      File file = File(filePath);
      await file.writeAsString(content);

      print('File created successfully: $filePath');
    } catch (e) {
      print('Error creating file: $e');
    }
  }

  Future<String?> convertXFileToBuffer(XFile xfile) async {
    final bytes = File(xfile.path).readAsBytesSync();
    return "data:image/png;base64,${base64Encode(bytes)}";
  }

  /// Adding about & work
  final aboutController = TextEditingController();
  final workController = TextEditingController();
  final companyController = TextEditingController();

  addAbout() async {
    final String about = aboutController.text;
    final String work = workController.text;
    if (about.length < 12) {
      showSnackBar("About can't be null or less than 12 chars", isError: true);
    } else if (work == null) {
      showSnackBar("Work can't be null or less than 5 chars", isError: true);
    } else if (work.length < 5 || work.length > 60) {
      showSnackBar("Work must be between 5-60 characters", isError: true);
    } else {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      isLoading.toggle();
      await api.setAbout(about);
      await api.setWork(work);
      nextPage();
      isLoading.toggle();
    }
  }

  linkAccounts() async {
    isLoading.toggle();
    await Future.delayed(3.seconds).then((value) => nextPage());
    isLoading.toggle();
  }

  allowPermissions() async {
    await locPermission();
    await mediaPermission();
    if (!isLocationPermissionMissing.value && !isMediaPermissionMissing.value) {
      isLoading.toggle();
      var loc = await getLocation();
      if (loc != null) {
        // await api.setLocation(loc); //TODO: uncomment this
      } else {
        showSnackBar("Please turn on GPS to let us know your location",
            isError: true);
        loc = await getLocation();
        // if (loc != null) await api.setLocation(loc); //TODO: uncomment this
      }
      isPermissionScreen.value = false;
      nextPage();
      // accountSetupComplete();
      isLoading.toggle();
    }
  }

  locPermission() async {
    var locStatus = await Permission.location.request();

    if (locStatus == PermissionStatus.denied) {
      // showSnackBar("We need Location Permission to Proceed");
      isLocationPermissionMissing.value = true;
      locPermission();
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      location.add(position.latitude);
      location.add(position.longitude);

      _userData.loc['coordinates'] = location;

      isLocationPermissionMissing.value = false;
    }
    Get.log(locStatus.toString());
  }

  mediaPermission() async {
    var mediaStatus = await Permission.storage.status;
    Get.log('perm asked 1$mediaStatus');

    if (mediaStatus == PermissionStatus.denied) {
      // Permission has not been requested yet, request it now
      mediaStatus = await Permission.storage.request();
      Get.log('perm asked 2$mediaStatus');

      if (mediaStatus == PermissionStatus.denied) {
        // Permission request was denied
        isMediaPermissionMissing.value = true;
      } else {
        // Permission request was granted
        isMediaPermissionMissing.value = false;
      }
    } else if (mediaStatus == PermissionStatus.permanentlyDenied) {
      // The user has previously denied the permission and selected 'Don't ask again'
      // You might want to open the app settings to allow the user to enable the permission
      openAppSettings();
    } else {
      // Permission has already been granted
      isMediaPermissionMissing.value = false;
    }

    Get.log(mediaStatus.toString());
  }

  /// New Signup Data Store Flow
  ///

  addReason(Reason reason) {
    _userData.reason = getReasonString(reason);
    // Get.log(_userData.toMap().toString());
    canContinue.value = true;
    // nextPage();
  }

  checkName() {
    if (nameController.text.length < 3) {
      showSnackBar("Name can't be null or less than 3 chars", isError: true);
      return;
    } else {
      canContinue.value = true;
    }
  }

  Timer? _nameTimer;
  addName() async {
    _nameTimer?.cancel();
    final String name = nameController.text;

    _nameTimer = Timer(const Duration(seconds: 2), () {
      _userData.name = name;
    });
  }

  addGender(Gender gender) {
    _userData.gender = getGenderString(gender);
    canContinue.value = true;
    // nextPage();
  }

  Timer? _workTimer;

  checkWork() {
    _workTimer?.cancel(); // Cancel previous timer if it exists

    _workTimer = Timer(const Duration(seconds: 2), () {
      final String work = workController.text;
      final String company = companyController.text;
      bool workCheck = work != '' && work.length > 5 && work.length < 60;
      bool companyCheck =
          company != '' && company.length > 5 && company.length < 60;
      if (workCheck && companyCheck) {
        canContinue.value = true;
      } else {
        canContinue.value = false;
        showSnackBar(
          "Work can't be null or less than 5 chars",
          isError: true,
        );
      }
    });
  }

  addWork() {
    _userData.jobTitle = workController.text;
    _userData.companyName = companyController.text;
  }

  checkIfDateIsChanged() {
    bool val = !(dob.value.day == DateTime.now().day &&
        dob.value.month == DateTime.now().month &&
        dob.value.year == DateTime.now().year);
    // canContinue.value = true;
    return val;
  }

  addDate(DateTime date) {
    dob.value = date;
    _userData.dob = date.millisecondsSinceEpoch;
    canContinue.value = true;
  }

  RxList<InterestCategory?> myInterests = <InterestCategory?>[].obs;

  addInterest(InterestCategory interest) {
    myInterests.add(interest);
  }

  removeInterest(InterestCategory interest) {
    myInterests.remove(interest);
  }

  accountSetupComplete() async {
    Congle.currentUser = await Get.find<ProfileApi>().getCurrentUserProfile();
    Get.offAllNamed("/home");
  }

  nextPage() {
    callMethodByPage();
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    pageController.nextPage(
        duration: 300.milliseconds, curve: Curves.decelerate);
    canContinue.value = pageNo.value == 8;
  }

  prevPage() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    pageController.previousPage(
        duration: 300.milliseconds, curve: Curves.decelerate);
    canContinue.value = true;
  }

  goToPage(int page) {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    pageController.jumpToPage(page);
  }

  callMethodByPage() {
    log(pageNo.toString());
    switch (pageNo.value) {
      case 2:
        addName();
        break;
      case 5:
        addWork();
        break;
      case 7:
        addPhotos();
        break;
      case 8:
        acceptContinue();
        break;
      default:
        break;
    }
  }

  List<InterestCategory> dataList = [
    InterestCategory(
        category: 'Fitness & Outdoor Activities', interest: 'Hiking'),
    InterestCategory(
        category: 'Fitness & Outdoor Activities', interest: 'Yoga'),
    InterestCategory(
        category: 'Fitness & Outdoor Activities', interest: 'Cycling'),
    InterestCategory(
        category: 'Fitness & Outdoor Activities', interest: 'Running'),
    InterestCategory(
        category: 'Fitness & Outdoor Activities', interest: 'Swimming'),
    InterestCategory(category: 'Sports', interest: 'Football'),
    InterestCategory(category: 'Sports', interest: 'Cricket'),
    InterestCategory(category: 'Sports', interest: 'Badminton'),
    InterestCategory(category: 'Sports', interest: 'Gym'),
    InterestCategory(category: 'Arts & Creativity', interest: 'Dancing'),
    InterestCategory(category: 'Arts & Creativity', interest: 'Photography'),
    InterestCategory(category: 'Arts & Creativity', interest: 'Painting'),
    InterestCategory(category: 'Arts & Creativity', interest: 'Songwriting'),
    InterestCategory(category: 'Arts & Creativity', interest: 'Poetry'),
    InterestCategory(category: 'Entertainment & Media', interest: 'Concerts'),
    InterestCategory(
        category: 'Entertainment & Media', interest: 'Video Games'),
    InterestCategory(category: 'Entertainment & Media', interest: 'Netflix'),
    InterestCategory(category: 'Entertainment & Media', interest: 'Stand-up'),
    InterestCategory(category: 'Entertainment & Media', interest: 'Youtuber'),
    InterestCategory(category: 'Food & Beverage', interest: 'Cooking'),
    InterestCategory(category: 'Food & Beverage', interest: 'Coffee'),
    InterestCategory(category: 'Social Activities', interest: 'Clubbing'),
    InterestCategory(category: 'Social Activities', interest: 'House Party'),
    InterestCategory(category: 'Fashion & Lifestyle', interest: 'Sneakerhead'),
    InterestCategory(category: 'Fashion & Lifestyle', interest: 'Streetwear'),
    InterestCategory(category: 'Reading & Writing', interest: 'Reading'),
    InterestCategory(category: 'Business & Finance', interest: 'Stock Market'),
    InterestCategory(category: 'Business & Finance', interest: 'Startups'),
  ];

  /// Adding Interests
  RxBool isInterestsUpdated = false.obs;
  getInterests() async {
    List<InterestCategory> list = await api.getInterests();
    if (list.isNotEmpty) {
      dataList = list;
    }
    Get.log('interest list: $dataList');
    isInterestsUpdated.value = true;
  }

  Timer? _interestTimer;

  checkInterests() async {
    _interestTimer?.cancel();
    _interestTimer = Timer(const Duration(seconds: 2), () {
      if (myInterests.length < 5) {
        canContinue.value = false;
        showSnackBar("Select minimum 5 interests", isError: true);
      } else {
        // Get.log(_userData.toMap().toString());
        canContinue.value = true;
      }
    });
  }

  addInterets() {
    _userData.interests = [];
    List<String> temp = [];
    myInterests.map((element) => temp.add(element!.interest.toString()));

    _userData.interests = temp;
  }
}
