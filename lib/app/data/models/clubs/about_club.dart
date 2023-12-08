import 'dart:convert';

import 'package:congle/app/data/data.dart';

List<ShortClub> demoClubsShort = [
  ShortClub(
      id: demoClubs[1].id,
      name: demoClubs[1].name,
      dp: demoClubs[1].dp,
      about: demoClubs[1].about),
  ShortClub(
      id: demoClubs[2].id,
      name: demoClubs[2].name,
      dp: demoClubs[2].dp,
      about: demoClubs[2].about),
  // ShortClub(
  //     uid: demoClubs[3].id,
  //     name: demoClubs[3].name,
  //     dp: demoClubs[3].dp,
  //     about: demoClubs[3].about),
  // ShortClub(
  //     uid: demoClubs[4].id,
  //     name: demoClubs[4].name,
  //     dp: demoClubs[4].dp,
  //     about: demoClubs[4].about),
];
List<AboutClub> demoClubs = [
  AboutClub(
    id: '1',
    name: 'Congle Social',
    dp: 'https://images.unsplash.com/photo-1591105315393-6b0080b822f4?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2x1YnMlMjBsb2dvfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    about:
        'Suscipit eum veritatis doloremque. Distinctio facere perferendis nisi repellat. Placeat aut voluptatem voluptas officiis. Ea inventore magni qui et est voluptatem. Nihil eum laudantium cum quae nihil.',
    creationDate: DateTime(2021, 3, 11),
    tags: ['Crypto', 'Date', 'Music', 'Cricket', 'Movies'],
    creator: demoProfilesShort.first,
    followersCount: demoProfilesShort.length,
    followers: demoProfilesShort,
  ),
  AboutClub(
    id: '2',
    name: 'Artist Hub',
    dp: 'https://images.unsplash.com/photo-1598519501110-db5cdc8d9193?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YXJ0aXN0JTIwbG9nb3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    about:
        'Suscipit eum veritatis doloremque. Distinctio facere perferendis nisi repellat. Placeat aut voluptatem voluptas officiis. Ea inventore magni qui et est voluptatem. Nihil eum laudantium cum quae nihil.',
    creationDate: DateTime(2021, 3, 11),
    tags: ['Crypto', 'Date', 'Music', 'Cricket', 'Movies'],
    followersCount: demoProfilesShort.length,
    creator: demoProfilesShort.first,
    followers: demoProfilesShort,
  ),
  AboutClub(
    id: '3',
    name: 'Chill Out',
    dp: 'https://images.unsplash.com/photo-1620632523414-054c7bea12ac?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fGNoaWxsJTIwbG9nb3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    about:
        'Suscipit eum veritatis doloremque. Distinctio facere perferendis nisi repellat. Placeat aut voluptatem voluptas officiis. Ea inventore magni qui et est voluptatem. Nihil eum laudantium cum quae nihil.',
    creationDate: DateTime(2021, 3, 11),
    tags: ['Crypto', 'Date', 'Music', 'Cricket', 'Movies'],
    creator: demoProfilesShort.first,
    followersCount: demoProfilesShort.length,
    followers: demoProfilesShort,
  ),
  AboutClub(
    id: '4',
    name: 'Media',
    dp: 'https://images.unsplash.com/photo-1622929610538-fc41bdce80c6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDB8fG1lZGlhJTIwbG9nb3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    about:
        'Suscipit eum veritatis doloremque. Distinctio facere perferendis nisi repellat. Placeat aut voluptatem voluptas officiis. Ea inventore magni qui et est voluptatem. Nihil eum laudantium cum quae nihil.',
    creationDate: DateTime(2021, 3, 11),
    tags: ['Crypto', 'Date', 'Music', 'Cricket', 'Movies'],
    creator: demoProfilesShort.first,
    followersCount: demoProfilesShort.length,
    followers: demoProfilesShort,
  ),
];

class AboutClub {
  final String id;
  final String name;
  final String dp;
  final String about;
  final List<String> tags;
  final DateTime creationDate;
  final ShortProfile creator;
  final int followersCount;
  final List<ShortProfile>? followers;

  AboutClub({
    required this.id,
    required this.name,
    required this.dp,
    required this.about,
    required this.tags,
    required this.creationDate,
    required this.creator,
    required this.followersCount,
    this.followers,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dp': dp,
      'about': about,
      'tags': tags,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'creator': creator.toMap(),
      'followersCount': followersCount,
    };
  }

  factory AboutClub.fromMap(Map<String, dynamic> map) {
    return AboutClub(
      id: map['id'],
      name: map['name'],
      dp: map['dp'],
      about: map['about'],
      tags: List<String>.from(map['tags']),
      creationDate: DateTime.parse(map['creationDate']).toLocal(),
      creator: ShortProfile.fromMap(map['creator']),
      followersCount: map['followersCount'],
      // followers: List<ShortProfile>.from(
      //     map['followers']?.map((x) => ShortProfile.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutClub.fromJson(String source) =>
      AboutClub.fromMap(json.decode(source));
}
