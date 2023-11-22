import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/controller/AddressController/search_address_controller.dart';
import 'package:pbl6_app/src/widgets/text_field_widget.dart';

import '../../values/app_colors.dart';
import '../../values/app_styles.dart';
import '../../widgets/app_bar_default.dart';

class SearchAddressScreen extends StatelessWidget {
  const SearchAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchAddressController searchController =
        Get.put(SearchAddressController(apiClient: Get.find()));
    // SearchAddressController(apiClient: Get.find());
    return Scaffold(
        appBar: AppWidget.appBar('Tìm kiếm địa chỉ'),
        body: GetBuilder<SearchAddressController>(
            initState: (state) => searchController.initValue(),
            builder: (_) {
              return TextFieldContainer(
                showAll: true,
                child: TextField(
                  controller: searchController.addressController,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.mainColor1,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    hintText: "Địa chỉ",
                    hintStyle: AppStyles.textMedium
                        .copyWith(color: AppColors.colorTextBlur),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    searchController.placeAutoComplete(value);
                  },
                ),
              );
            }));
  }
}
