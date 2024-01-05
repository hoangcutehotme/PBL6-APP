import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:pbl6_app/src/model/contact_model.dart' as ContactModel;
import 'package:pbl6_app/src/model/order_detail_shipper.dart';
import 'package:pbl6_app/src/model/shipper.dart';
import 'package:pbl6_app/src/model/shipper_order.dart';
import 'package:pbl6_app/src/values/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
import 'package:pbl6_app/src/utils/loading_full_screen.dart';
import 'package:dio/dio.dart' as dio;

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
  // current shipper order
  OrderDetailShipper _currentOrder = OrderDetailShipper();
  OrderDetailShipper get currentOrder => _currentOrder;
  // current contact
  ContactModel.Contact _contactChoose = ContactModel.Contact();
  ContactModel.Contact get contacChoose => _contactChoose;

  final GlobalKey<FormState> changeInfoKey = GlobalKey<FormState>();
  File? _vehicleImage, _behindCCCDImage, _frontCCCDImage, _licenseImage;
  File? get vehicleImage => _vehicleImage;
  File? get behindCCCDImage => _behindCCCDImage;
  File? get frontCCCDImage => _frontCCCDImage;
  File? get licenseImage => _licenseImage;

  XFile? _photo;
  XFile? get photo => _photo;

  late TextEditingController emailController,
      firstNameController,
      lastnameController,
      addressController,
      phoneController,
      vehicleType,
      vehicleNumber,
      licenseNumber;

  var isFormValid = false.obs;

  @override
  onInit() async {
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastnameController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    vehicleType = TextEditingController();
    vehicleNumber = TextEditingController();
    licenseNumber = TextEditingController();

    await getIdToken();
    await getInfoShipperrById();
    await getListOrderNearShipper();
    await setInitInfo();

    super.onInit();
  }

  setInitInfo() {
    emailController.text = user.value.email.toString();
    firstNameController.text = user.value.firstName.toString();
    lastnameController.text = user.value.lastName.toString();
    addressController.text = user.value.contact?[0].address.toString() ?? '';
    phoneController.text = user.value.contact?[0].phoneNumber.toString() ?? '';
    vehicleType.text = user.value.vehicleType.toString();
    vehicleNumber.text = user.value.vehicleNumber.toString();
    licenseNumber.text = user.value.licenseNumber.toString();
    _photo = null;
    isChange.value = false;
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

  String? validate(String value) {
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
        phoneController.text != user.value.contact![0].phoneNumber.toString() ||
        _photo != null) {
      return true;
    }
    return false;
  }

  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();
    _photo =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (_photo != null) {
      print('choosen');
      isChange.value = true;
      update();
    } else {
      print('not choose');
    }
  }

  updateUser(String idUser) async {
    LoadingFullScreen.showLoading();
    try {
      var url = "${ApiEndPoints.baseUrl}/shipper/$idUser";

      var dioInstance = dio.Dio();

      final formData = dio.FormData.fromMap(
        {
          "firstName": firstNameController.text.trim(),
          "lastName": lastnameController.text.trim(),
          "address": addressController.text.trim(),
          "phoneNumber": phoneController.text.trim(),
          "vehicleType": vehicleType.text.trim(),
          "vehicleNumber": vehicleNumber.text.trim(),
          "licenseNumber": licenseNumber.text.trim(),
        },
      );

      if (_photo != null) {
        formData.files.add(MapEntry(
            "photo",
            await dio.MultipartFile.fromFile(
              _photo!.path,
              filename: 'photo.jpg',
            )));
      }

      ApiClient apiClient = Get.find();
      var headers = apiClient.header;

      var response = await dioInstance.patch(
        url,
        data: formData,
        options: dio.Options(
          followRedirects: false,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );

      LoadingFullScreen.cancelLoading();

      if (response.statusCode == 200) {
        isChange.value = false;
        Get.back();
        await getInfoShipperrById();

        CustomeSnackBar.showSuccessSnackTopBar(
          context: Get.context,
          title: 'Success',
          message: 'Cập nhật thông tin thành công',
        );
      } else {
        Get.back();
        CustomeSnackBar.showWarningTopBar(
          context: Get.context,
          title: 'Error',
          message: 'Cập nhật không thành công',
        );
      }
    } catch (e) {
      print(e);
      LoadingFullScreen.cancelLoading();
      Get.back();
      CustomeSnackBar.showWarningTopBar(
        context: Get.context,
        title: 'Error',
        message: 'Cập nhật không thành công',
      );
    } finally {
      LoadingFullScreen.cancelLoading();
    }
  }

  updateUser1(String idUser) async {
    LoadingFullScreen.showLoading();
    try {
      var url = "${ApiEndPoints.baseUrl}/shipper/$idUser";

      FormData formData = FormData({
        "firstName": firstNameController.text.trim(),
        "lastName": lastnameController.text.trim(),
        "address": addressController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
        "vehicleType": vehicleType.text.trim(),
        "vehicleNumber": vehicleNumber.text.trim(),
        "licenseNumber": licenseNumber.text.trim(),
      });

      if (_photo != null) {
        formData.files.add(MapEntry(
          'photo',
          MultipartFile(
            _photo!.path,
            filename: 'photo.jpg',
          ),
        ));
      }

      // Map<String, dynamic> dataMap = Map.fromEntries(formData.fields);
      // Map<String, dynamic> dataFile = Map.fromEntries(formData.files);
      // Map<String, dynamic> dataMap1 = Map.from(formData.);

      ApiClient apiClient = Get.find();

      var headers = apiClient.header;

      var dioInstance = dio.Dio();

      var response = await dioInstance.patch(
        url,
        data: formData.files,
        options: dio.Options(headers: headers),
      );

      // var response = await dioInstance.patch(
      //   url,
      //   data: dataMap,
      //   options: dio.Options(headers: headers),
      // );

      LoadingFullScreen.cancelLoading();

      if (response.statusCode == 200) {
        isChange.value = false;
        Get.back();

        getInfoShipperrById();

        update();

        CustomeSnackBar.showSuccessSnackTopBar(
            context: Get.context,
            title: 'Success',
            message: 'Cập nhật thông tin thành công');
      } else {
        Get.back();
        CustomeSnackBar.showWarningTopBar(
            context: Get.context,
            title: 'Error',
            message: 'Cập nhật không thành công');
      }
    } catch (e) {
      LoadingFullScreen.cancelLoading();
      Get.back();
      CustomeSnackBar.showWarningTopBar(
          context: Get.context,
          title: 'Error',
          message: 'Cập nhật không thành công');
      print(e);
    } finally {
      LoadingFullScreen.cancelLoading();
    }
  }

  Future<void> getIdToken() async {
    final SharedPreferences prefs = await _prefs;
    id.value = prefs.getString(AppString.SHAREPREF_USERID) ?? '';
    token.value = prefs.getString(AppString.SHAREPREF_TOKEN) ?? '';
    role.value = prefs.getString(AppString.ROLE) ?? '';
    update();
  }

  Future<void> getInfoShipperrById() async {
    try {
      ApiClient apiClient = Get.find();

      var url = Uri.parse("${ApiEndPoints.baseUrl}/shipper/${id.value}");
      var response = await http.get(url, headers: apiClient.header);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        user.value = Shipper.fromJson(json);
        _photo = null;
        _contactChoose = user.value.contact!
            .firstWhere((element) => element.id == user.value.defaultContact);
        update();
      } else {}
    } catch (e) {
      print(e);
    }
  }

  void changeEdit() {
    // isEdit.value = true;
    user = user;
    update();
  }

  // change the address to delivery

  changeAddressContactDefault(ContactModel.Contact contact) {
    // _contactChoose = Contact();
    _contactChoose = contact;
    update();
  }

  Future<bool> checkShipper() async {
    await getInfoShipperrById();
    if (user.value.status == "Tạm Ngừng") {
      return false;
    }
    return true;
  }

  getListOrderNearShipper() async {
    try {
      checkShipper().then((value) async {
        if (!value) {
          _listOrder = [];
          update();
          CustomeSnackBar.showWarningTopBar(
              context: Get.context,
              title: "Thông báo",
              message: "Tài khoản của bạn bị khoá");
          return;
        } else {
          ApiClient apiClient = Get.find();

          var url = "${ApiEndPoints.baseUrl}/shipper/${id.value}/find-orders";

          var response =
              await http.get(Uri.parse(url), headers: apiClient.header);
          if (response.statusCode == 200) {
            var json = jsonDecode(response.body);
            _listOrder = orderShipperFromJson(jsonEncode(json['data']));
            update();
          } else {}
        }
      });
    } catch (e) {}
  }

  updateOrderDetail(OrderDetailShipper order) {
    _currentOrder = order;
    update();
  }
}
