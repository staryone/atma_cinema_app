import 'package:atma_cinema/services/api_service.dart';

class FnbClient {
  final ApiService _api = ApiService();

  Future<List<dynamic>> fetchAllFnbs(String category) async {
    // final AuthService auth = AuthService();
    // final String? token = await auth.getToken();

    final response = await _api.get('fnbs/$category');

    return response;
  }
}
