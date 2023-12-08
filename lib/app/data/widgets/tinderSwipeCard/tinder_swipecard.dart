export 'cards.dart';
export 'layout_overlays.dart';
export 'matches.dart';
export 'photos.dart';
export 'profile_card.dart';

import 'package:congle/app/modules/home/views/components/no_match_left.dart';
import 'package:flutter/material.dart';

import './cards.dart';
import './matches.dart';

class TinderSwipeCard extends StatelessWidget {
  const TinderSwipeCard({
    Key? key,
    required this.demoProfiles,
    this.myCallbackend,
    this.ibutton,
    this.instaButton,
    this.myCallbackDistance,
    this.myCallbackStart,
    required this.noMatchLeftButton,
    this.spotifyButton,
  }) : super(key: key);

  final List demoProfiles;

  final Function() noMatchLeftButton;
  final Function()? ibutton;
  final Function()? instaButton;
  final Function()? spotifyButton;
  final Function(Decision?, Match?, bool)? myCallbackend;
  final Function(double dx)? myCallbackStart;
  final Function(double dx)? myCallbackDistance;

  @override
  Widget build(BuildContext context) {
    final MatchEngine matchEngine = MatchEngine(
        matches: demoProfiles.map((final profile) {
      return Match(profile: profile);
    }).toList());

    return demoProfiles.isEmpty ||
            // nothingLeft ||
            (matchEngine.currentMatch == null && matchEngine.nextMatch == null)
        ? NoMatchLeft(
            onButtonPress: noMatchLeftButton,
          )
        : CardStack(
            matchEngine: matchEngine,
            ibutton: ibutton,
            instaButton: instaButton,
            spotifyButton: spotifyButton,
            onSwipeCallback: (match, currentMatch) {
              myCallbackend!(
                  match, currentMatch, matchEngine.nextMatch == null);
            },
            onSwipeDistance: myCallbackDistance,
            onSwipeStart: myCallbackStart,
          );
  }
}
