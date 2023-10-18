import 'dart:convert';

import 'package:get/get.dart';
import 'package:pbl6_app/src/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  UserModel getDefaultUser() {
    return UserModel(
        role: 'User',
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        contact: []);
  }

  Future<String> getId() async {
    final SharedPreferences prefs = await _prefs;
    var id = prefs.getString('id_user') ?? '';
    return id;
  }

  Future<UserModel> getInfoUserById(String id) async {
    UserModel user;
    try {
      // String id = await idF;
      var url = Uri.parse("${ApiEndPoints.baseUrl}/user/$id");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Map<String, dynamic> userJson = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(jsonDecode(response.body));
        print(user);

        return user;
      } else {
        user = getUserDefault();
        return user;
      }
    } catch (e) {
      user = getUserDefault();
      return user;
    }
  }
}
