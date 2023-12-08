import 'dart:convert';

class ShortActivity {
  final String id;
  final String name;
  final String category;
  final int cost;
  final String location;
  final List<String>? tags;
  final List<String> dp;
  final String? phno;

  ShortActivity({
    required this.id,
    required this.name,
    required this.category,
    required this.cost,
    required this.location,
    this.tags,
    this.phno,
    required this.dp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'cost': cost,
      'location': location,
      'tags': tags,
      'dp': dp,
      'phno': phno,
    };
  }

  factory ShortActivity.fromMap(Map<String, dynamic> map) {
    return ShortActivity(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      cost: map['cost'],
      location: map['location'],
      tags: List<String>.from(map['tags']),
      dp: List<String>.from(map['dp']),
      phno: map['phno'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShortActivity.fromJson(String source) =>
      ShortActivity.fromMap(json.decode(source));
}
