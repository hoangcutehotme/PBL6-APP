import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/SearchController/search_controller.dart';
import '../../values/app_colors.dart';
import '../../values/app_styles.dart';

class SearchSection extends SearchDelegate {
  final SearchFoodStoreController _searchController =
      Get.put(SearchFoodStoreController());

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  TextStyle? get searchFieldStyle =>
      AppStyles.textMedium.copyWith(fontSize: 16);

  @override
  String? get searchFieldLabel => 'Tìm kiếm';

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: AppColors.mainColorBackground,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _searchController.searchFoodAndStore(query),
          builder: (context, snapshot) {
            print("Snapshot  ${snapshot.data}");
            if (query == "") return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data == []) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data);
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => const Center(
        child: Text(
          'Không có kết quả',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      );

  Widget buildSuggestionsSuccess(List<Map<String, dynamic>>? suggestions) =>
      ListView.separated(
        itemCount: suggestions!.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return Column(
            children: [
              ListTile(
                onTap: () {
                  query = suggestion['name'];
                  // 1. Show Results
                  showResults(context);

                  // 2. Close Search & Return Result
                  close(context, query);

                  // // 3. Navigate to Result Page
                  Get.toNamed('/detailshop', arguments: suggestion['storeId']);
                  // Get.toNamed('/detailshop',
                  //               arguments: stories[index].id);
                },
                // title: Text(suggestion),
                title: RichText(
                  text: TextSpan(
                      text: suggestion['name'],
                      style: AppStyles.textMedium.copyWith(fontSize: 16)),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 2,
          );
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: query, style: AppStyles.textMedium.copyWith(fontSize: 16)),
    );
  }
}
