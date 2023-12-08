// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../data.dart';

class UserData {
  String? uid;
  String? name;
  String? gender;
  int? dob;
  String? jobTitle;
  String? companyName;
  String? reason;
  List<String>? interests;
  String? dp;
  List<String>? photos;
  Map<String, dynamic> loc = {
    "type": "Point",
    "coordinates": [0.0, 0.0]
  };

  UserData(
      {required this.uid,
      required this.name,
      required this.gender,
      required this.dob,
      required this.jobTitle,
      required this.companyName,
      required this.reason,
      required this.interests,
      required this.dp,
      required this.photos,
      required this.loc});

  UserData.empty() {
    dp = '';
    uid = '';
    name = '';
    dob = DateTime.now().millisecondsSinceEpoch;
    jobTitle = '';
    companyName = '';
    gender = '';
    interests = [];
    reason = '';
    photos = [];
    loc = {
      "type": "Point",
      "coordinates": [0.0, 0.0]
    };
  }

  // Factory method to create UserData instance from a map
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        uid: json['name'] ?? '',
        name: json['username'] ?? '',
        dob: json['dob'] ?? 0,
        jobTitle: json['jobTitle'] ?? '',
        gender: json['gender'] ?? '',
        interests: json['interests'] ?? [],
        reason: json['reason'] ?? '',
        dp: json['dp'] ?? '',
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
        companyName: json['companyName'] ?? '',
        loc: json['companyName'] ?? {});
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'dob': dob,
      'jobTitle': jobTitle,
      'gender': gender,
      'interests': interests,
      'reason': reason,
      'companyName': companyName,
      'dp': dp,
      'photos': photos,
      'loc': loc
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'dob': dob,
      'jobTitle': jobTitle,
      'gender': gender,
      'interests': interests,
      'reason': reason,
      'companyName': companyName,
      'dp': dp,
      'photos': photos,
      'loc': loc
    };
  }
}
