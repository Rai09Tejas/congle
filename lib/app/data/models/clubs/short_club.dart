// To parse this JSON data, do
//
//     final shortClub = shortClubFromMap(jsonString);

import 'dart:convert';

class ShortClub {
  ShortClub({
    required this.id,
    required this.name,
    required this.dp,
    required this.about,
    this.isFollowed = false,
  });

  final String id;
  final String name;
  final String dp;
  final String about;
  final bool isFollowed;

  factory ShortClub.fromJson(String str) => ShortClub.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShortClub.fromMap(Map<String, dynamic> json) => ShortClub(
        id: json["id"],
        name: json["name"],
        dp: json["dp"],
        about: json["about"],
        isFollowed: json["isFollowed"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "dp": dp,
        "about": about,
        "isFollowed": isFollowed,
      };
}
