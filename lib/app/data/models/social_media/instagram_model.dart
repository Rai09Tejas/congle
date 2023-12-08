// To parse this JSON data, do
//
//     final instagram = instagramFromMap(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Instagram {
  Instagram({
    required this.posts,
  });

  List<Post>? posts;

  factory Instagram.fromJson(String str) => Instagram.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Instagram.fromMap(Map<String, dynamic> json) => Instagram(
        posts: json["posts"] == null
            ? null
            : List<Post>.from(json["posts"].map((x) => Post.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "posts": posts == null
            ? null
            : List<dynamic>.from(posts!.map((x) => x.toMap())),
      };
}

class Post {
  Post({
    required this.imgUrl,
    this.dateTime,
    this.caption,
  });

  String? imgUrl;
  DateTime? dateTime;
  String? caption;

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        imgUrl: json["imgUrl"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        caption: json["caption"],
      );

  Map<String, dynamic> toMap() => {
        "imgUrl": imgUrl,
        "dateTime": dateTime == null ? null : dateTime!.toIso8601String(),
        "caption": caption,
      };
}

Instagram sample_instagram = Instagram.fromJson("""{
    "posts": [
      {
        "imgUrl": "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aHVtYW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-18T03:54:48.994Z",
        "caption": "et"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T20:00:22.869Z",
        "caption": "impedit"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T06:45:12.959Z",
        "caption": "harum"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T13:18:24.959Z",
        "caption": "excepturi"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T20:15:32.904Z",
        "caption": "consequatur"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T21:26:40.644Z",
        "caption": "dignissimos"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T19:01:37.360Z",
        "caption": "autem"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T21:36:06.578Z",
        "caption": "sunt"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T07:58:23.746Z",
        "caption": "dignissimos"
      },
      {
        "imgUrl": "https://images.unsplash.com/photo-1601412436009-d964bd02edbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "dateTime": "2021-06-17T11:54:45.876Z",
        "caption": "aut"
      }
    ]
}""");
