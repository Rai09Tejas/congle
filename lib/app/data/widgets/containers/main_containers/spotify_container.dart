import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KSpotifyContainer extends StatelessWidget {
  const KSpotifyContainer(
      {Key? key, required this.spotify, this.isDialog = true})
      : super(key: key);
  final Spotify? spotify;
  final bool isDialog;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isDialog)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              height: 5,
              width: Get.width * 0.2,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(25)),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Top Artist on Spotify',
                      style: Get.textTheme.caption!.copyWith(fontSize: 18)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (Artist artist in spotify!.topArtists!)
                        Container(
                          width: 45,
                          height: 45,
                          // padding: EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.0),
                            image: DecorationImage(
                              image: NetworkImage(artist.imgUrl!),
                              fit: BoxFit.cover,
                            ),
                            // border: Border.all(
                            //     width: 1.0, color: const Color(0xff707070)),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Recent Played',
                      style: Get.textTheme.caption!.copyWith(fontSize: 18)),
                  for (Song song in spotify!.recentSongs!)
                    KListTile(
                      title: song.name,
                      subtitle: song.artist!.name,
                      leading: Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0)),
                          child: Image.network(
                            song.imgUrl!,
                            fit: BoxFit.cover,
                          )),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
