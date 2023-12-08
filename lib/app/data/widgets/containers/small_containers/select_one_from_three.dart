import 'package:congle/app/modules/signup/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../texts/custom_heading_text.dart';
import '../../texts/custom_texts.dart';

class SelectOneWidget extends StatefulWidget {
  const SelectOneWidget(
      {Key? key, required this.containerDetails, required this.callback})
      : super(key: key);
  final List<Map<String, dynamic>> containerDetails;
  final Function callback;

  @override
  _SelectOneWidgetState createState() => _SelectOneWidgetState();
}

class _SelectOneWidgetState extends State<SelectOneWidget> {
  int? selectedContainer;

  final SignupController controller = SignupController();

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.containerDetails
            .map((e) => buildSelectableContainer(e))
            .toList());
  }

  Widget buildSelectableContainer(Map<String, dynamic> details) {
    final isSelected = selectedContainer == details['index'];

    return GestureDetector(
      onTap: () {
        widget.callback(details['enum']);
        setState(() {
          selectedContainer = details['index'];
        });
      },
      child: Container(
        width: 110,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes the position of the shadow
            ),
          ],
          image: DecorationImage(image: AssetImage(details['image'])),
          gradient: LinearGradient(
            begin: const Alignment(-0.00, -1.00),
            end: const Alignment(0, 1),
            colors: [Colors.black.withOpacity(0), Colors.black],
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: Colors.black,
                  width: 2,
                )
              : null,
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: customHankenText(details['title'], kcWhite, 12,
                FontWeight.w700, TextAlign.center)),
      ),
    );
  }
}
