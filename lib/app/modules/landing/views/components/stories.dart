import 'package:congle/app/data/widgets/tags/tags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/config/colors.dart';
import '../../../../data/widgets/texts/custom_heading_text.dart';

class StoriesWidget extends StatefulWidget {
  const StoriesWidget({Key? key}) : super(key: key);

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int totalStories = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.5,
                height: Get.height * 0.1,
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                      left: 0,
                      top: Get.height * 0.025,
                      child: customHeadingText(
                          "our stories", kcBlack, 24, FontWeight.w400)),
                  Positioned(
                    left: Get.width * 0.13,
                    top: 8.81,
                    child: Container(
                      width: 108.79,
                      height: 58.39,
                      decoration: const ShapeDecoration(
                        shape: OvalBorder(
                          side:
                              BorderSide(width: 0.25, color: Color(0xFF292929)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: Get.width * 0.4,
                    top: 0,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(0.25),
                      child: Container(
                        width: 22.90,
                        height: 22.90,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFC8DE44),
                          shape: StarBorder(
                            side: BorderSide(
                                width: 0.25, color: Color(0xFF292929)),
                            points: 10,
                            innerRadiusRatio: 0.38,
                            pointRounding: 0,
                            valleyRounding: 0,
                            rotation: 0,
                            squash: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              const Spacer(),
              Text(
                "${_currentPage + 1}/$totalStories",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  totalStories,
                  (int index) {
                    return Container(
                      width: index == _currentPage ? 12 : 4,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: index == _currentPage
                            ? const Color(0xFFD9D9D9)
                            : const Color(0xFF131313),
                        shape: index == _currentPage
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              )
                            : const OvalBorder(
                                side: BorderSide(
                                    width: 0.25, color: Color(0x3F757474)),
                              ),
                      ),
                      margin: const EdgeInsets.all(4),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 280,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: totalStories,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Stack(children: [
                        Container(
                          height: 280,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage("assets/images/story.png"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        const Positioned(
                          top: 40,
                          left: 60,
                          child: TagWidget(
                              child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'New Additi',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Hanken Grotesk',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                    letterSpacing: -0.25,
                                  ),
                                ),
                                TextSpan(
                                  text: 'o',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'TestDomaine',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: -0.25,
                                  ),
                                ),
                                TextSpan(
                                  text: 'n',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Hanken Grotesk',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                    letterSpacing: -0.25,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                        const Positioned(
                            bottom: 40,
                            left: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'O',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'TestDomaine',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                          letterSpacing: -0.25,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'IA CAFE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontFamily: 'Hanken Grotesk',
                                          fontWeight: FontWeight.bold,
                                          height: 0,
                                          letterSpacing: -0.25,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\'',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'TestDomaine',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                          letterSpacing: -0.25,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '(Hennur, Bangalore)',
                                        style: TextStyle(
                                          color: Color(0xFFF0F0F0),
                                          fontSize: 10,
                                          fontFamily: 'Hanken Grotesk',
                                          fontWeight: FontWeight.w300,
                                          height: 0.28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Cozy / Modern / Stylish',
                                  style: TextStyle(
                                    color: Color(0xFFF0F0F0),
                                    fontSize: 16,
                                    fontFamily: 'Test Domaine Display',
                                    fontWeight: FontWeight.w400,
                                    height: 0.11,
                                  ),
                                )
                              ],
                            )),
                      ]);
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
