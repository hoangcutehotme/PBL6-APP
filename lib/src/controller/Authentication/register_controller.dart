import 'dart:convert';
import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl6_app/src/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_app/src/utils/custome_snackbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // for shipper
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  File? _vehicleImage, _behindCCCDImage, _frontCCCDImage, _licenseImage;
  File? get vehicleImage => _vehicleImage;
  File? get behindCCCDImage => _behindCCCDImage;
  File? get frontCCCDImage => _frontCCCDImage;
  File? get licenseImage => _licenseImage;

  @override
  void onClose() {
    super.onClose();
    emailController.clear();
    passwordController.clear();
    passwordConfirmController.clear();
    firstnameController.clear();
    lastnameController.clear();
    addressController.clear();
    phoneController.clear();
  }

  var isLoading = false.obs;
  var isShowPass = true.obs;
  var isShowPassConfirm = true.obs;

  var client = http.Client();

  // true is user, false is shipper
  var isUser = true.obs;

  Future getVehicleImage() async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (img == null) {
        return;
      }

      _vehicleImage = File(img.path);

      update();
    } catch (e) {
      print("Error $e");
    }
  }

  Future getFrontCCCDImage() async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (img == null) {
        return;
      }
      print(img.path);

      _frontCCCDImage = File(img.path);

      update();
    } catch (e) {
      print("Error $e");
    }
  }

  Future getBehindCCCDImage() async {
    try {

      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (img == null) {
        return;
      }
      print(img.path);

      _behindCCCDImage = File(img.path);

      update();
    } catch (e) {
      print("Error $e");
    }
  }

  Future getLicenseImage() async {
    try {
      print("get image");

      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (img == null) {
        return;
      }

      _licenseImage = File(
        img.path,
      );

      update();

      
    } catch (e) {
      print("Error $e");
    }
  }

  void changeShowPassConfirm() {
    isShowPassConfirm.toggle();
  }

  void changeShowPass() {
    isShowPass.toggle();
  }

  void changeRole(String role) {
    if (role == "user") {
      isUser.value = true;

      update();
    } else if (role == "shipper") {
      isUser.value = false;
      update();
    }
  }

  bool validateForm() {
    if (!emailController.text.isEmail) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: 'Error', message: 'Email không hợp lệ');
      return false;
    } else if (!phoneController.text.isNumericOnly ||
        (phoneController.text.trim().length > 10 ||
            phoneController.text.length < 10)) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context,
          title: 'Error',
          message: 'Số điện thoại không hợp lệ');
      return false;
    } else if (passwordConfirmController.text.isEmpty ||
        passwordController.text.isEmpty) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context, title: 'Thông báo', message: 'Mật khẩu trống');
      return false;
    } else if (passwordConfirmController.text != passwordController.text) {
      CustomeSnackBar.showWarningTopBar(
          context: Get.context,
          title: "Thông báo",
          message: 'Mật khẩu không trùng');
      return false;
    } else {
      return true;
    }
  }

//   Future<http.MultipartFile> compressImageToMultipartFile(File imageFile, String fieldName) async {
//   final int maxSizeInBytes = 50 * 1024 * 1024; // Maximum size in bytes (50MB)
//   List<int> imageBytes = await imageFile.readAsBytes();
//   int fileSize = imageBytes.length;

//   if (fileSize <= maxSizeInBytes) {
//     return await http.MultipartFile.fromPath(fieldName, imageFile.path);
//   } else {
//     int quality = ((maxSizeInBytes / fileSize) * 100).round();
//     List<int> compressedBytes = await FlutterImageCompress.compressWithList(
//       imageBytes,
//       quality: quality,
//     );

//     final tempDir = await getTemporaryDirectory();
//     final compressedFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg')
//       ..writeAsBytesSync(compressedBytes);

