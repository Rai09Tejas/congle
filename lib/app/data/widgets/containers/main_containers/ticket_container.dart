import 'package:flutter/material.dart';

class TicketContainer extends StatefulWidget {
  final double width;
  final double height;
  final Widget childUp;
  final Widget childDown;
  final Color color;
  final bool isCornerRounded;

  const TicketContainer(
      {Key? key,
      required this.width,
      required this.height,
      required this.childUp,
      required this.childDown,
      this.color = Colors.white,
      this.isCornerRounded = false})
      : super(key: key);

  @override
  _TicketContainerState createState() => _TicketContainerState();
}

class _TicketContainerState extends State<TicketContainer> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: widget.width,
        height: widget.height,
        child: Column(
          children: [
            Expanded(child: widget.childUp),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 30, left: 30),
              child: dashedLine(Colors.black),
            ),
            Expanded(child: widget.childDown),
          ],
        ),
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: widget.isCornerRounded
                ? BorderRadius.circular(20.0)
                : BorderRadius.circular(0.0)),
      ),
    );
  }

  Widget dashedLine(Color color) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 12.0;
        const dashHeight = 5.0;
        final dashCount = (boxWidth / (1.3 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    const curveRadius = 20.0;

    path.moveTo(curveRadius, 0);
    path.arcToPoint(const Offset(0, curveRadius),
        radius: const Radius.circular(curveRadius), clockwise: false);
    path.lineTo(0.0, size.height - curveRadius);
    path.arcToPoint(Offset(curveRadius, size.height),
        radius: const Radius.circular(curveRadius), clockwise: false);
    path.lineTo(size.width - curveRadius, size.height);
    path.arcToPoint(Offset(size.width, size.height - curveRadius),
        radius: const Radius.circular(curveRadius), clockwise: false);
    path.lineTo(size.width, curveRadius);
    path.arcToPoint(Offset(size.width - curveRadius, 0),
        radius: const Radius.circular(curveRadius), clockwise: false);

    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height / 2), radius: curveRadius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: curveRadius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
