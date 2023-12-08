import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KAppBar {
  final double _maxHeight;
  final double _minHeight;
  final double expandedHeight;
  final double collapsedHeight;

  KAppBar({required this.expandedHeight, required this.collapsedHeight})
      : _maxHeight = expandedHeight + Get.mediaQuery.padding.top,
        _minHeight = collapsedHeight + Get.mediaQuery.padding.top;

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - _minHeight) / (_maxHeight - _minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }

  AlwaysStoppedAnimation<double> getAnimation(BoxConstraints constraints) =>
      AlwaysStoppedAnimation(_calculateExpandRatio(constraints));

  /// Add your widgets with animation here in `child`
  ///
  /// get animation variable by calling getAnimation with LayoutBuilder
  /// ```
  /// KAppBar kappbar = new KAppBar(collapsedHeight: 180, expandedHeight: 500);
  /// LayoutBuilder(
  ///    builder: (context, constraints) {
  ///     final animate = kappbar.getAnimation(constrains);
  ///     return Container(
  ///        padding: EdgeInsets.only(
  ///          bottom: Tween<double>(begin: 0, end: 10).evaluate(animation),
  ///        child: ...
  ///        ),
  ///   },
  /// );
  /// ```
  ///
  Widget appBarContainer(Widget child) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final animation = getAnimation(constraints);

        return Container(
          padding: EdgeInsets.only(
            bottom: Tween<double>(begin: 0, end: 10).evaluate(animation),
          ),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(
            //       Tween<double>(begin: kBorderRadius.bottomLeft.x, end: 0)
            //           .evaluate(animation)),
            //   bottomRight: Radius.circular(
            //       Tween<double>(begin: kBorderRadius.bottomLeft.x, end: 0)
            //           .evaluate(animation)),
            // ),
            // gradient: LinearGradient(
            //   begin: Alignment(1.0, -1.0),
            //   end: Alignment(-1.0, 5.0),
            //   colors: [
            //     ColorTween(begin: Colors.white, end: Colors.transparent)
            //         .evaluate(animation)!,
            //   ],
            //   stops: [0.0, 1.0],
            // ),
            color: ColorTween(begin: Colors.white, end: Colors.transparent)
                .evaluate(animation)!,
          ),
          child: SizedBox(
              // padding:
              //     EdgeInsets.fromLTRB(10, Get.mediaQuery.padding.top, 10, 5),
              width: Get.width,
              child: child),
        );
      },
    );
  }
}

class KAppBarContent extends StatelessWidget {
  final AlwaysStoppedAnimation<double> animation;
  final Widget? trailingButton;
  final Widget? mainIcon;
  final String title;
  final String? desc;
  final String imageUrl;
  final String? heroTag;

  const KAppBarContent(
      {Key? key,
      required this.animation,
      this.trailingButton,
      this.mainIcon,
      required this.title,
      this.desc,
      this.heroTag,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: Tween<double>(begin: 0, end: 1).evaluate(animation),
          child: heroTag != null
              ? Hero(
                  tag: heroTag!,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  ),
                ),
        ),
        Opacity(
          opacity: Tween<double>(begin: 0, end: 1).evaluate(animation),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: <Color>[Colors.black, Colors.transparent],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, Get.mediaQuery.padding.top, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.back(),
                radius: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.0),
                    color: const Color(0x99ffffff),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.black),
                ),
              ),
              (trailingButton != null)
                  ? trailingButton!
                  : const SizedBox(width: 50),
            ],
          ),
        ),
        Positioned(
          bottom: Tween<double>(begin: 15, end: 10).evaluate(animation),
          left: Tween<double>(begin: 75, end: 10).evaluate(animation),
          width: Get.width,
          child: Align(
            alignment: AlignmentTween(
                    begin: Alignment.centerLeft, end: Alignment.bottomLeft)
                .evaluate(animation),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height:
                        Tween<double>(begin: 0, end: 50).evaluate(animation)),
                if (mainIcon != null)
                  SizedBox(
                    height:
                        Tween<double>(begin: 0, end: 125).evaluate(animation),
                    width:
                        Tween<double>(begin: 0, end: 125).evaluate(animation),
                    child: mainIcon,
                  ),
                SizedBox(
                    height:
                        Tween<double>(begin: 0, end: 15).evaluate(animation)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize:
                        Tween<double>(begin: 30, end: 36).evaluate(animation),
                    color: ColorTween(begin: Colors.black, end: Colors.white)
                        .evaluate(animation)!,
                    // shadows: [kShadow],
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (desc != null)
                  Text(
                    desc!,
                    style: Get.textTheme.bodyText2!.copyWith(
                      fontSize:
                          Tween<double>(begin: 0, end: 14).evaluate(animation),
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
