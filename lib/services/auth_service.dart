import 'package:atma_cinema/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<void> register(Map<String, dynamic> data) async {
    return await _api.post("register", data);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    final response = await _api.post("login", data);
    final jsonData = response as Map<String, dynamic>;

    if (jsonData.containsKey("token")) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", jsonData["token"]);
      await prefs.setString("userID", jsonData["userID"]);
      await prefs.setString("fullName", jsonData["fullName"]);
      await prefs.setString("email", jsonData["email"]);
    }

    return jsonData;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("token");
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token != null) {
      try {
        await _api.post(
          "logout",
          {},
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        );
      } catch (e) {
        print("Logout error: $e");
        throw Exception("Failed to logout from server");
      }
    }
    await prefs.remove("token");
    await prefs.remove("userID");
    await prefs.remove("fullName");
    await prefs.remove("email");
  }
}
