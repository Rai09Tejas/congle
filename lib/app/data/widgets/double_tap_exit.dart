import 'dart:async';

import 'package:congle/app/modules/home/controllers/swipe_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Allows the user to close the app by double tapping the back-button.
///
/// You must specify a [SnackBar], so it can be shown when the user taps the
/// back-button. Notice that the value you set for [SnackBar.duration] is going
/// to be considered to decide whether the snack-bar is currently visible or
/// not.
///
/// Since the back-button is an Android feature, this Widget is going to be
/// nothing but the own [child] if the current platform is anything but Android.
class DoubleBackToExit extends StatefulWidget {
  /// The [SnackBar] shown when the user taps the back-button.
  final SnackBar snackBar;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates a widget that allows the user to close the app by double tapping
  /// the back-button.
  const DoubleBackToExit({
    Key? key,
    required this.snackBar,
    required this.child,
  }) : super(key: key);

  @override
  _DoubleBackToExitState createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<DoubleBackToExit> {
  /// The last time the user tapped Android's back-button.
  DateTime? _lastTimeBackButtonWasTapped;

  /// Returns whether the current platform is Android.
  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  /// Returns whether the [DoubleBackToExit.snackBar] is currently visible.
  ///
  /// The snack-bar is going to be considered visible if the duration of the
  /// snack-bar is greater than the difference from now to the
  /// [_lastTimeBackButtonWasTapped].
  ///
  /// This is not quite accurate since the snack-bar could've been dismissed by
  /// the user, so this algorithm needs to be improved, as described in #2.
  bool get _isSnackBarVisible {
    final lastTimeBackButtonWasTapped = _lastTimeBackButtonWasTapped;
    return (lastTimeBackButtonWasTapped != null) &&
        (widget.snackBar.duration >
            DateTime.now().difference(lastTimeBackButtonWasTapped));
  }

  /// Returns whether the next back navigation of this route will be handled
  /// internally.
  ///
  /// Returns true when there's a widget that inserted an entry into the
  /// local-history of the current route, in order to handle pop. This is done
  /// by [Drawer], for example, so it can close on pop.
  bool get _willHandlePopInternally =>
      ModalRoute.of(context)?.willHandlePopInternally ?? false;

  @override
  Widget build(BuildContext context) {
    assert(() {
      _ensureThatContextContainsScaffold();
      return true;
    }());

    if (_isAndroid) {
      return WillPopScope(
        onWillPop: _handleWillPop,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  /// Handles [WillPopScope.onWillPop].
  Future<bool> _handleWillPop() async {
    if (_isSnackBarVisible || _willHandlePopInternally) {
      return true;
    } else {
      var _sc = Get.find<SwipeCardController>();
      if (_sc.instaEntry != null || _sc.spotifyEntry != null) {
        if (_sc.instaEntry!.mounted || _sc.spotifyEntry!.mounted) {
          Get.log('Closing Overlay');
          _sc.removeEntry();
          return false;
        }
      }
      _lastTimeBackButtonWasTapped = DateTime.now();
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.hideCurrentSnackBar();

      scaffoldMessenger.showSnackBar(widget.snackBar);
      return false;
    }
  }

  /// Throws a [FlutterError] if this widget was not wrapped in a [Scaffold].
  void _ensureThatContextContainsScaffold() {
    if (Scaffold.maybeOf(context) == null) {
      throw FlutterError(
        '`DoubleBackToCloseApp` must be wrapped in a `Scaffold`.',
      );
    }
  }
}
