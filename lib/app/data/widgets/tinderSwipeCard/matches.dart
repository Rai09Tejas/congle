import 'package:flutter/widgets.dart';

import '../../data.dart';

class MatchEngine extends ChangeNotifier {
  final List<Match> _matches;
  int? _currrentMatchIndex;
  int? _nextMatchIndex;

  MatchEngine({
    required List<Match> matches,
  }) : _matches = matches {
    _currrentMatchIndex = 0;
    _nextMatchIndex = matches.length > 1 ? 1 : null;
  }

  Match? get currentMatch =>
      _currrentMatchIndex == null ? null : _matches[_currrentMatchIndex!];
  Match? get nextMatch =>
      _nextMatchIndex == null ? null : _matches[_nextMatchIndex!];

  void cycleMatch() {
    if (currentMatch!.decision != Decision.indecided) {
      currentMatch!.reset();
      _currrentMatchIndex = _nextMatchIndex;
      if (_nextMatchIndex != null) {
        _nextMatchIndex = _nextMatchIndex! < _matches.length - 1
            ? _nextMatchIndex! + 1
            : null;
      }
      notifyListeners();
    }
  }
}

class Match extends ChangeNotifier {
  final Profile? profile;
  Decision? decision = Decision.indecided;

  Match({this.profile, this.decision});

  void like() {
    //  if (decision == Decision.indecided) {
    decision = Decision.like;
    notifyListeners();
    // }
  }

  void nope() {
    // if (decision == Decision.indecided) {
    decision = Decision.nope;
    notifyListeners();
    //  }
  }

  void reset() {
    // if (decision != Decision.indecided) {
    decision = Decision.indecided;
    notifyListeners();
    // }
  }
}

enum Decision { indecided, nope, like }
