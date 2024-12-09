import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class ScreeningClient {
  final ApiService _api = ApiService();

  Future<List<dynamic>> fetchScreeningByMovie(String movieID) async {
    final response = await _api.get('screenings/movie/$movieID');

    return response;
  }

  Future<dynamic> fetchScreeningById(String screeningID) async {
    final response = await _api.get('screenings/$screeningID');

    return response;
  }

  Future<dynamic> updateSeatLayout(
      String screeningID, List<String> seats, String status) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();
    final body = {
      'seats': seats,
      'status': status,
    };

    final response =
        await _api.put('screenings/$screeningID/seat-layout', body, headers: {
      "Authorization": "Bearer $token",
    });

    return response;
  }
}
