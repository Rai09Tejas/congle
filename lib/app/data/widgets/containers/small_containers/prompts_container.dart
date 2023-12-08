import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromptsContainer extends StatelessWidget {
  const PromptsContainer(
    this.question,
    this.answer, {
    Key? key,
  }) : super(key: key);

  final String question, answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
              style: Get.textTheme.bodyText1!
                  .copyWith(color: Get.theme.focusColor)),
          Text(answer, style: Get.textTheme.bodyText2),
        ],
      ),
    );
  }
}
