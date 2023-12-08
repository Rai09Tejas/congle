import 'dart:developer';
import 'dart:io';

import 'package:congle/app/data/config/config.dart';
import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/signup/controllers/signup_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddProfileImages extends StatefulWidget {
  const AddProfileImages({Key? key, required this.controller})
      : super(key: key);

  final SignupController controller;

  @override
  _AddProfileImagesState createState() => _AddProfileImagesState();
}

class _AddProfileImagesState extends State<AddProfileImages> {
  int tappedImageIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final hasImage = index < widget.controller.imageList.length;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (!hasImage) {
                widget.controller.pickImages().then((success) {
                  setState(() {});
                });
              } else {
                setState(() {
                  tappedImageIndex = tappedImageIndex == index ? -1 : index;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: DottedBorder(
                borderType: BorderType.RRect,
                strokeWidth: 1,
                color: kcGeryIcon,
                dashPattern: [2, hasImage ? 0 : 4],
                radius: const Radius.circular(8),
                child: SizedBox(
                  width: 110,
                  height: 120,
                  child: hasImage
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            ImageWidget(
                              imagePath:
                                  widget.controller.imageList[index].path,
                            ),
                            if (tappedImageIndex == index)
                              InkWell(
                                onTap: () {
                                  widget.controller.deleteImage(index);
                                  setState(() {});
                                },
                                child: Center(
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: kcWhite,
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                      child: const Center(
                                        child: KSvgIcon(
                                            assetName: svg_delete,
                                            size: 24,
                                            color: kcBlack),
                                      )),
                                ),
                              ),
                          ],
                        )
                      : Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0x33747474),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: const Icon(Icons.add_rounded,
                                color: kcGrey, size: 24, weight: 1),
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String imagePath;

  const ImageWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imagePath),
      fit: BoxFit.contain,
    );
  }
}
