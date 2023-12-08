import 'dart:convert';

import '../../data.dart';

class AboutUser {
   String uid;
   String name;
   String username;
   Gender gender;
   int age;
   String? dob;
   String? jobTitle;
   String? companyName;
   String? about;
   String? reason;
   List<String>? interests;
   String dp;
   List<String>? photos;
   int followers;
   int following;
   List<ShortClub>? clubs;
   String? linkedin;
   Spotify? spotify;
   Instagram? instagram;

  AboutUser({
    required this.uid,
    required this.name,
    required this.username,
    required this.gender,
    required this.age,
    required this.followers,
    required this.following,
    required this.dp,
    this.jobTitle,
    this.companyName,
    this.reason,
    this.dob,
    this.about,
    this.interests,
    this.photos,
    this.clubs,
    this.linkedin,
    this.spotify,
    this.instagram,
  });

  // private, favCafe,

  factory AboutUser.fromJson(String str) => AboutUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AboutUser.fromMap(Map<String, dynamic> json) => AboutUser(
        uid: json["uid"],
        name: json["name"],
        username: json["username"],
        gender: getGender(json["gender"]),
        age: json["age"],
        dob: json['dob'],
        reason: json['reason'],
        jobTitle: json["jobTitle"],
        companyName: json["companyName"],
        about: json["about"],
        interests: json["interests"] == null
            ? null
            : List<String>.from(json["interests"].map((x) => x)),
        dp: json["dp"],
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
        followers: json["followers"],
        following: json["following"],
        clubs:
            json["clubs"] == {} || json["clubs"] == [] || json["clubs"] == null
                ? null
                : List<ShortClub>.from(
                    json["clubs"].map((x) => ShortClub.fromMap(x))),
        linkedin: json["linkedin"],
        spotify: json["spotify"].toString() == '{}' || json['spotify'] == null
            ? null
            : Spotify.fromMap(json["spotify"]),
        instagram:
            json["instagram"].toString() == '{}' || json["instagram"] == null
                ? null
                : Instagram.fromMap(json["instagram"]),
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "reason": reason,
        "name": name,
        "username": username,
        "gender": getGenderString(gender),
        "age": age,
        "dob": dob,
        "jobTitle": jobTitle,
        "companyName": companyName,
        "about": about,
        "intrests": interests == null
            ? null
            : List<String>.from(interests!.map((x) => x)),
        "dp": dp,
        "photos":
            photos == null ? null : List<String>.from(photos!.map((x) => x)),
        "followers": followers,
        "following": following,
        "clubs": clubs == null ? null : List.from(clubs!.map((x) => x.toMap())),
        "linkedin": linkedin,
        "spotify": spotify,
        "instagram": instagram,
      };

  static AboutUser empty() {
    return AboutUser(
      uid: '',
      name: '',
      username: '',
      gender: Gender.OTHER, // Provide a default value for the gender enum
      age: 0,
      followers: 0,
      following: 0,
      dp: '',
      reason: '',
      // Set other properties to their default values or null
      jobTitle: null,
      companyName: null,
      dob: null,
      about: null,
      interests: null,
      photos: null,
      clubs: null,
      linkedin: null,
      spotify: null,
      instagram: null,
    );
  }
}

AboutUser mainProfile = AboutUser(
  uid: 'main',
  name: 'Ayush Kejariwal',
  username: 'a_kejariwal',
  followers: 120,
  following: 301,
  about:
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et',
  jobTitle: 'CTO @ Congle India',
  companyName: 'CTO @ Congle India',
  gender: Gender.MALE,
  age: 21,
  dob: "85198516516",
  dp: 'https://images.unsplash.com/photo-1571224736343-7182962ae3e7?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDk0fHRvd0paRnNrcEdnfHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  photos: [
    'https://images.unsplash.com/photo-1556908153-a685b0352d59?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDEzMXx0b3dKWkZza3BHZ3x8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    'https://images.unsplash.com/photo-1586953620693-54c3249107ad?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE0MHx0b3dKWkZza3BHZ3x8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    'https://images.unsplash.com/photo-1564172556663-2bef9580fc44?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE2MHx0b3dKWkZza3BHZ3x8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    'https://images.unsplash.com/photo-1622559924472-2c2f69abb854?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDE3OHx0b3dKWkZza3BHZ3x8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  ],
  interests: ['Crypto', 'Date', 'Music', 'Cricket', 'Movies'],
  instagram: sample_instagram,
  spotify: sample_spotify,
  linkedin:
      "https://in.linkedin.com/company/congle-india?trk=public_profile_topcard-current-company",
);

final ShortProfile mainProfileShort = ShortProfile(
    id: mainProfile.uid,
    username: mainProfile.username,
    name: mainProfile.name,
    dp: mainProfile.dp,
    age: mainProfile.age);

