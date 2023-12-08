import 'dart:convert';

class ActivityCategory {
  final String title;
  final String dp;
  final String? desc;

  ActivityCategory({required this.title, required this.dp, this.desc});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dp': dp,
      'desc': desc,
    };
  }

  factory ActivityCategory.fromMap(Map<String, dynamic> map) {
    return ActivityCategory(
      title: (map['title'].toString().substring(0, 1).toUpperCase() +
          map['title'].toString().substring(1).toLowerCase()),
      dp: map['dp'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityCategory.fromJson(String source) =>
      ActivityCategory.fromMap(json.decode(source));
}
