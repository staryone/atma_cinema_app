import 'dart:io';

import 'package:atma_cinema/models/user_model.dart';
import 'package:atma_cinema/services/api_service.dart';
import 'package:atma_cinema/services/auth_service.dart';

class UserClient {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> getProfile() async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    final response = await _api.get("profile", headers: {
      "Authorization": "Bearer $token",
    });
    return response;
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    final fields = <String, String>{
      'fullName': data['fullName'] ?? '',
      'email': data['email'] ?? '',
      'dateOfBirth': data['dateOfBirth'] ?? '',
      'gender': data['gender'] ?? '',
      'phoneNumber': data['phoneNumber'] ?? '',
    };

    final File? file = data['profilePicture'] as File?;

    if (file != null) {
      return await _api.postMultipart(
        "profile/update",
        fields,
        headers: {
          "Authorization": "Bearer $token",
        },
        file: file,
        fileFieldName: 'profilePicture',
      );
    }

    return await _api.post("profile/update", data, headers: {
      "Authorization": "Bearer $token",
    });
  }

  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    final AuthService _auth = AuthService();
    final String? token = await _auth.getToken();

    return await _api.post("profile/change-password", data, headers: {
      "Authorization": "Bearer $token",
    });
  }
}
