import 'dart:convert';

import 'package:congle/app/data/data.dart';

class Booking {
  Booking({
    required this.id,
    required this.bookie,
    required this.attendies,
    required this.initTime,
    required this.isRescheduled,
    this.activity,
    this.bookingTime,
  });

  final String id;
  final ShortProfile bookie;
  final List<ShortProfile> attendies;
  final DateTime initTime;
  final ShortActivity? activity;
  DateTime? bookingTime;
  final bool isRescheduled;

  factory Booking.fromJson(String str) => Booking.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        id: json["id"],
        bookie: ShortProfile.fromMap(json["bookie"]),
        isRescheduled: json['isRescheduled'] ?? false,
        attendies: json["attendies"] == null
            ? List.empty()
            : List<ShortProfile>.from(
                json["attendies"].map((x) => ShortProfile.fromMap(x))),
        initTime: json["sendingDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["sendingDate"]).toLocal(),
        activity: json["activity"] == null
            ? null
            : ShortActivity.fromMap(json["activity"]),
        bookingTime: json["meetingDate"] == null
            ? null
            : DateTime.parse(json["meetingDate"]).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bookie": bookie.toMap(),
        'isRescheduled': isRescheduled,
        "attendies": List<dynamic>.from(attendies.map((x) => x.toMap())),
        "sendingDate": initTime.toIso8601String(),
        "meetingDate": bookingTime?.toIso8601String(),
        "activity": activity?.toMap(),
      };
}
