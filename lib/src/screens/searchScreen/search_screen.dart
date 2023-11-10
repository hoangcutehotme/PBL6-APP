import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/SearchController/search_controller.dart';
import 'package:pbl6_app/src/screens/searchScreen/new_search.dart';
import 'package:pbl6_app/src/values/app_assets.dart';

import '../../values/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchFoodStoreController _searchController =
      Get.put(SearchFoodStoreController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.colorTextBold,
        backgroundColor: AppColors.mainColorBackground,
        shadowColor: Colors.transparent,
        leadingWidth: 25,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          color: AppColors.mainColor1,
          onPressed: () {
            Get.back();
          },
        ),
        title: Container(
          width: size.width,
          height: 45,
          decoration: const ShapeDecoration(
              shape: StadiumBorder(), color: AppColors.placeholder),
          child: TextField(
            controller: _searchController.search,
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Tìm kiếm'),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const NetworkSearchAppBarPage());
              },
              icon: Image.asset(AppAssets.getImg('filter_icon.png', 'icons')))
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _searchController
              .searchFoodAndStore(_searchController.search.text),
          builder: (context, snapshot) {
            if (_searchController.search == '') {
              return const Center(
                child: Text('no data'),
              );
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError || snapshot.data!.isEmpty) {
                  return Container();
                } else {
                  return buidSuccess(snapshot.data);
                }
            }
          }),
    );
  }

  ListView buidSuccess(List<Map<String, dynamic>>? list) {
    return ListView.builder(
        itemCount: list!.length,
        itemBuilder: (context, index) {
          var suggestion = list[index];
          return ListTile(
            title: Text(suggestion['name']!),
            onTap: () {
              _searchController.search.text = suggestion['name'];
            },
          );
        });
  }
}
