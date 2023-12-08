import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: ShapeDecoration(
          color: const Color(0xFFC8DE44),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFF0F0F0)),
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: child);
  }
}
