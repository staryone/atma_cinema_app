import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class MessageClient {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> createMessage(Map<String, dynamic> data) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    return await _api.post("messages", data, headers: {
      "Authorization": "Bearer $token",
    });
  }
}
