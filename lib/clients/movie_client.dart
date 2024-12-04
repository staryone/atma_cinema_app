import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class MovieClient {
  final ApiService _api = ApiService();

  Future<List<dynamic>> fetchAllMovies() async {
    // final AuthService auth = AuthService();
    // final String? token = await auth.getToken();

    final response = await _api.get('movies/all');

    return response;
  }

  Future<List<dynamic>> fetchUpcomingMovies() async {
    // final AuthService auth = AuthService();
    // final String? token = await auth.getToken();

    final response = await _api.get('movies/upcoming');
    return response;
  }

  // Fetch now showing movie
  Future<List<dynamic>> fetchNowShowingMovies() async {
    // final AuthService auth = AuthService();
    // final String? token = await auth.getToken();

    final response = await _api.get('movies/now-showing');
    return response;
  }

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await _api.get('movies/search?query=$query');
    return response;
  }
}
