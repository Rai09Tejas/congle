import 'package:get/get.dart';

import '../../../data.dart';

class BookingsApi extends GetConnect {
  late Api api;
  Future<BookingsApi> init() async {
    Get.log('$runtimeType ready');
    api = Get.find<Api>();
    return this;
  }

  Future<List<Booking>> getPendingBookings() async {
    const _extUrl = '/user/getDateBookingPending';
    final List<Booking> bookings = [];
    await api.getReq(_extUrl, (resp) {
      for (var res in resp) {
        bookings.add(Booking.fromMap(res));
      }
    });
    return bookings;
  }

  Future<List<Booking>> getUpcommingBookings() async {
    const _extUrl = '/user/getDateBookingUpcoming';
    final List<Booking> bookings = [];
    await api.getReq(_extUrl, (resp) {
      for (var res in resp) {
        bookings.add(Booking.fromMap(res));
      }
    });
    return bookings;
  }

  Future<List<Booking>> getCompletedBookings() async {
    const _extUrl = '/user/getDateBookingCompleted';
    final List<Booking> bookings = [];
    await api.getReq(_extUrl, (resp) {
      for (var res in resp) {
        bookings.add(Booking.fromMap(res));
      }
    });
    return bookings;
  }

  Future<List<ShortProfile>> getQueueBookings() async {
    const _extUrl = '/user/getDateQueue';
    final List<ShortProfile> profiles = [];
    await api.getReq(_extUrl, (resp) {
      for (var res in resp) {
        profiles.add(ShortProfile.fromMap(res));
      }
    });
    return profiles;
  }

  Future<bool> scheduleBooking(
      DateTime time, String dateRequestId, String activityId) async {
    const _extUrl = '/dateMeeting/scheduleDateMeeting';
    final body = {
      "dateMeetingId": dateRequestId,
      "meetingDateTime": time.toIso8601String(),
      "activityId": activityId
    };
    bool isSuccess = false;
    await api.postReq(
        _extUrl, body, (resp) => isSuccess = resp?['success'] ?? false);

    return isSuccess;
  }

  Future<bool> rescheduleBooking(DateTime time, String dateRequestId) async {
    const _extUrl = '/dateMeeting/rescheduleDateMeeting';
    final body = {
      "dateMeetingId": dateRequestId,
      "meetingDateTime": time.toIso8601String()
    };
    bool isSuccess = false;
    await api.postReq(_extUrl, body, (resp) => isSuccess = resp['success']);
    return isSuccess;
  }

  Future<Booking> getBookingInfo(String dateRequestId) async {
    const _extUrl = '/dateMeeting/getDateMeetingInfo';
    late Booking booking;
    final body = {
      "dateMeetingId": dateRequestId,
    };
    await api.postReq(_extUrl, body, (resp) {
      booking = Booking.fromMap(resp);
    });
    return booking;
  }

  Future<bool> meetAgain(String id) async {
    const _extUrl = '/dateMeeting/meetAgain';
    final body = {
      "meetingId": id,
    };
    bool isSuccess = false;
    await api.postReq(_extUrl, body, (resp) => isSuccess = resp['success']);
    return isSuccess;
  }
}
