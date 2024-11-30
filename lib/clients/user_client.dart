import 'package:atma_cinema/models/user_model.dart';
import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class UserClient {
  final ApiService _api = ApiService();

  Future<UserModel> getProfile(String? token) async {
    final response = await _api.get("profile", headers: {
      "Authorization": "Bearer $token",
    });
    return UserModel.fromJson(response);
  }
}
