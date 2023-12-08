import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField(
      {Key? key,
      required this.controller,
      this.pretext,
      required this.hint,
      this.suffixIcon,
      this.isReadOnly = false,
      this.keyboardType,
      this.callback,})
      : super(key: key);
  final TextEditingController controller;
  final String? pretext, suffixIcon;
  final String hint;
  final bool? isReadOnly;
  final TextInputType? keyboardType;
  final Function? callback;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color: widget.controller.text.isEmpty
                  ? const Color(0xFFADADAD)
                  : const Color(0xFF292929)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          readOnly: widget.isReadOnly ?? false,
          onChanged: (value) {
            if (widget.callback != null) {
              widget.callback!();
            }
          },
          style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Hanken Grotesk',
              fontWeight: FontWeight.w400,
              color: kcBlack),
          decoration: InputDecoration(
              prefixText: widget.pretext,
              prefixStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Hanken Grotesk',
                  fontWeight: FontWeight.w400,
                  color: kcBlack),
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: KSvgIcon(
                        assetName: widget.suffixIcon,
                        size: 1,
                      ),
                    )
                  : null,
              hintText: widget.hint,
              hintStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
