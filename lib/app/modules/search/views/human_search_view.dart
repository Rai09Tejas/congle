import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HumansSearchView extends StatelessWidget {
  const HumansSearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchsController>(
      init: SearchsController(),
      builder: (_cr) {
        return FutureBuilder<List<ShortProfile>>(
          future: _cr.getHumansToFollow(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ShortProfile>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<ShortProfile> profileList = snapshot.data!;
            if (profileList.isEmpty) {
              return const EmptyWidget(
                  title: 'Sorry We Can\'t Find any more Humans to Follow!');
            }

            return ListView.builder(
              itemCount: profileList.length,
              itemBuilder: (BuildContext context, int index) {
                ShortProfile profile = profileList.reversed.toList()[index];
                return FollowProfileTile(profile: profile);
              },
            );
          },
        );
      },
    );
  }
}
