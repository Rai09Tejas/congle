import 'dart:convert';
import 'dart:io';

import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/models/others/new_interest_list.dart';
import 'package:congle/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../../models/user/user_data.dart';

class SignupApi extends GetConnect {
  late Api api;
  Future<SignupApi> init() async {
    Get.log('$runtimeType ready');
    api = Get.find<Api>();
    return this;
  }

  Future getProfile() async {
    const extUrl = '/user/getProfile';
    await api.getReq(extUrl, (resp) {});
  }

  Future<String?> getDP() async {
    const extUrl = '/user/getDP';
    String? dp;
    await api.getReq(extUrl, (resp) {
      dp = resp;
    });
    return dp;
  }

  Future<bool> validateUsername(String username) async {
    const extUrl = '/user/usernameAvailable';
    final Map<String, dynamic> body = {"username": username};
    Get.log("Sent Body: ${jsonEncode(body)}");
    bool isAvailable = false;
    await api.postReq(extUrl, body, (resp) {
      isAvailable = resp['isAvailable'];
    });
    return isAvailable;
  }

  ///
  Future signUp(UserData user) async {
    const extUrl = '/auth/signUp';
    Map<String, dynamic> body = user.toMap();
    Get.log("Sent Body: ${jsonEncode(body)}");
    await api.postReq(extUrl, body, (resp) {
      if (resp != null) Get.log(resp.toString());
      Get.offAllNamed(Routes.HOME);
    });
  }

  Future setDP(File dp) async {
    const extUrl = '/user/setAvatar';
    await api.uploadImage(extUrl, 'dp', dp);
  }

  Future setPhotos(List<File> images) async {
    const extUrl = '/user/setPhotos';
    await api.uploadMultipleImages(extUrl, images);
  }

  Future<List<InterestCategory>> getInterests() async {
    const extUrl = '/user/interests';
    List<InterestCategory> interests = [];
    await api.getReq(extUrl, (resp) {
      for (var item in resp['data']) {
        interests.add(InterestCategory.fromMap(item));
      }
    });
    Get.log(interests.toString());
    return interests;
  }

  Future addInterests(List<String> interests) async {
    const extUrl = '/user/setIntrests';
    final Map<String, dynamic> body = {"intrests": interests};
    await api.postReq(extUrl, body, (resp) {});
  }

  Future setAbout(String abt) async {
    const extUrl = '/user/setAbout';
    final Map<String, dynamic> body = {"about": abt};
    Get.log("Sent Body: ${jsonEncode(body)}");
    await api.postReq(extUrl, body, (resp) {});
  }

  Future setWork(String work) async {
    const extUrl = '/user/setWork';
    final Map<String, dynamic> body = {"work": work};
    Get.log("Sent Body: ${jsonEncode(body)}");
    await api.postReq(extUrl, body, (resp) {});
  }

  Future setLocation(LocationData loc) async {
    const extUrl = '/user/setLocation';
    final Map<String, dynamic> body = {
      "type": "Point",
      "coordinates": [loc.longitude, loc.latitude]
    };
    Get.log("Sent Body: ${jsonEncode(body)}");
    await api.postReq(extUrl, body, (resp) {});
  }

  Future<List<ShortProfile>> getNearbyProfiles() async {
    const extUrl = '/user/getNearbyProfiles';
    final List<ShortProfile> profiles = [];
    await api.getReq(extUrl, (resp) {
      for (var item in resp) {
        profiles.add(ShortProfile.fromMap(item));
      }
    });
    return profiles;
  }

  Future<List<ShortClub>> getNearbyClubs() async {
    const extUrl = '/club/getClubRecommendation';
    final List<ShortClub> clubs = [];

    await api.getReq(extUrl, (resp) {
      for (var item in resp) {
        clubs.add(ShortClub.fromMap(item));
      }
    });

    return clubs;
  }
}
