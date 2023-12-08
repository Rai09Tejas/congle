import 'dart:convert';

import 'about_user.dart';

class Profile {
  final bool isFollowing;
  final bool isblocked;
  final int distance;
  final AboutUser aboutUser;

  Profile(
      {this.isFollowing = false,
      this.isblocked = false,
      this.distance = 1000,
      required this.aboutUser});

  Map<String, dynamic> toMap() {
    return {
      'isFollowing': isFollowing,
      'isblocked': isblocked,
      'distance': distance,
      'aboutUser': aboutUser.toMap(),
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      isFollowing: map['isFollowing'],
      isblocked: map['isblocked'] ?? false,
      distance: map['distance'],
      aboutUser: AboutUser.fromMap(map['aboutUser']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}
