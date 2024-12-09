import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class PaymentClient {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> createPayment(
      Map<String, dynamic> paymentData) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();
    final response = await _api.post('payments', paymentData, headers: {
      "Authorization": "Bearer $token",
    });
    return response;
  }

  Future<dynamic> getPaymentById(String id) async {
    final response = await _api.get('payments/$id');
    return response;
  }

  Future<dynamic> editStatusPayment(String id, String paymentStatus) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();
    final response = await _api.patch('payments/$id/status', {
      'paymentStatus': paymentStatus,
    }, headers: {
      "Authorization": "Bearer $token",
    });

    return response;
  }
}
