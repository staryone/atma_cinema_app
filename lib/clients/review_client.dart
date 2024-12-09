import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class ReviewClient {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> createReview(
      Map<String, dynamic> data, String movieID) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    return await _api.post("reviews/movie/$movieID", data, headers: {
      "Authorization": "Bearer $token",
    });
  }

  Future<List<dynamic>> getReviewByMovie(String movieID) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    return await _api.get("reviews/all/$movieID", headers: {
      "Authorization": "Bearer $token",
    });
  }
}
