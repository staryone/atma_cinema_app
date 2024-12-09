import 'dart:convert';
import 'dart:io';
import 'package:atma_cinema/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrlApi = baseUrl;

  Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
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

  Future<dynamic> patch(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrlApi/$endpoint');
    final response = await http.patch(
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

  Future<dynamic> put(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrlApi/$endpoint');
    final response = await http.put(
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

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrlApi/$endpoint');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        ...(headers ?? {}),
      },
    );
    return _processResponse(response);
  }

  Future<dynamic> postMultipart(String endpoint, Map<String, String> fields,
      {Map<String, String>? headers, File? file, String? fileFieldName}) async {
    final url = Uri.parse('$baseUrlApi/$endpoint');

    var request = http.MultipartRequest('POST', url);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    request.fields.addAll(fields);

    if (file != null && fileFieldName != null) {
      request.files.add(
        await http.MultipartFile.fromPath(fileFieldName, file.path),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('${response.body}');
    }
  }
}
