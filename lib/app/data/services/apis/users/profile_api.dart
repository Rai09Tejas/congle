import 'package:get/get.dart';

import '../../../data.dart';

class ProfileApi extends GetConnect {
  late Api api;
  Future<ProfileApi> init() async {
    Get.log('$runtimeType ready');
    api = Get.find<Api>();
    return this;
  }

  Future<AboutUser?> getCurrentUserProfile() async {
    const _extUrl = '/user/getProfile';
    AboutUser? user;
    await api.getReq(_extUrl, (resp) {
      if (resp != null) user = AboutUser.fromMap(resp);
    });
    Congle.currentUser = user;
    return user;
  }

  Future<Profile?> getProfileByID(String id) async {
    const _extUrl = '/user/getProfileInfo';
    final body = {'id': id};
    Profile? profile;
    await api.postReq(_extUrl, body, (resp) {
      profile = Profile.fromMap(resp);
    });
    return profile;
  }

  Future followProfileByID(String id) async {
    const _extUrl = '/user/followProfile';
    final body = {'id': id};
    await api.postReq(_extUrl, body, (resp) => null);
    return;
  }

  Future blockProfileByID(String id) async {
    const _extUrl = '/user/blockProfile';
    final body = {'id': id};
    await api.postReq(_extUrl, body, (resp) => null);
    return;
  }

  Future deleteProfile() async {
    const _extUrl = '/user/deleteProfile';
    await api.getReq(_extUrl, (resp) => null);
    return;
  }
}