//     return await http.MultipartFile.fromPath(fieldName, compressedFile.path);
//   }
// }

  Future<bool> registerShipperEmail() async {
    try {
      var url = "${ApiEndPoints.baseUrl}/shipper";

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Accept'] = 'application/json';

      request.fields.addAll({
        "firstName": firstnameController.text.trim(),
        "lastName": lastnameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "passwordConfirm": passwordConfirmController.text.trim(),
        "address": addressController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
        "licenseNumber": licenseNumberController.text.trim(),
        "vehicleType": vehicleTypeController.text.trim(),
        "vehicleNumber": vehicleNumberController.text.trim(),
      });

      if (_vehicleImage != null &&
          _behindCCCDImage != null &&
          _frontCCCDImage != null &&
          _licenseImage != null) {
        request.files.addAll([
          await http.MultipartFile.fromPath(
              'vehicleLicense', _vehicleImage!.path,
              filename: 'vehicle.jpg'),
          await http.MultipartFile.fromPath('licenseImage', _licenseImage!.path,
              filename: 'licenseImage.jpg'),
          await http.MultipartFile.fromPath(
              'behindImageCCCD', _behindCCCDImage!.path,
              filename: 'behindCCCDImage.jpg'),
          await http.MultipartFile.fromPath(
              'frontImageCCCD', _frontCCCDImage!.path,
              filename: 'frontCCCDImage.jpg'),
        ]);

        var response =
            await request.send().timeout(const Duration(seconds: 20));

        if (response.statusCode == 200) {
          CustomeSnackBar.showSuccessSnackTopBar(
              context: Get.context, title: "Success", message: '');
          return true;
        } else {
          CustomeSnackBar.showErrorSnackBar(
              context: Get.context, title: "Error", message: '');
          return false;
        }
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context,
            title: "Error",
            message: 'Ảnh chưa đúng yêu cầu');
        return false;
      }
    } catch (e) {
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: "Error", message: e.toString());
      print(e);
      return false;
    }
  }

  registerShipperEmail2() async {
    try {
      var url = "${ApiEndPoints.baseUrl}/shipper";
      var header = {
        'Accept': 'application/json',
        'contentType': 'multipart/form-data',
      };

      final client = http.Client();

      if (_vehicleImage != null &&
          _behindCCCDImage != null &&
          _frontCCCDImage != null &&
          _licenseImage != null) {
        FormData formData = FormData({
          "firstName": firstnameController.text.trim(),
          "lastName": lastnameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "passwordConfirm": passwordConfirmController.text.trim(),
          "address": addressController.text.trim(),
          "phoneNumber": phoneController.text.trim(),
          "licenseNumber": licenseNumberController.text.trim(),
          "vehicleType": vehicleTypeController.text.trim(),
          "vehicleNumber": vehicleNumberController.text.trim(),
          "vehicleLicense":
              MultipartFile(_vehicleImage!.path, filename: 'vehicle.jpg'),
          "licenseImage":
              MultipartFile(_licenseImage!.path, filename: 'licenseImage.jpg'),
          "behindImageCCCD": MultipartFile(_behindCCCDImage!.path,
              filename: 'behindCCCDImage.jpg'),
          "frontImageCCCD": MultipartFile(_frontCCCDImage!.path,
              filename: 'frontCCCDImage.jpg'),
        });

        var response = await client
            .post(Uri.parse(url), body: formData, headers: header)
            .timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          CustomeSnackBar.showSuccessSnackTopBar(
              context: Get.context, title: "Success", message: '');
          return true;
        } else {
          CustomeSnackBar.showErrorSnackBar(
              context: Get.context, title: "Error", message: '');
          return false;
        }
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context,
            title: "Error",
            message: 'Ảnh chưa đúng yêu cầu');
        return false;
      }
    } catch (e) {
      // Get.back();
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: "Error", message: e.toString());
      print(e);
      return false;
    }
  }

  registerShipperEmail1() async {
    try {
      // var headers = {'Content-Type': 'application/json'};
      var url = "${ApiEndPoints.baseUrl}/shipper";

      if (_vehicleImage != null &&
          _behindCCCDImage != null &&
          _frontCCCDImage != null &&
          _licenseImage != null) {
        FormData formData = FormData({
          "firstName": firstnameController.text.trim(),
          "lastName": lastnameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "passwordConfirm": passwordConfirmController.text.trim(),
          "address": addressController.text.trim(),
          "phoneNumber": phoneController.text.trim(),
          "licenseNumber": licenseNumberController.text.trim(),
          "vehicleType": vehicleTypeController.text.trim(),
          "vehicleNumber": vehicleNumberController.text.trim(),
          // "vehicleLicense":
          //     MultipartFile(_vehicleImage!.path, filename: 'vehicle.jpg'),
          // "licenseImage":
          //     MultipartFile(_licenseImage!.path, filename: 'licenseImage.jpg'),
          // "behindImageCCCD": MultipartFile(_behindCCCDImage!.path,
          //     filename: 'behindCCCDImage.jpg'),
          // "frontImageCCCD": MultipartFile(_frontCCCDImage!.path,
          //     filename: 'frontCCCDImage.jpg'),
        });

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.files.add(await http.MultipartFile.fromPath(
            'vehicle.jpg', _vehicleImage!.path));
        request.files.add(await http.MultipartFile.fromPath(
            'licenseImage.jpg', _licenseImage!.path));
        request.files.add(await http.MultipartFile.fromPath(
            'behindCCCDImage.jpg', _behindCCCDImage!.path));
        request.files.add(await http.MultipartFile.fromPath(
            'frontCCCDImage.jpg', _frontCCCDImage!.path));

        request.fields.addEntries(formData.fields);

        var res = await request.send();

        if (res.statusCode == 200) {
          print("ok");
        }

        // var response = await http.post(Uri.parse(url), body: {
        //   "firstName": firstnameController.text.trim(),
        //   "lastName": lastnameController.text.trim(),
        //   "email": emailController.text.trim(),
        //   "password": passwordController.text.trim(),
        //   "passwordConfirm": passwordConfirmController.text.trim(),
        //   "address": addressController.text.trim(),
        //   "phoneNumber": phoneController.text.trim(),
        //   "licenseNumber": licenseNumberController.text.trim(),
        //   "vehicleType": vehicleTypeController.text.trim(),
        //   "vehicleNumber": vehicleNumberController.text.trim(),
        //   "vehicleLicense": http.MultipartFile(
        //     'file',
        //     _vehicleImage!.readAsBytes().asStream(),
        //     _vehicleImage!.lengthSync(),
        //     filename: 'licenseImage.jpg',
        //   ),
        //   // http.MultipartFile(_vehicleImage!.path, filename: 'vehicle.jpg'),
        //   "licenseImage": http.MultipartFile(
        //     'file',
        //     _licenseImage!.readAsBytes().asStream(),
        //     _licenseImage!.lengthSync(),
        //     filename: 'licenseImage.jpg',
        //   ),
        //   "behindImageCCCD": http.MultipartFile(
        //     'file',
        //     _behindCCCDImage!.readAsBytes().asStream(),
        //     _behindCCCDImage!.lengthSync(),
        //     filename: 'behindCCCDImage.jpg',
        //   ),
        //   "frontImageCCCD": http.MultipartFile(
        //     'file',
        //     _frontCCCDImage!.readAsBytes().asStream(),
        //     _frontCCCDImage!.lengthSync(),
        //     filename: 'frontCCCDImage.jpg',
        //   ),
        // }, headers: {
        //   'Accept': 'application/json',
        //   'contentType': 'multipart/form-data',
        // });

        // final json = jsonDecode(response.body);

        if (res.statusCode == 200) {
          CustomeSnackBar.showSuccessSnackTopBar(
              context: Get.context, title: "Success", message: '');
          return true;
        } else {
          CustomeSnackBar.showErrorSnackBar(
              context: Get.context, title: "Error", message: '');
          return false;
        }
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context,
            title: "Error",
            message: 'Ảnh chưa đúng yêu cầu');
        return false;
      }
    } catch (e) {
      // Get.back();
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: "Error", message: e.toString());
      print(e);
      return false;
    }
  }

  registerUserEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("${ApiEndPoints.baseUrl}/user");
      Map body = {
        "firstName": firstnameController.text.trim(),
        "lastName": lastnameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "passwordConfirm": passwordConfirmController.text.trim(),
        "address": addressController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
      };

      var response =
          await client.post(url, body: jsonEncode(body), headers: headers);
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (json['message'] == "Mã đã được gửi đến email!") {
          CustomeSnackBar.showSuccessSnackBar(
              context: Get.context, title: "Success", message: json['message']);
          return true;
        } else {
          CustomeSnackBar.showErrorSnackBar(
              context: Get.context, title: "Error", message: json['message']);
          return false;
        }
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context, title: "Error", message: '');
        return false;
      }
    } catch (e) {
      // Get.back();
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: "Error", message: e.toString());
      return false;
    }
  }

  verifyOtp(String otp, bool isUser) async {
    isLoading(true);
    try {
      var url = isUser
          ? Uri.parse(
              '${ApiEndPoints.baseUrl}/user/${emailController.text.trim()}')
          : Uri.parse(
              '${ApiEndPoints.baseUrl}/shipper/${emailController.text.trim()}');

      var body = {"signUpToken": otp.toString()};
      var response = await client.post(url, body: body);
      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CustomeSnackBar.showSuccessSnackBar(
            context: Get.context, title: 'Success', message: json['message']);

        onClose();
        return 'Success';
      } else {
        CustomeSnackBar.showErrorSnackBar(
            context: Get.context, title: "Error", message: json['message']);
        // return false;
        return 'Error';
      }
    } catch (e) {
      CustomeSnackBar.showErrorSnackBar(
          context: Get.context, title: "Error", message: e.toString());
      return 'Fail';
    } finally {
      isLoading(false);
    }
  }
}
