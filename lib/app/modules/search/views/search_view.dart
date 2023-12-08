import 'package:congle/app/data/data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';
import 'human_search_view.dart';
import 'club_search_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _RoomsViewState createState() => _RoomsViewState();
}

class _RoomsViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  final controller = Get.put<SearchsController>(SearchsController());

  @override
  void initState() {
    controller.initTabController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'EXPLORE',
          style: Get.textTheme.headline1!.copyWith(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: KTextField(
              hintText: 'Search for Humans & Clubs',
              leading: const Icon(Icons.search),
              controller: controller.searchController,
              fontSize: 18,
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.transparent,
                child: TabBar(
                  unselectedLabelColor: Get.theme.focusColor,
                  labelColor: Get.theme.colorScheme.secondary,
                  tabs: const [
                    Tab(
                      text: 'HUMANS',
                    ),
                    Tab(
                      text: 'CLUBS',
                    ),
                  ],
                  controller: controller.tabController,
                  indicatorColor: Get.theme.colorScheme.secondary,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
              ),
              // Divider(),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                HumansSearchView(),
                ClubsSearchView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
