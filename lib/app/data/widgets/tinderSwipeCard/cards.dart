import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './layout_overlays.dart';
import './matches.dart';
import 'profile_card.dart';

class CardStack extends StatefulWidget {
  final Function(Decision?, Match?)? onSwipeCallback;
  final Function(double dx)? onSwipeDistance;
  final Function(double dx)? onSwipeStart;
  final MatchEngine? matchEngine;
  final Function? ibutton;
  final Function? instaButton;
  final Function? spotifyButton;

  const CardStack(
      {Key? key,
      this.matchEngine,
      this.onSwipeCallback,
      this.ibutton,
      this.onSwipeStart,
      this.onSwipeDistance,
      this.instaButton,
      this.spotifyButton})
      : super(key: key);

  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack> {
  Key? _frontCard;
  Match? _currentMatch;
  double _nextCardScale = 0.0;

  double actionOpacity = 0.0;
  String actionText = 'NOPE';
  bool booldirection = false;

  @override
  void initState() {
    super.initState();
    widget.matchEngine!.addListener(_onMatchEngineChange);

    _currentMatch = widget.matchEngine!.currentMatch;
    _currentMatch!.addListener(_onMatchChange);

    _frontCard = Key(_currentMatch!.profile!.aboutUser.name);
  }

  @override
  void didUpdateWidget(CardStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.matchEngine != oldWidget.matchEngine) {
      oldWidget.matchEngine!.removeListener(_onMatchEngineChange);
      widget.matchEngine!.addListener(_onMatchEngineChange);

      if (_currentMatch != null) {
        _currentMatch!.removeListener(_onMatchChange);
      }

      _currentMatch = widget.matchEngine!.currentMatch;
      if (_currentMatch != null) {
        _currentMatch!.addListener(_onMatchChange);
      }
    }
  }

  @override
  void dispose() {
    if (_currentMatch != null) {
      _currentMatch!.removeListener(_onMatchChange);
    }

    widget.matchEngine!.removeListener(_onMatchEngineChange);
    super.dispose();
  }

  _onMatchEngineChange() {
    setState(() {
      if (_currentMatch != null) {
        _currentMatch!.removeListener(_onMatchChange);
      }

      _currentMatch = widget.matchEngine!.currentMatch;
      if (_currentMatch != null) {
        _currentMatch!.addListener(_onMatchChange);
      }
      if (_currentMatch != null) {
        _frontCard = Key(_currentMatch!.profile!.aboutUser.name);
      }
    });
  }

  _onMatchChange() {
    setState(() {});
  }

  Widget _buildBackCard() {
    if (widget.matchEngine!.nextMatch == null) return Container();
    return Transform(
      transform: Matrix4.identity()..scale(_nextCardScale, _nextCardScale),
      alignment: Alignment.center,
      child: ProfileCard(
        profile: widget.matchEngine!.nextMatch!.profile!,
        ibutton: widget.ibutton,
        isSecond: true,
      ),
    );
  }

  Widget _buildFrontCard() {
    return ProfileCard(
      key: _frontCard,
      profile: widget.matchEngine!.currentMatch!.profile!,
      ibutton: widget.ibutton,
      instaButton: widget.instaButton,
      spotifyButton: widget.spotifyButton,
      text: actionText,
      opacity: actionOpacity,
      direction: booldirection,
      isSecond: false,
    );
  }

  SlideDirection? _desiredSlideOutDirection() {
    switch (widget.matchEngine!.currentMatch!.decision) {
      case Decision.nope:
        return SlideDirection.left;

      case Decision.like:
        return SlideDirection.right;
      default:
        return null;
    }
  }

  void _onSlideStart(double distance, double dx) {
    setState(() {
      widget.onSwipeStart!(dx);
    });
  }

