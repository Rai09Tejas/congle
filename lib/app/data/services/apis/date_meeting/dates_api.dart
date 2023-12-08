import 'package:get/get.dart';

import '../../../data.dart';

class DatesApi extends GetConnect {
  late Api api;
  Future<DatesApi> init() async {
    Get.log('$runtimeType ready');
    api = Get.find<Api>();
    return this;
  }

  Future<List<Profile>> getSwipeInfo(
      {required double distance,
      required double lAgeLimit,
      required double uAgeLimit,
      required Gender gender,
      required List<String> intrests}) async {
    const _extUrl = '/user/getSwipeInfo';
    final body = {
      "distance": distance,
      "gender": getGenderString(gender),
      "uAge": uAgeLimit,
      "lAge": lAgeLimit,
      "intrests": intrests,
    };

    final List<Profile> _profiles = [];
    await api.postReq(_extUrl, body, (resp) {
      for (var res in resp) {
        Profile? p;
        try {
          p = Profile.fromMap(res);
        } on Exception catch (e) {
          Get.log("couldn't parse it: $e ");
        }
        if (p != null) _profiles.add(p);
      }
    });

    return _profiles;
  }

  Future<bool> requestDate(String id) async {
    const _extUrl = '/dateMeeting/requestDate';
    final body = {'id': id};
    bool isSuccess = false;
    await api.postReq(_extUrl, body, (resp) => isSuccess = resp['success']);
    return isSuccess;
  }

  Future<bool> viewProfile(String id) async {
    // final _extUrl = '/user/profileViewed';
    // final body = {'id': id};
    bool isSuccess = false;
    // await api.postReq(_extUrl, body, (resp) =>  isSucess = resp['success']);
    return isSuccess;
  }

  Future<List<DateRequest>> getDateRequested() async {
    const _extUrl = '/invitation/requestedInvitation';
    final List<DateRequest> _profiles = [];
    await api.getReq(_extUrl, (resp) {
      
      for (var res in resp) {
        _profiles.add(DateRequest.fromMap(res));
      }
    });
    return _profiles;
  }

  Future<List<DateRequest>> getDatePending() async {
    const _extUrl = '/invitation/pendingInvitation';
    final List<DateRequest> _profiles = [];
    await api.getReq(_extUrl, (resp) {
      for (var res in resp) {
        _profiles.add(DateRequest.fromMap(res));
      }
    });
    return _profiles;
  }

  Future<List<DateRequest>> getDateExpired() async {
    const _extUrl = '/invitation/expiredInvitation';
    final List<DateRequest> _profiles = [];
    await api.getReq(_extUrl, (resp) {
      for (var res in resp) {
        _profiles.add(DateRequest.fromMap(res));
      }
    });
    return _profiles;
  }

  Future<bool> acceptDateRequest(String id) async {
    const _extUrl = '/dateMeeting/acceptDate';
    final body = {'dateMeetingId': id};
    bool isSuccess = false;
    await api.postReq(_extUrl, body, (resp) => isSuccess = resp['success']);
    return isSuccess;
  }

  Future<bool> removeDateProfile(String id) async {
    const _extUrl = '/user/deleteDateMeeting';
    final body = {'dateMeetingId': id};
    bool isSucess = false;
    Get.log(body.toString());

    await api.postReq(_extUrl, body, (resp) {
      if (resp != null) isSucess = resp['success'];
    });

    return isSucess;
  }
}
