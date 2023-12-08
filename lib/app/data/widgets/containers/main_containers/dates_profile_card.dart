import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data.dart';

class DatesProfileCard extends StatelessWidget {
  const DatesProfileCard(
      {Key? key,
      required this.profile,
      this.onTap,
      this.firstButton,
      this.firstButtonCallback,
      this.secondButton,
      this.secondButtonCallback,
      this.time,
      this.removeCard})
      : super(key: key);

  final ShortProfile profile;
  final Function()? onTap;
  final String? firstButton;
  final Function()? firstButtonCallback;
  final String? secondButton;
  final Function()? secondButtonCallback;
  final DateTime? time;
  final Function()? removeCard;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: profile.id,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Get.theme.backgroundColor,
                borderRadius: BorderRadius.circular(21),
                image: DecorationImage(
                  image: NetworkImage(profile.dp),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (time != null)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Text(
                    TimeFormat(time!),
                    style: Get.textTheme.caption!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            if (removeCard != null)
              Positioned(
                top: 10,
                left: 10,
                child: Material(
                  elevation: 0,
                  type: MaterialType.transparency,
                  borderRadius: BorderRadius.circular(17),
                  child: InkWell(
                    onTap: removeCard,
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 15,
                        )),
                  ),
                ),
              ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(21.0),
                    bottomLeft: Radius.circular(21.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment(-0.02, -3.98),
                    end: Alignment(0.0, 3.42),
                    colors: [Color(0x09ffffff), Color(0xf00b0909)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      profile.name.toString().split(' ')[0] +
                          ', ' +
                          profile.age.toString(),
                      style: Get.textTheme.headline6!
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (secondButton != null &&
                            secondButtonCallback != null)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              child: KOutlineButton(
                                title: secondButton,
                                onPressed: secondButtonCallback,
                              ),
                            ),
                          ),
                        if (firstButton != null && firstButtonCallback != null)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              child: KButton(
                                title: firstButton!,
                                onPressed: firstButtonCallback!,
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