  void _onSlideUpdate(double distance, double dx) {
    setState(() {
      if (dx > 25) {
        actionText = 'DATE';
        booldirection = true;
        actionOpacity = (distance * 0.005).clamp(0, 1).toDouble();
        widget.onSwipeDistance!(dx);
      } else if (dx < -25) {
        actionText = 'NOPE';
        booldirection = false;
        actionOpacity = (distance * 0.005).clamp(0, 1).toDouble();
        widget.onSwipeDistance!(dx);
      } else {
        actionOpacity = 0.0;
      }
      _nextCardScale = (0.5 * (distance / 100.0)).clamp(0.0, 1.0);
    });
  }

  void _onSlideComplete(SlideDirection direction) {
    Match? currenMatch = widget.matchEngine!.currentMatch;

    switch (direction) {
      case SlideDirection.left:
        currenMatch!.nope();
        widget.onSwipeCallback!(currenMatch.decision, currenMatch);
        break;
      case SlideDirection.right:
        currenMatch!.like();
        widget.onSwipeCallback!(currenMatch.decision, currenMatch);
        break;
    }
    setState(() {
      actionOpacity = 0.0;
    });

    widget.matchEngine!.cycleMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (widget.matchEngine!.nextMatch != null)
          DraggableCard(
            screenHeight: Get.height,
            screenWidth: Get.width,
            isDraggable: false,
            card: _buildBackCard(),
          ),
        if (widget.matchEngine!.currentMatch != null)
          DraggableCard(
            screenHeight: Get.height,
            screenWidth: Get.width,
            card: _buildFrontCard(),
            slideTo: _desiredSlideOutDirection(),
            onSlideUpdate: _onSlideUpdate,
            onSlideComplete: _onSlideComplete,
            onSlideStart: _onSlideStart,
          ),
      ],
    );
  }
}

enum SlideDirection {
  left,
  right,
}

class DraggableCard extends StatefulWidget {
  final Widget? card;
  final bool isDraggable;
  final SlideDirection? slideTo;
  final Function(double distance, double direction)? onSlideUpdate;
  final Function(double distance, double direction)? onSlideStart;
  final Function(SlideDirection direction)? onSlideComplete;
  final double? screenWidth;
  final double? screenHeight;

