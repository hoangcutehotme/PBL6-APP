import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/values/app_string.dart';

// import '../../model/place_autocomplete_model.dart';

class SearchAddressController extends GetxController {
  final ApiClient apiClient;

  // late GooglePlace googlePlace;
  // GooglePlace googlePlace;
  final TextEditingController addressController = TextEditingController();
  // final List<AutocompletePrediction> _predictions = [];
  // List<AutocompletePrediction> get prediction => _predictions;

  SearchAddressController({required this.apiClient});

  @override
  void onInit() {
    super.onInit();
    initValue();
  }

  @override
  void onClose() {
    super.onClose();
    // addressController.text = '';
    update();
  }

  initValue() {
    addressController.text = '';
    update();
  }

  Future<void> placeAutoComplete(String value) async {
    Uri uri =
        Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": value,
      "key": AppString.API_KEY,
    });

    var response = await apiClient.getData(uri.toString());
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(">>>>>>>>>>>" + response.body);
    }
  }
}
