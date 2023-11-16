import 'package:pbl6_app/src/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthoRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthoRepo(this.apiClient, this.sharedPreferences);

  // AuthoRepo({required this.apiClient,})
}
