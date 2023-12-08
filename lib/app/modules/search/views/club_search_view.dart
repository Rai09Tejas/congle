import 'package:congle/app/data/data.dart';
import 'package:congle/app/modules/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClubsSearchView extends StatelessWidget {
  const ClubsSearchView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchsController>(
      init: SearchsController(),
      builder: (_cr) {
        return FutureBuilder<List<ShortClub>>(
          future: _cr.getClubsToFollow(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ShortClub>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<ShortClub> clubList = snapshot.data!;
            if (clubList.isEmpty) {
              return const EmptyWidget(
                  title: 'Sorry We Can\'t Find any more Humans to Follow!');
            }

            return GridView.builder(
              itemCount: clubList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: (5 / 6),
              ),
              itemBuilder: (BuildContext context, int index) {
                ShortClub club = clubList[index];
                return FollowClubContainer(club: club);
              },
            );
          },
        );
      },
    );
  }
}
