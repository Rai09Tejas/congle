import 'package:congle/app/data/data.dart';
import 'package:congle/app/data/widgets/texts/custom_heading_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KGenderSwitchBottomSheet extends StatelessWidget {
  const KGenderSwitchBottomSheet(
      {Key? key,
      required this.rxGender,
      required this.onChanged,
      required this.onTap})
      : super(key: key);
  final Rx<Gender> rxGender;
  final Function(Gender? gender) onChanged;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return KBottomDialogContainer(
      height: Get.height * 0.4,
      elevation: 0.0,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            customHeadingText('choose any one', kcBlack, 24, FontWeight.w500),
            for (var gender in Gender.values)
              Obx(() => RadioListTile<Gender>(
                  value: gender,
                  groupValue: rxGender.value,
                  toggleable: true,
                  title: Text(
                    getGenderString(gender),
                    style: Get.textTheme.bodyMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                  activeColor: Get.theme.colorScheme.secondary,
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        // Color when the radio button is selected
                        return Colors.blue; // Replace with your desired color
                      } else {
                        // Color when the radio button is unselected
                        return Colors.grey; // Replace with your desired color
                      }
                    },
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: onChanged)),
          ],
        ),
      ),
    );
  }
}
