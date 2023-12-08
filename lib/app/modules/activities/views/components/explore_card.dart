import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../explore_view.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    Key? key,
    required this.category,
    this.onPressed,
  }) : super(key: key);
  final ActivityCategory category;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 5, 8),
      child: AspectRatio(
        aspectRatio: 13 / 16,
        child: InkWell(
          onTap: () => Get.to(() => ExploreView(category: category)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: category.title,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(category.dp), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment(0.0, 0.12),
                    end: Alignment(0.0, 1.0),
                    colors: [Color(0x00131313), Color(0xff0e0d0d)],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    category.title,
                    style: Get.textTheme.headline6!
                        .copyWith(color: Colors.white, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> exploreImages = [
  'https://images.unsplash.com/photo-1482350325005-eda5e677279b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8Y2FmZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1600980300832-0a4657648418?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fGFjdGl2aXRpZXN8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1493246318656-5bfd4cfb29b8?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cm9vZnRvcHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  'https://images.unsplash.com/photo-1566737236500-c8ac43014a67?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Y2x1YnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'
];
List<String> exploreNames = [
  'Cafe',
  'Activities',
  'Rooftop',
  'Club',
];
