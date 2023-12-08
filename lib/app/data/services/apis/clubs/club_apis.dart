import 'package:get/get.dart';

import '../../../data.dart';

class ClubApi extends GetConnect {
  late Api api;
  Future<ClubApi> init() async {
    Get.log('$runtimeType ready');
    api = Get.find<Api>();
    return this;
  }

  Future<AboutClub?> getClubByID(String id) async {
    const _extUrl = '/club/getClub';
    final body = {'id': id};
    AboutClub? club;
    await api.postReq(_extUrl, body, (resp) {
      club = AboutClub.fromMap(resp);
    });
    club ??= demoClubs.where((e) => e.id == id).first;
    return club;
  }

  Future<List<ShortProfile>> getFollowersByClubID(String id) async {
    const _extUrl = '/club/getFollowers';
    final body = {'id': id};
    List<ShortProfile> profiles = [];
    await api.postReq(_extUrl, body, (resp) {
      for (var item in resp) {
        profiles.add(ShortProfile.fromMap(item));
      }
    });
    return profiles;
  }

  Future followClubByID(String id) async {
    const _extUrl = '/club/followClub';
    final body = {'id': id};
    await api.postReq(_extUrl, body, (resp) => null);
    return;
  }

  Future blockClubByID(String id) async {
    const _extUrl = '/club/blockClub';
    final body = {'id': id};
    await api.postReq(_extUrl, body, (resp) => null);
    return;
  }
}
