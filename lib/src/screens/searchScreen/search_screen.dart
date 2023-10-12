import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_assets.dart';

import '../../values/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            floating: false,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              titlePadding: const EdgeInsets.only(left: 50, bottom: 5),
              title: Container(
                // width: size.width,
                height: 40,
                decoration: const ShapeDecoration(
                    shape: StadiumBorder(), color: AppColors.placeholder),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(width: 2, color: AppColors.borderGray)),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search_rounded),
                      hintText: 'Tìm kiếm'),
                ),
              ),
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    AppAssets.bundauImage,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ), // Set the height of the app bar when it is expanded
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 100, // Set the number of items in your list
            ),
          ),
        ],
      ),
    );
  }
}
