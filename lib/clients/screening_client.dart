import 'package:atma_cinema/services/api_service.dart';

class ScreeningClient {
  final ApiService _api = ApiService();

  Future<List<dynamic>> fetchScreeningByMovie(String movieID) async {
    final response = await _api.get('screenings/movie/$movieID');

    return response;
  }
}
