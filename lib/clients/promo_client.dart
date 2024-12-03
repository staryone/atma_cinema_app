import 'package:atma_cinema/services/api_service.dart';

class PromoClient {
  final ApiService _api = ApiService();

  Future<List<dynamic>> fetchFnbPromos() async {
    // final AuthService auth = AuthService();
    // final String? token = await auth.getToken();

    final response = await _api.get('promos/fnb');

    return response;
  }

  Future<List<dynamic>> fetchGeneralPromos() async {
    // final AuthService auth = AuthService();
    // final String? token = await auth.getToken();

    final response = await _api.get('promos/general');

    return response;
  }
}