final List<ShortProfile> demoProfilesShort = [
  ShortProfile(
      id: demoProfiles[1].uid,
      username: demoProfiles[1].username,
      name: demoProfiles[1].name,
      dp: demoProfiles[1].dp,
      age: 19,
      work: demoProfiles[1].jobTitle),
  ShortProfile(
      id: demoProfiles[2].uid,
      username: demoProfiles[2].username,
      name: demoProfiles[2].name,
      dp: demoProfiles[2].dp,
      age: 19,
      work: demoProfiles[2].jobTitle),
  ShortProfile(
      id: demoProfiles[3].uid,
      username: demoProfiles[3].username,
      name: demoProfiles[3].name,
      dp: demoProfiles[3].dp,
      age: 20,
      work: demoProfiles[3].jobTitle),
  // ShortProfile(
  //     uid: demoProfiles[4].id,
  //     name: demoProfiles[4].name,
  //     dp: demoProfiles[4].dp,
  //     work: demoProfiles[4].work),
];
// //dummy data
final List<AboutUser> demoProfiles = [
  AboutUser(
    photos: [
      "https://images.unsplash.com/photo-1545912452-8aea7e25a3d3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fGdpcmx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1557555187-23d685287bc3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fGdpcmx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1464863979621-258859e62245?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fGdpcmx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1545912452-8aea7e25a3d3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fGdpcmx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
      "https://images.unsplash.com/photo-1557555187-23d685287bc3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fGdpcmx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
    ],
    // clubs: demoClubsShort,
    username: "gracymark",
    name: "Gracy Mark",
    // phone: '9124356780',
    followers: 210,
    following: 231,
    about:
        "Do you believe in love 🧡 at first sight – or should you swipe right again? ",
    uid: 'demo3',
    gender: Gender.FEMALE,
    age: 25,
    dp: "https://images.unsplash.com/photo-1616529735204-6799853ed36f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fG1vZGVsJTIwZ2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
    interests: ['Crypto', 'Date', 'Music', 'Cricket', 'Movies'],
    jobTitle: 'Design Intern at Congle',
    // location: '10 KM away from you',
    linkedin: "https://in.linkedin.com/company/congle-india",
    spotify: Spotify(topArtists: [
      Artist(
          name: 'Sakira',
          imgUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2F7%2F79%2FShakira_2014.jpg&f=1&nofb=1',
          link: null),
      Artist(
          name: 'Charlie Puth',
          imgUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.FAYA4ZgExOUTtg2gW4-NagHaGy%26pid%3DApi&f=1',
          link: null),
      Artist(
          name: 'Marshmello',
          imgUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.XqeB6BvRkSNlEiBtluR9dwHaNK%26pid%3DApi&f=1',
          link: null),
      Artist(
          name: 'Arijit Singh',
          imgUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.onltmBWDgQcmdmldixyDYAHaEK%26pid%3DApi&f=1',
          link: null),
      Artist(
          name: 'Taylor Swift',
          imgUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.OYVaPC9SWEWCKibVPgpG2QHaKM%26pid%3DApi&f=1',
          link: null),
    ], recentSongs: [
      Song(
          name: 'Love Story',
          artist: Artist(
              name: 'Taylor Swift',
              imgUrl:
                  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.OYVaPC9SWEWCKibVPgpG2QHaKM%26pid%3DApi&f=1',
              link: null),
          imgUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.EcGGvB5qEze1yf-cY7zjZgHaHa%26pid%3DApi&f=1',
          link: null),
      Song(
          name: 'We dont Talk Anymore',
          artist: Artist(
              name: 'Charlie Puth',
              imgUrl:
                  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.FAYA4ZgExOUTtg2gW4-NagHaGy%26pid%3DApi&f=1',
              link: null),
          imgUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.wHq7pPQU9qx5utiVbIajSQHaHa%26pid%3DApi&f=1',
          link: null),
      Song(
          name: 'F.R.I.E.N.D.S.',
          artist: Artist(
              name: 'Marshmello',
              imgUrl:
                  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.XqeB6BvRkSNlEiBtluR9dwHaNK%26pid%3DApi&f=1',
              link: null),
          imgUrl:
              'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.tX4tuQaorzxUtEhTE78YwgHaHa%26pid%3DApi&f=1',
          link: null)
    ]),
    instagram: Instagram(posts: [
      Post(
        imgUrl:
            'https://images.unsplash.com/photo-1560208774-70478f131afa?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDR8dG93SlpGc2twR2d8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      ),
      Post(
        imgUrl:
            'https://images.unsplash.com/photo-1622796460491-b1f5042e05c5?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDl8dG93SlpGc2twR2d8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      ),
      Post(
        imgUrl:
            'https://images.unsplash.com/photo-1512310604669-443f26c35f52?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDI4fHRvd0paRnNrcEdnfHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
      ),
      // for (var image in _images) Post(imgUrl: image),
    ]),
  ),
  AboutUser(
    photos: [
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.2Jv-JZugrvFJ61gBQaRI8wHaKc%26pid%3DApi&f=1",
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.wa6ccA0g8UR_L-2c_rGB5QHaJQ%26pid%3DApi&f=1",
      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MKS_MjLMVXlK-6Q07buYMAHaKQ%26pid%3DApi&f=1",
    ],
    dp: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MKS_MjLMVXlK-6Q07buYMAHaKQ%26pid%3DApi&f=1",
    username: "joeyking",
    name: "Joey King",
    gender: Gender.FEMALE,
    followers: 220,
    following: 341,
    // phone: '9124356780',
    jobTitle: 'Software Developer at Congle',
    age: 20,
    about: "Last time I was someone’s type, I was donating blood.",
    uid: 'demo4',
    // location: '15 KM away from you',
    linkedin: "https://in.linkedin.com/company/congle-india",
    interests: ['Crypto', 'Date', 'Music', 'Cricket', 'Movies'],
    spotify: sample_spotify,
  ),
  AboutUser(
    photos: [
      'https://images.unsplash.com/photo-1623944899355-428da972c776?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDF8dG93SlpGc2twR2d8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      "https://images.unsplash.com/photo-1614514161228-9f1543003961?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzF8fGZlbWFsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
    ],
    username: 'h_stein',
    name: "Hailee Steinfeld",
    // phone: '9124356780',
    gender: Gender.FEMALE,
    followers: 320,
    following: 101,
    jobTitle: 'Studing at IIMB',
    dp: "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmVtYWxlJTIwbW9kZWx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
    uid: 'demo5',
    age: 22,
    // location: '20 KM away from you',
  ),
  AboutUser(
    photos: [
      'https://images.unsplash.com/photo-1609748106519-2874fd373d59?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjN8fG1vZGVsJTIwZ2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
      "https://images.unsplash.com/photo-1617733569064-b6d6b2d6040a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjV8fG1vZGVsJTIwZ2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
      'https://images.unsplash.com/photo-1611601679655-7c8bc197f0c6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bW9kZWwlMjBnaXJsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    ],
    dp: "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmVtYWxlJTIwbW9kZWx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
    name: "Bulbul Ahmed",
    username: "bulbul",
    followers: 10,
    following: 31,
    gender: Gender.FEMALE,
    // phone: '9124356780',
    jobTitle: 'Studing at IIMB',
    about:
        "I’d tell you a lengthy description about myself but that would take away from the mystery.",
    uid: 'demo6',
    age: 22,
    // location: '20 KM away from you',
  ),
  // AboutUser(
  //     photos: [
  //       'https://images.unsplash.com/photo-1615022702095-ff2c036f3360?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aW5kaWFuJTIwZ2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //       'https://images.unsplash.com/photo-1623944899355-428da972c776?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDF8dG93SlpGc2twR2d8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //       "https://images.unsplash.com/photo-1614514161228-9f1543003961?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzF8fGZlbWFsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
  //     ],
  //     clubs: [
  //       'https://images.unsplash.com/photo-1612810806563-4cb8265db55f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjF8fHNwYWNleHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //       'https://images.unsplash.com/photo-1612810806563-4cb8265db55f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjF8fHNwYWNleHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //       'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmlrZXN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //       'https://images.unsplash.com/photo-1612810806563-4cb8265db55f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjF8fHNwYWNleHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //       'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmlrZXN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //     ],
  //     dp:
  //         "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZmVtYWxlJTIwbW9kZWx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
  //     name: "Anshi Dolai",
  //     phone: '9124356780',
  //     followers: 320,
  //     following: 301,
  //     gender: Gender.FEMALE,
  //     work: 'Studing at IIMB',
  //     about:
  //         "I’d tell you a lengthy description about myself but that would take away from the mystery.",
  //     id: 'demo7',
  //     linkedin: "https://in.linkedin.com/company/congle-india",
  //     age: 22,
  //     location: '20 KM away from you'),
  // AboutUser(
  //     photos: [
  //       'https://images.unsplash.com/photo-1622782262171-7eacb25db001?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGluZGlhbiUyMGdpcmx8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //       'https://images.unsplash.com/photo-1615022702095-ff2c036f3360?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aW5kaWFuJTIwZ2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //     ],
  //     followers: 1120,
  //     following: 3301,
  //     dp:
  //         'https://images.unsplash.com/photo-1615022702095-ff2c036f3360?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aW5kaWFuJTIwZ2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
  //     name: "Preety Gill",
  //     phone: '9124356780',
  //     gender: Gender.FEMALE,
  //     work: 'Studing at IIMB',
  //     about:
  //         "I’d tell you a lengthy description about myself but that would take away from the mystery.",
  //     id: 'demo8',
  //     linkedin: "https://in.linkedin.com/company/congle-india",
  //     age: 22,
  //     location: '20 KM away from you'),
];
