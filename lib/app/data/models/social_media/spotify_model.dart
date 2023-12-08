// To parse this JSON data, do
//
//     final spotifyModel = spotifyModelFromMap(jsonString);

import 'dart:convert';

class Spotify {
  Spotify({
    required this.topArtists,
    required this.recentSongs,
  });

  List<Artist>? topArtists;
  List<Song>? recentSongs;

  factory Spotify.fromJson(String str) => Spotify.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Spotify.fromMap(Map<String, dynamic> json) => Spotify(
        topArtists: json["topArtists"] == null
            ? null
            : List<Artist>.from(
                json["topArtists"].map((x) => Artist.fromMap(x))),
        recentSongs: json["recentSongs"] == null
            ? null
            : List<Song>.from(json["recentSongs"].map((x) => Song.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "topArtists": topArtists == null
            ? null
            : List<dynamic>.from(topArtists!.map((x) => x.toMap())),
        "recentSongs": recentSongs == null
            ? null
            : List<dynamic>.from(recentSongs!.map((x) => x.toMap())),
      };
}

class Song {
  Song({
    required this.name,
    required this.artist,
    required this.imgUrl,
    required this.link,
  });

  String? name;
  Artist? artist;
  String? imgUrl;
  String? link;

  factory Song.fromJson(String str) => Song.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Song.fromMap(Map<String, dynamic> json) => Song(
        name: json["name"],
        artist: json["artist"] == null ? null : Artist.fromMap(json["artist"]),
        imgUrl: json["imgUrl"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "artist": artist == null ? null : artist!.toMap(),
        "imgUrl": imgUrl,
        "link": link,
      };
}

class Artist {
  Artist({
    required this.name,
    required this.imgUrl,
    required this.link,
  });

  String? name;
  String? imgUrl;
  String? link;

  factory Artist.fromJson(String str) => Artist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Artist.fromMap(Map<String, dynamic> json) => Artist(
        name: json["name"],
        imgUrl: json["imgUrl"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "imgUrl": imgUrl,
        "link": link,
      };
}

// ignore: non_constant_identifier_names
Spotify sample_spotify = Spotify.fromJson("""{
  "topArtists": [
    {
      "name": "Dallin Schuppe I",
      "imgUrl": "https://images.unsplash.com/photo-1545996124-0501ebae84d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "link": "https://eva.biz"
    },
    {
      "name": "Bernadine Purdy",
      "imgUrl": "https://images.unsplash.com/photo-1545996124-0501ebae84d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "link": "https://lindsey.com"
    },
    {
      "name": "Roslyn Langosh",
      "imgUrl": "https://images.unsplash.com/photo-1545996124-0501ebae84d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "link": "http://miracle.name"
    },
    {
      "name": "Francis Bailey",
      "imgUrl": "https://images.unsplash.com/photo-1545996124-0501ebae84d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "link": "https://jane.info"
    },
    {
      "name": "Cristian Lind",
      "imgUrl": "https://images.unsplash.com/photo-1545996124-0501ebae84d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "link": "http://miles.com"
    }
  ],
  "recentSongs": [
    {
      "name": "F.R.I.E.N.D.S",
      "artist": {
        "name": "Misty Armstrong",
        "imgUrl": "https://images.unsplash.com/photo-1545996124-0501ebae84d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "link": "https://pamela.org"
      },
      "imgUrl": "http://lorempixel.com/640/480/nature",
      "link": "https://giles.biz"
    },
    {
      "name": "See You Again",
      "artist": {
        "name": "Misty Armstrong",
        "imgUrl": "https://images.unsplash.com/photo-1545996124-0501ebae84d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "link": "https://pamela.org"
      },
      "imgUrl": "http://lorempixel.com/640/480/nature",
      "link": "https://jamel.name"
    },
    {
      "name": "La La La",
      "artist": {
        "name": "Misty Armstrong",
        "imgUrl": "https://images.unsplash.com/photo-1545996124-0501ebae84d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fGh1bWFufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "link": "https://pamela.org"
      },
      "imgUrl": "http://lorempixel.com/640/480/nature",
      "link": "http://quinten.net"
    }
  ]
}""");
