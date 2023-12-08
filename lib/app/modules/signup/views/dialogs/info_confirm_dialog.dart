import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoConfirmDialogContainer extends StatelessWidget {
  const InfoConfirmDialogContainer({Key? key, required this.onAccept})
      : super(key: key);
  final Function() onAccept;

  @override
  Widget build(BuildContext context) {
    return KBottomDialogContainer(
      height: 250,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "This information can't be changed in future",
              style: Get.textTheme.headline6,
            ),
            // SizedBox(height: 15),
            Text(
              "Your name, date of birth & gender can't be modified again, kindly check information again and then accept it.",
              style: Get.textTheme.bodyText2,
            ),
            // SizedBox(height: 15),
            KButton(
              title: 'Accept & Continue',
              onPressed: onAccept,
              fontSize: 16,
              padding: const EdgeInsets.all(10),
            ),
          ],
        ),
      ),
      onTap: () => Get.back(),
    );
  }
}
