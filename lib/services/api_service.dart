import 'dart:convert';
import 'package:atma_cinema/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrlApi = baseUrl;

  Future<dynamic> post(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrlApi/$endpoint');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        ...(headers ?? {}),
      },
      body: jsonEncode(body),
    );
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.body}');
    }
  }
}
