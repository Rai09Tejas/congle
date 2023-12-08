import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KInstagramContainer extends StatefulWidget {
  const KInstagramContainer(
      {Key? key, required this.instaProfile, this.isDialog = true})
      : super(key: key);
  final Instagram? instaProfile;
  final bool isDialog;

  @override
  _KInstagramContainerState createState() => _KInstagramContainerState();
}

class _KInstagramContainerState extends State<KInstagramContainer> {
  final List<Widget> _pages = <Widget>[];

  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    List<String?> photos =
        widget.instaProfile!.posts!.map((e) => e.imgUrl).toList();
    if (photos.isEmpty) {
      _pages.add(Wrap(children: [noImage()]));
    } else {
      for (var i = 0; i < photos.length; i += 6) {
        _pages.add(
          SizedBox(
            width: Get.width,
            child: Wrap(
              runSpacing: 5,
              spacing: 5,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (var photo in photos.getRange(
                    i, ((i + 6) > photos.length) ? photos.length : (i + 6)))
                  imageContainer(photo!),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.isDialog)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            height: 5,
            width: Get.width * 0.2,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(25)),
          ),
        Expanded(
          child: PageView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index];
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsIndicator(
                controller: _controller,
                itemCount: _pages.length,
                onPageSelected: (int page) {
                  _controller.animateToPage(
                    page,
                    duration: 500.milliseconds,
                    curve: Curves.easeIn,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Container imageContainer(String imgUrl) {
    return Container(
      width: Get.width * 0.28,
      height: Get.width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container noImage() {
    return Container(
      width: Get.width * 0.3,
      height: Get.width * 0.25,
      decoration: BoxDecoration(
          color: Get.theme.colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all()),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Text(
            'No Image to show',
            style: Get.textTheme.titleLarge,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({
    Key? key,
    required this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color = Colors.black,
    this.selectedColor,
    this.isLongDots = false,
  }) : super(key: key, listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  /// The color of the dots.
  final Color color;

  /// The color of the active dot.
  final Color? selectedColor;

  /// The length of the active dot.
  final bool? isLongDots;

  // The base size of the dots
  static const double _kDotSize = 10.0;
  // The distance between the center of each dot
  static const double _kDotSpacing = 20.0;

  Widget _buildDot(int index) {
    bool isActive = false;
    isActive = (controller.page ?? controller.initialPage).round() == index;
    return SizedBox(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: isActive
              ? (selectedColor ?? Get.theme.colorScheme.secondary)
              : color,
          type: MaterialType.circle,
          child: SizedBox(
            width: _kDotSize,
            height: _kDotSize,
            child: InkWell(
              onTap: () => onPageSelected!(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class ChipDotsIndicator extends AnimatedWidget {
  const ChipDotsIndicator({
    Key? key,
    required this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color = Colors.black,
    this.selectedColor,
    this.isLongDots = false,
  }) : super(key: key, listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  /// The color of the dots.
  final Color color;

  /// The color of the active dot.
  final Color? selectedColor;

  /// The length of the active dot.
  final bool? isLongDots;

  // The base size of the dots
  static const double _kDotWidth = 12.0;

  static const double _kActiveDotWidth = 32.0;

  static const double _kDotHeight = 4.0;
  // The distance between the center of each dot
  static const double _kDotSpacing = 20.0;

  Widget _buildDot(int index) {
    bool isActive = false;
    isActive = (controller.page ?? controller.initialPage).round() == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: isActive ? _kActiveDotWidth : _kDotWidth,
      child: Center(
        child: Material(
          color: isActive ? (selectedColor ?? kcGreen) : color,
          type: MaterialType.card,
          child: SizedBox(
            width: isActive ? _kActiveDotWidth : _kDotWidth,
            height: _kDotHeight,
            // child: InkWell(
            //   onTap: () => onPageSelected!(index),
            // ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}
