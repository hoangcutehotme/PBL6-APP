import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/model/contact_model.dart';
import 'package:pbl6_app/src/model/shipper.dart';
import 'package:pbl6_app/src/model/shipper_order.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/utils/loading_full_screen.dart';

import '../../data/repository/shipper_respository.dart';
import '../../utils/api_endpoints.dart';

class ShipperController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ShipperRepo shipperRepo;

  ShipperController({required this.shipperRepo});

  var user = Shipper(role: 'Shipper').obs;

  var id = ''.obs;
  var token = ''.obs;
  var role = ''.obs;

  var isLoading = false.obs;
  var isEdit = false.obs;
  var isChange = false.obs;

  // list order shipper
  List<OrderShipper> _listOrder = [];
  List<OrderShipper> get listOrder => _listOrder;

  Contact _contactChoose = Contact();

  Contact get contacChoose => _contactChoose;

  final GlobalKey<FormState> changeInfoKey = GlobalKey<FormState>();

  late TextEditingController emailController,
      firstNameController,
      lastnameController,
      addressController,
      phoneController;

  var isFormValid = false.obs;

  @override
  Future<void> onInit() async {
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastnameController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    await getIdToken().then((_) async {
      if (role.value == "Shipper") {
        await getInfoShipperrById().then((value) {
          setInitInfo();
          getListOrder();
        });
      }
    });

    super.onInit();
  }

  setInitInfo() {
    emailController.text = user.value.email.toString();
    firstNameController.text = user.value.firstName.toString();
    lastnameController.text = user.value.lastName.toString();
    addressController.text = user.value.contact?[0].address.toString() ?? '';
    phoneController.text = user.value.contact?[0].phoneNumber.toString() ?? '';
    update();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.clear();
    firstNameController.clear();
    lastnameController.clear();
    addressController.clear();
    phoneController.clear();
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Không được để trống";
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.length != 10) {
      return "Số điện thoại không hợp lệ";
    }
    return null;
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Không được để trống";
    }
    return null;
  }

  bool validateForm() {
    final isValid = changeInfoKey.currentState!.validate();
    if (!isValid) {
      return false;
    }

    changeInfoKey.currentState!.save();
    return true;
  }

  bool checkChangeForm() {
    if (!isChange.value) {
      return false;
    }
    if (emailController.text != user.value.email.toString() ||
        firstNameController.text != user.value.firstName ||
        lastnameController.text != user.value.lastName.toString() ||
        addressController.text != user.value.contact![0].address.toString() ||
        phoneController.text != user.value.contact![0].phoneNumber.toString()) {
      return true;
    }
    return false;
  }

  updateUser(String idUser) async {
    LoadingFullScreen.showLoading();
    var body = {
      "firstName": firstNameController.text.trim(),
      "lastName": lastnameController.text.trim(),
      "address": addressController.text.trim(),
      "phoneNumber": phoneController.text.trim()
    };
    var cookies = token.value;

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $cookies',
    };

    var url = Uri.parse("${ApiEndPoints.baseUrl}/user/$idUser");

    final respose =
        await http.patch(url, body: jsonEncode(body), headers: headers);

    if (respose.statusCode == 200) {
      isChange.value = false;
      Get.back();
      LoadingFullScreen.cancelLoading();
      CustomeSnackBar.showSuccessSnackBar(
          context: Get.context,
          title: 'Success',
          message: 'Cập nhật thông tin thành công');
    } else {
      LoadingFullScreen.cancelLoading();
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context,
          title: 'Error',
          message: 'Cập nhật không thành công');
    }
  }

  Future<void> getIdToken() async {
    final SharedPreferences prefs = await _prefs;
    id.value = prefs.getString(AppString.SHAREPREF_USERID) ?? '';
    token.value = prefs.getString(AppString.SHAREPREF_TOKEN) ?? '';

    update();
  }

  Future<void> getInfoShipperrById() async {
    try {
      var cookies = token.value;

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $cookies',
      };
      var url = Uri.parse("${ApiEndPoints.baseUrl}/user/${id.value}");

      var response = await http.get(url, headers: headers);
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        user.value = Shipper.fromJson(json);
        _contactChoose = user.value.contact!
            .firstWhere((element) => element.id == user.value.defaultContact);

        update();
        // isLoading(false);
      } else {
        // isLoading(false);

        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text("Error UserController"),
                children: [Text(response.body.toString())],
              );
            });
      }
    } catch (e) {
      // isLoading(false);
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error user"),
              children: [Text(e.toString())],
            );
          });
    }
  }

  void changeEdit() {
    // isEdit.value = true;
    user = user;
    update();
  }

  // change the address to delivery

  changeAddressContactDefault(Contact contact) {
    // _contactChoose = Contact();
    _contactChoose = contact;
    update();
  }

  getListOrder() async {
    try {
      ApiClient apiClient = Get.find();
      var url = "${ApiEndPoints.baseUrl}/shipper/${id.value}/find-orders";

      var response = await http.get(Uri.parse(url), headers: apiClient.header);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        _listOrder = orderShipperFromJson(jsonEncode(json['data']));
        update();
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context, title: "Error", message: '');
      }
    } catch (e) {
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: "Error", message: '');
    }
  }
}
