import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class HistoryClient {
  final ApiService _api = ApiService();

  Future<List<dynamic>> fetchHistoryOrders() async {
    final AuthService auth = AuthService();
    final String? token = await auth.getToken();

    final response = await _api.get('histories', headers: {
      "Authorization": "Bearer $token",
    });
    return response;
  }

  Future<Map<String, dynamic>> createHistory(Map<String, dynamic> data) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    return await _api.post("histories", data, headers: {
      "Authorization": "Bearer $token",
    });
  }

  Future<Map<String, dynamic>> addReviewToHistory(
      Map<String, dynamic> data, String historyID) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    return await _api.post("histories/$historyID/add-review", data, headers: {
      "Authorization": "Bearer $token",
    });
  }
}
