import 'dart:convert';
import 'package:pbl6_app/src/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FuncUseful {
  static Future saveJson(String key, json) async {
    final prefs = await SharedPreferences.getInstance();
    var saveJson = jsonEncode(json);
    print(saveJson);
    await prefs.setString(key, saveJson);
  }

  static Future getDataJson(String key) async {
    final pref = await SharedPreferences.getInstance();
    var temp = pref.getString(key) ?? "nodata";
    // var data = UserModel.fromMap(jsonDecode(temp.toString()));
    var data = jsonDecode(temp.toString());

    return data;
  }
}
