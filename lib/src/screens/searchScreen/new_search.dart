import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/screens/searchScreen/seach_section.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

import '../../controller/SearchController/search_controller.dart';

class NetworkSearchAppBarPage extends StatelessWidget {
  const NetworkSearchAppBarPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // title: Text(MyApp.title),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                showSearch(context: context, delegate: SearchSection());

                // final results = await
                //     showSearch(context: context, delegate: CitySearch());

                // print('Result: $results');
              },
            )
          ],
          backgroundColor: Colors.purple,
        ),
        body: Container(
          // color: Colors.black,
          child: const Center(
            child: Text(
              'Network Weather Search',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 64,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
