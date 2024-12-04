import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class TicketClient {
  final ApiService _api = ApiService();

  Future<List<dynamic>> fetchActiveOrders() async {
    final AuthService auth = AuthService();
    final String? token = await auth.getToken();

    final response = await _api.get('tickets/active', headers: {
      "Authorization": "Bearer $token",
    });
    return response;
  }

  Future<Map<String, dynamic>> createTicket(Map<String, dynamic> data) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    return await _api.post("tickets/create", data, headers: {
      "Authorization": "Bearer $token",
    });
  }
}
