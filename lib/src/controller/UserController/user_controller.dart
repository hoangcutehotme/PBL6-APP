// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/model/contact_model.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pbl6_app/src/data/repository/user_respository.dart';
import 'package:pbl6_app/src/model/user_model.dart';
import 'package:pbl6_app/src/utils/custome_dialog.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/utils/loading_full_screen.dart';

import '../../utils/api_endpoints.dart';

class UserController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final UserRespo respo;

  UserController({
    required this.respo,
  });

  var user = UserModel(role: 'User').obs;
  var id = ''.obs;
  var token = ''.obs;
  var role = ''.obs;

  var isLoading = false.obs;
  var isEdit = false.obs;
  var isChange = false.obs;

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
      if (role.value == "User") {
        await getInfoUserById().then((value) {
          setInitInfo();
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
    role.value = prefs.getString(AppString.ROLE) ?? '';
    update();
  }

  Future<void> getInfoUserById() async {
    try {
      await getIdToken().then((_) async {
        if (id.value == '') {
          // isLoading(false);
          CustomeDialog.showCustomeDialog(
              context: Get.context,
              title: '',
              message: 'Bạn chưa đăng ký !!!',
              pressConfirm: () {
                Get.toNamed("/signup");
              },
              confirmText: 'Đăng ký');
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("Bạn chưa đăng ký !!!"),
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed("/signup");
                        },
                        child: const Text("Đăng ký"))
                  ],
                  // children: [Text(e.toString())],
                );
              });
        } else {
          var cookies = token.value;

          var headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $cookies',
          };
          var url = Uri.parse("${ApiEndPoints.baseUrl}/user/${id.value}");

          var response = await http.get(url, headers: headers);
          var json = jsonDecode(response.body);
          if (response.statusCode == 200) {
            user.value = UserModel.fromJson(json);
            _contactChoose = user.value.contact!.firstWhere(
                (element) => element.id == user.value.defaultContact);

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
        }
      });
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

  addNewContact(dynamic body) async {
    try {
      var url = "${ApiEndPoints.baseUrl}/user/add-contact/${id.value}";
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      };
      // var response1 = await respo.addAddressContact(id.value, body);
      var response = await http.put(Uri.parse(url),
          body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        user.value = UserModel.fromJson(jsonDecode(response.body));
        
        update();

        CustomeSnackBar.showSuccessSnackTopBar(
            context: Get.context, title: 'Success', message: 'Thêm thành công');
        return true;
      } else {
        CustomeSnackBar.showWarningTopBar(
            context: Get.context,
            title: 'Error',
            message: 'Thêm không thành công');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
