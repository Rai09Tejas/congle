import 'dart:convert';

import 'package:get/get.dart';

import '../../../data.dart';

class ActivityApi extends GetConnect {
  late Api api;
  Future<ActivityApi> init() async {
    Get.log('$runtimeType ready');
    api = Get.find<Api>();
    return this;
  }

  Future<List<ActivityCategory>> getCategories() async {
    const _extUrl = '/activity/getCategories';
    final List<ActivityCategory> categories = [];
    await api.getReq(_extUrl, (resp) {
      for (var res in resp) {
        categories.add(ActivityCategory.fromMap(res));
      }
    });
    return categories;
  }

  Future<List<ShortActivity>> getCategoryActivities(
      ActivityCategory category) async {
    const _extUrl = '/activity/getActivities';
    final body = {
      "qry": {"category": category.title.toLowerCase()},
      "sort": {"rating": -1},
      "limit": 25,
    };
    Get.log("Sent Body: ${jsonEncode(body)}");
    final List<ShortActivity> activities = [];
    await api.postReq(_extUrl, body, (resp) {
      for (var res in resp) {
        activities.add(ShortActivity.fromMap(res));
      }
    });
    return activities;
  }

  Future<List<ShortActivity>> getRecommendedActivities() async {
    const _extUrl = '/activity/getActivities';
    final body = {
      "qry": {},
      "sort": {"rating": -1},
      "limit": 10,
    };
    Get.log("Sent Body: ${jsonEncode(body)}");
    final List<ShortActivity> activities = [];
    await api.postReq(_extUrl, body, (resp) {
      for (var res in resp) {
        activities.add(ShortActivity.fromMap(res));
      }
    });
    return activities.isNotEmpty
        ? activities
        : demoCafes.map((e) => ShortActivity.fromJson(e.toJson())).toList();
  }

  Future<Activity?> getActivityById(String id) async {
    const _extUrl = '/activity/getActivityById';
    final body = {"id": id};
    Activity? activity;
    await api.postReq(
        _extUrl, body, (resp) => activity = Activity.fromMap(resp));
    return activity;
  }

  Future<bool> saveActivityById(String id) async {
    const _extUrl = '/user/saveCafe';
    final body = {"cafeId": id};
    bool isSuccess = false;
    await api.postReq(_extUrl, body, (resp) => null);
    // isSuccess = resp["success"]);
    // activity = Activity.fromMap(resp));

    return isSuccess;
  }

  Future<List<String>> getSavedActivities() async {
    const _extUrl = '/user/savedCafe';
    final List<String> activities = [];
    await api.getReq(_extUrl, (resp) {
      if (resp != null) {
        for (var res in resp['favourites']) {
          activities.add(res.toString());
        }
      }
    });
    return activities;
  }

  Future<List<String>> getAds() async {
    const _extUrl = '/user/adsImage';
    final List<String> ads = [];
    await api.getReq(_extUrl, (resp) {
      if (resp != null) {
        for (var res in resp['ads']) {
          ads.add(res.toString());
        }
      }
    });
    return ads;
  }
}
