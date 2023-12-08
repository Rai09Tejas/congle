import 'dart:io';

import 'package:congle/app/data/models/others/new_interest_list.dart';
import 'package:congle/app/modules/profile/controllers/profile_controller.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:congle/app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final api = Get.find<SignupApi>();
  late AboutUser profile;
  RxBool isSaving = false.obs;
  final ImagePicker _picker = ImagePicker();
  XFile? dpImage;
  List<XFile> imageList = [];
  List<File> savedImageList = [];

  late TextEditingController aboutController;
  late TextEditingController workController;
  late RxList<String> interests = RxList.empty();
  @override
  Future<void> onInit() async {
    super.onInit();
    imageList = [];
    savedImageList = [];
    interests = RxList.empty();
    // Congle.currentUser = await Get.find<ProfileApi>().getCurrentUserProfile();
    profile = Congle.currentUser!;
    if (profile.interests != null) {
      for (var item in profile.interests!) {
        interests.add(item);
      }
    }
    aboutController = TextEditingController(text: profile.about);
    workController = TextEditingController(text: profile.jobTitle);
    if (profile.photos != null) await initImages();
  }

  Future<void> initImages() async {
    for (var image in profile.photos!) {
      File _file = await saveImage(image);
      imageList.add(XFile(_file.path));
      update();
    }
  }

  @override
  void onClose() {}

  Future<File> saveImage(String imgUrl) async {
    var response = await http.get(Uri.parse(imgUrl));
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = File(join(documentDirectory.path, imgUrl.split('/').last));
    file.writeAsBytesSync(response.bodyBytes);
    savedImageList.add(file);
    return file;
  }

  onProfileSave() async {
    isSaving.toggle();
    if (workController.text != '' && workController.text != profile.jobTitle) {
      await api.setWork(workController.text);
    }
    if (aboutController.text.toString() != "" &&
        aboutController.text != profile.about) {
      await api.setAbout(aboutController.text);
    }
    if (profile.interests.toString() != interests.toList().toString()) {
      await addInterests();
    }
    if (dpImage != null) await uploadDP();
    if (savedImageList.length < imageList.length ||
        savedImageList.length < profile.photos!.length) await uploadPhotoList();

    isSaving.toggle();
    await Get.find<ProfileController>().updateProfile();
    Congle.currentUser = await Get.find<ProfileApi>().getCurrentUserProfile();
    Get.back();
  }

  /// Adding Interests
  Future<List<InterestCategory>> getInterests() async =>
      await api.getInterests();

  addInterests() async {
    if (interests.length < 5) {
      showSnackBar("Select minimum 5 interests", isError: true);
    } else {
      await api.addInterests(interests);
    }
  }

  /// Add Photos
  addDP() async {
    dpImage = await _picker.pickImage(source: ImageSource.gallery);
    update();
  }

  addOtherImage() async {
    final _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      imageList.add(_image);
      update();
    } else {
      showSnackBar("Error getting image");
    }
  }

  removeImage(XFile image) async {
    imageList.removeWhere((element) => element == image);
    savedImageList.removeWhere((element) => element.path == image.path);
    update();
  }

  uploadDP() async {
    Get.log(dpImage!.path.toString());
    await api.setDP(File(dpImage!.path));
  }

  uploadPhotoList() async {
    List<File> _images = imageList.map((e) => File(e.path)).toList();
    // print(_images.toString());
    await api.setPhotos(_images);
  }
}
