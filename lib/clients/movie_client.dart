import 'package:atma_cinema/models/movie_model.dart';
import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class MovieClient {
  final ApiService _api = ApiService();

  Future<List<dynamic>> fetchAllMovies() async {
    final AuthService auth = AuthService();
    final String? token = await auth.getToken();

    final response = await _api.get('movies/all', headers: {
      "Authorization": "Bearer $token",
    });

    return response;
  }

  Future<List<dynamic>> fetchUpcomingMovies() async {
    final AuthService auth = AuthService();
    final String? token = await auth.getToken();

    final response = await _api.get('movies/upcoming', headers: {
      "Authorization": "Bearer $token",
    });
    return response;
  }

  // Fetch now showing movie
  Future<List<dynamic>> fetchNowShowingMovies() async {
    final AuthService auth = AuthService();
    final String? token = await auth.getToken();

    final response = await _api.get('movies/now-showing', headers: {
      "Authorization": "Bearer $token",
    });
    return response;
  }
}
