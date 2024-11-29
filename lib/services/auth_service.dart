import 'package:atma_cinema/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final ApiService _api = ApiService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<Map<String, dynamic>> loginWithGoogle(
      Map<String, dynamic> data) async {
    final response = await _api.post("auth/google/callback", data);
    final jsonData = response as Map<String, dynamic>;

    if (jsonData.containsKey("token")) {
      await _secureStorage.write(key: "token", value: jsonData["token"]);
      await _secureStorage.write(key: "userID", value: jsonData["userID"]);
    }

    return jsonData;
  }

  Future<void> register(Map<String, dynamic> data) async {
    return await _api.post("register", data);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    final response = await _api.post("login", data);
    final jsonData = response as Map<String, dynamic>;

    if (jsonData.containsKey("token")) {
      await _secureStorage.write(key: "token", value: jsonData["token"]);
      await _secureStorage.write(key: "userID", value: jsonData["userID"]);
    }

    return jsonData;
  }

  Future<bool> isLoggedIn() async {
    String? token = await _secureStorage.read(key: "token");
    return token != null;
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: "token");
  }

  Future<void> logout() async {
    final token = await getToken();
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }

    if (token != null) {
      try {
        await _api.post(
          "logout",
          {},
          headers: {
            "Authorization": "Bearer $token",
          },
        );
      } catch (e) {
        print("Logout error: $e");
        throw Exception("Failed to logout from server");
      }
    }
    await _secureStorage.delete(key: "token");
    await _secureStorage.delete(key: "userID");
  }
}
