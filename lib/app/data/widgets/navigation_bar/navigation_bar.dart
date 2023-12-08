import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data.dart';

class BottomNavBar extends StatefulWidget {
  final List<String> listOfIcons;
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.listOfIcons,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  double indicatorLeft = Get.width * 0.145;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth =
            constraints.maxWidth * 0.5 / widget.listOfIcons.length;

        // Ensure that the indicatorLeft is only set once
        indicatorLeft = Get.width * (0.068 + 0.168 * widget.currentIndex);

        return Container(
          // margin: const EdgeInsets.all(20),
          height: 64,
          decoration: ShapeDecoration(
            color: const Color(0xFF292929),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Color(0xFFF0F0F0),
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: indicatorLeft,
                bottom: 0,
                child: Container(
                  height: 5,
                  width: 32,
                  decoration: BoxDecoration(
                    color: kcGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(widget.listOfIcons.length, (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          indicatorLeft = index * itemWidth;
                        });
                        widget.onTap(index);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: KSvgIcon(
                        assetName: widget.listOfIcons[index],
                        size: 24,
                        color: index == widget.currentIndex ? kcGreen : kcWhite,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
