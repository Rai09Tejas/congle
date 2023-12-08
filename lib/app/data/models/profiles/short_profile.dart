// To parse this JSON data, do
//
//     final shortProfile = shortProfileFromMap(jsonString);

import 'dart:convert';

class ShortProfile {
  ShortProfile({
    required this.id,
    required this.username,
    required this.name,
    required this.dp,
    required this.age,
    this.work,
    this.isFollowing = false,
  });

  final String id;
  final String username;
  final String name;
  final String dp;
  final int age;
  final String? work;
  final bool isFollowing;

  factory ShortProfile.fromJson(String str) =>
      ShortProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShortProfile.fromMap(Map<String, dynamic> json) => ShortProfile(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        dp: json["dp"],
        age: json["age"],
        work: json["work"],
        isFollowing: json["isFollowing"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "name": name,
        "dp": dp,
        "age": age,
        "work": work,
        "isFollowing": isFollowing,
      };
}