  // ignore: use_key_in_widget_constructors
  const DraggableCard({
    Key? key,
    this.card,
    this.isDraggable = true,
    this.slideTo,
    this.onSlideStart,
    this.onSlideUpdate,
    this.onSlideComplete,
    this.screenWidth,
    this.screenHeight,
  });

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with TickerProviderStateMixin {
  Decision? decision;
  GlobalKey profileCardKey = GlobalKey(debugLabel: 'profile_card_key');
  Offset? cardOffset = const Offset(0.0, 0.0);
  Offset? dragStart;
  Offset? dragPosition;
  Offset? slideBackStart;
  SlideDirection? slideOutDirection;
  late AnimationController slideBackAnimation;
  Tween<Offset>? slideOutTween;
  late AnimationController slideOutAnimation;

  @override
  void initState() {
    super.initState();
    slideBackAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..addListener(() => setState(() {
            cardOffset = Offset.lerp(slideBackStart, const Offset(0.0, 0.0),
                Curves.elasticOut.transform(slideBackAnimation.value));

            if (null != widget.onSlideUpdate) {
              widget.onSlideUpdate!(cardOffset!.distance, cardOffset!.dx);
            }
          }))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStart = null;
            slideBackStart = null;
            dragPosition = null;
          });
        }
      });

    slideOutAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(() => setState(() {
            cardOffset = slideOutTween!.evaluate(slideOutAnimation);

            if (null != widget.onSlideUpdate) {
              widget.onSlideUpdate!(cardOffset!.distance, cardOffset!.dx);
            }
          }))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStart = null;
            dragPosition = null;
            slideOutTween = null;

            if (widget.onSlideComplete != null) {
              widget.onSlideComplete!(slideOutDirection!);
            }
          });
        }
      });
  }

  @override
  void didUpdateWidget(DraggableCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.card!.key != oldWidget.card!.key) {
      cardOffset = const Offset(0.0, 0.0);
    }

    if (oldWidget.slideTo != null) {
      switch (widget.slideTo!) {
        case SlideDirection.left:
          _slideLeft();
          break;
        case SlideDirection.right:
          _slideRight();
          break;
        default:
      }
    }
  }

  @override
  void dispose() {
    slideBackAnimation.dispose();
    slideOutAnimation.dispose();
    super.dispose();
  }

  void _slideLeft() {
    // final screenWidth = context.size.width;
    dragStart = _chooseRandomDragStart();
    // widget.onSlideStart(0,0);
    slideOutTween = Tween(
      begin: const Offset(0.0, 0.0),
      end: Offset(-2 * widget.screenWidth!, 0.0),
    );

    slideOutAnimation.forward(from: 0.0);
  }

  Offset _chooseRandomDragStart() {
    final cardContex = profileCardKey.currentContext!;
    final cardTopLeft = (cardContex.findRenderObject() as RenderBox)
        .localToGlobal(const Offset(0.0, 0.0));
    final dragStartY =
        widget.screenHeight! * (Random().nextDouble() < 0.5 ? 0.25 : 0.75) +
            cardTopLeft.dy;

    return Offset(widget.screenWidth! / 2 + cardTopLeft.dx, dragStartY);
  }

  void _slideRight() {
    dragStart = _chooseRandomDragStart();
    // widget.onSlideStart(0,0);
    slideOutTween = Tween(
      begin: const Offset(0.0, 0.0),
      end: Offset(2 * widget.screenWidth!, 0.0),
    );

    slideOutAnimation.forward(from: 0.0);
  }

  void _onPanStart(DragStartDetails details) {
    dragStart = details.globalPosition;
    widget.onSlideStart!(0, 0);
    if (slideBackAnimation.isAnimating) {
      slideBackAnimation.stop(canceled: true);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      dragPosition = details.globalPosition;
      cardOffset = (dragPosition! - dragStart!);

      if (null != widget.onSlideUpdate) {
        widget.onSlideUpdate!(cardOffset!.distance, cardOffset!.dx);
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final dragVector = cardOffset! / cardOffset!.distance;
    final isInLeftRegion = (cardOffset!.dx / context.size!.width) < -0.45;
    final isInRightRegion = (cardOffset!.dx / context.size!.width) > 0.45;

    setState(() {
      if (isInLeftRegion || isInRightRegion) {
        slideOutTween = Tween(
            begin: cardOffset, end: dragVector * (2 * context.size!.width));

        slideOutAnimation.forward(from: 0.0);

        slideOutDirection =
            isInLeftRegion ? SlideDirection.left : SlideDirection.right;
      } else {
        widget.onSlideStart!(-1, -1);
        slideBackStart = cardOffset;
        slideBackAnimation.forward(from: 0.0);
      }
    });
  }

  double _rotation(Rect dragBounds) {
    if (dragStart != null) {
      final rotationCornerMultiplier = dragStart!.dy >= dragBounds.top ? -1 : 1;
      return (pi / 8) *
          (cardOffset!.dx / dragBounds.width) *
          rotationCornerMultiplier;
    } else {
      return 0.0;
    }
  }

  Offset _rotationOrigin(Rect dragBounds) {
    if (dragStart != null) {
      return dragStart! - dragBounds.topLeft;
    } else {
      return const Offset(0.0, 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnchoredOverlay(
      showOverlay: true,
      child: const Center(),
      overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor) {
        return CenterAbout(
          position: anchor,
          child: Transform(
            transform: Matrix4.translationValues(
                cardOffset!.dx, cardOffset!.dy.clamp(0.0, 0.0), 0.0)
              ..rotateZ(_rotation(anchorBounds)),
            origin: _rotationOrigin(anchorBounds),
            child: Container(
              key: profileCardKey,
              width: anchorBounds.width,
              height: anchorBounds.height,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
              child: widget.isDraggable
                  ? GestureDetector(
                      onPanStart: _onPanStart,
                      onPanUpdate: _onPanUpdate,
                      onPanEnd: _onPanEnd,
                      child: widget.card,
                    )
                  : widget.card,
            ),
          ),
        );
      },
    );
  }
}
