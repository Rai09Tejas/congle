// To parse this JSON data, do
//
//     final activity = activityFromMap(jsonString);

import 'dart:convert';

class Activity {
  Activity({
    required this.id,
    required this.name,
    required this.location,
    required this.distance,
    required this.desc,
    required this.category,
    required this.active,
    required this.openTime,
    required this.closeTime,
    required this.rating,
    required this.phno,
    required this.mapLink,
    this.tags,
    required this.cost,
    required this.dp,
    this.photos,
  });

  final String id;
  final String name;
  final String location;
  final int distance;
  final String desc;
  final String category;
  final bool active;
  final DateTime openTime;
  final DateTime closeTime;
  final int rating;
  final String phno;
  final String mapLink;
  final List<String>? tags;
  final int cost;
  final List<String> dp;
  final List<String>? photos;

  factory Activity.fromJson(String str) => Activity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Activity.fromMap(Map<String, dynamic> json) => Activity(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        distance: json["distance"],
        desc: json["desc"],
        category: (json['category'].toString().substring(0, 1).toUpperCase() +
            json['category'].toString().substring(1).toLowerCase()),
        active: json["active"],
        openTime: json["openTime"] == null
            ? DateTime.now()
            : DateTime.parse(json["openTime"]).toLocal(),
        closeTime: json["closeTime"] == null
            ? DateTime.now()
            : DateTime.parse(json["closeTime"]).toLocal(),
        rating: json["rating"],
        phno: json["phno"],
        mapLink: json["mapLink"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        cost: json["cost"],
        dp: json["dp"] == null
            ? List.empty()
            : List<String>.from(json["dp"].map((x) => x)),
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "location": location,
        "distance": distance,
        "desc": desc,
        "category": category,
        "active": active,
        "openTime": openTime.toIso8601String(),
        "closeTime": closeTime.toIso8601String(),
        "rating": rating,
        "phno": phno,
        "mapLink": mapLink,
        "tags": tags == null
            ? List.empty()
            : List<String>.from(tags!.map((x) => x)),
        "cost": cost,
        "dp": List<dynamic>.from(dp.map((x) => x)),
        "photos": photos == null
            ? List.empty()
            : List<dynamic>.from(photos!.map((x) => x)),
      };
}

List<Activity> demoCafes = [
  Activity(
    id: 'demo1',
    name: 'Richard\'s Cafe',
    location: 'Near Gandhi Road, New Delhi',
    distance: 15,
    desc:
        'Earum est ex quisquam. Ut quia quidem. Impedit optio similique et voluptatum sed eaque tempore voluptatem sit.\n \rEt laboriosam quam consequatur. Similique et et nam. Quae at voluptates tempora molestiae voluptas numquam. Est veritatis voluptatem non quia maxime voluptas hic dolore ipsam. In laboriosam et.\n \rVel eveniet minima amet dignissimos est. Enim vel a vel ut atque commodi. Qui magni quia saepe omnis libero consequatur consequatur quis distinctio. Sed est laudantium similique consequatur.',
    cost: 600,
    dp: [
      'https://images.unsplash.com/photo-1554118811-1e0d58224f24?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FmZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1559305616-3f99cd43e353?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Y2FmZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1481833761820-0509d3217039?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FmZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    ],
    tags: ['Rooftop', 'Economy'],
    photos: [
      'https://images.unsplash.com/photo-1568031813264-d394c5d474b9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWVudXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1515697320591-f3eb3566bc3c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8bWVudXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1564759298141-cef86f51d4d4?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bWVudXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    ],
    openTime: DateTime(2021, 1, 1, 7),
    closeTime: DateTime(2021, 1, 1, 20),
    active: true,
    category: 'cafe',
    mapLink: '',
    phno: '1234567890',
    rating: 4,
  ),
  Activity(
    id: 'demo2',
    name: 'Dominoz Pizza',
    location: 'Near JH Road, South Delhi',
    distance: 10,
    desc:
        'Earum est ex quisquam. Ut quia quidem. Impedit optio similique et voluptatum sed eaque tempore voluptatem sit.\n \rEt laboriosam quam consequatur. Similique et et nam. Quae at voluptates tempora molestiae voluptas numquam. Est veritatis voluptatem non quia maxime voluptas hic dolore ipsam. In laboriosam et.\n \rVel eveniet minima amet dignissimos est. Enim vel a vel ut atque commodi. Qui magni quia saepe omnis libero consequatur consequatur quis distinctio. Sed est laudantium similique consequatur.',
    cost: 900,
    dp: [
      'https://images.unsplash.com/photo-1542181961-9590d0c79dab?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGNhZmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1463797221720-6b07e6426c24?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGNhZmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    ],
    tags: ['Continental', 'Pizza', 'Italian'],
    photos: [
      'https://images.unsplash.com/photo-1524237492620-14fcdd03ce16?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bWVudXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1529270296466-b09d5f5c2bab?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8bWVudXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1558274849-f9fa5f16dee8?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fG1lbnV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    ],
    openTime: DateTime(2021, 1, 1, 9),
    closeTime: DateTime(2021, 1, 1, 21),
    active: true,
    category: 'cafe',
    mapLink: '',
    phno: '1234567890',
    rating: 4,
  ),
  Activity(
    id: 'demo3',
    name: 'Hamberg',
    location: 'A25, NH-10, Gurgaon',
    distance: 15,
    desc:
        'Earum est ex quisquam. Ut quia quidem. Impedit optio similique et voluptatum sed eaque tempore voluptatem sit.\n \rEt laboriosam quam consequatur. Similique et et nam. Quae at voluptates tempora molestiae voluptas numquam. Est veritatis voluptatem non quia maxime voluptas hic dolore ipsam. In laboriosam et.\n \rVel eveniet minima amet dignissimos est. Enim vel a vel ut atque commodi. Qui magni quia saepe omnis libero consequatur consequatur quis distinctio. Sed est laudantium similique consequatur.',
    cost: 300,
    dp: [
      'https://images.unsplash.com/photo-1507914464562-6ff4ac29692f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fGNhZmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1521017432531-fbd92d768814?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjh8fGNhZmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1569096651661-820d0de8b4ab?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fGNhZmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    ],
    tags: ['Continental', 'Economy', 'South Indian'],
    openTime: DateTime(2021, 1, 1, 11),
    closeTime: DateTime(2021, 1, 1, 23),
    active: true,
    category: 'cafe',
    mapLink: '',
    phno: '1234567890',
    rating: 4,
  ),
  Activity(
    id: 'demo4',
    name: 'Wow Momos',
    location: 'A25, Main Road, Gaziabad',
    distance: 25,
    desc:
        'Earum est ex quisquam. Ut quia quidem. Impedit optio similique et voluptatum sed eaque tempore voluptatem sit.\n \rEt laboriosam quam consequatur. Similique et et nam. Quae at voluptates tempora molestiae voluptas numquam. Est veritatis voluptatem non quia maxime voluptas hic dolore ipsam. In laboriosam et.\n \rVel eveniet minima amet dignissimos est. Enim vel a vel ut atque commodi. Qui magni quia saepe omnis libero consequatur consequatur quis distinctio. Sed est laudantium similique consequatur.',
    cost: 500,
    dp: [
      'https://images.unsplash.com/photo-1610297588220-d2bc81e66398?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDF8fGNhZmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      'https://images.unsplash.com/photo-1558627273-0afee68c8efc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDh8fGNhZmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    ],
    tags: ['Momos', 'Economy', 'Italian'],
    openTime: DateTime(2021, 1, 1, 7),
    closeTime: DateTime(2021, 1, 1, 20),
    active: true,
    category: 'cafe',
    mapLink: '',
    phno: '1234567890',
    rating: 4,
  ),
];
