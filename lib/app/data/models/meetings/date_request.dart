import 'dart:convert';

import 'package:congle/app/data/data.dart';

class DateRequest {
  final String id;
  final DateTime dateTime;
  final ShortProfile profile;

  DateRequest(
      {required this.id, required this.dateTime, required this.profile});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'profile': profile.toMap(),
    };
  }

  factory DateRequest.fromMap(Map<String, dynamic> map) {
    return DateRequest(
      id: map['id'],
      dateTime: DateTime.parse(map['dateTime']).toLocal(),
      profile: ShortProfile.fromMap(map['profile']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DateRequest.fromJson(String source) =>
      DateRequest.fromMap(json.decode(source));
}
