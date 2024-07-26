import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  //final String _baseUrl = "http://43.202.246.248:8000";
  final String _baseUrl = "http://3.35.87.49:8000";

  Future<String?> get accessToken async => await AuthService.getAccessToken();

  Future<void> _sendRequestToServer({
    required String path,
    required Map<String, dynamic> body,
    required String functionName,
  }) async {
    String? token = await accessToken;
    try {
      var response = await http.post(
        Uri.parse('$_baseUrl/$path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        print('$functionName: Data successfully sent to the server');
      } else {
        print(
            '$functionName: Failed to send data to the server: ${response.statusCode}');
      }
    } catch (e) {
      print('$functionName: Error sending data to the server: $e');
    }
  }

  Future<void> sendUserInfoToServer(
      String role, String nickname, String gender, String birth) async {
    await _sendRequestToServer(
      path: 'user/info/register',
      body: {
        'role': role,
        'nickname': nickname,
        'gender': gender,
        'birth': birth,
      },
      functionName: 'sendUserInfoToServer',
    );
  }

  Future<void> sendUserInfo2ToServer(String? interest, String? gomin) async {
    await _sendRequestToServer(
      path: 'user/concern/info/register',
      body: {
        'interest': interest,
        'worry': gomin,
      },
      functionName: 'sendUserInfo2ToServer',
    );
  }

  Future<void> sendOwnerConnectionToServer(
      String? code, List<int?> family) async {
    await _sendRequestToServer(
      path: 'family/owner/connection',
      body: {
        'code': code,
        'userIds': family,
      },
      functionName: 'sendOwnerConnectionToServer',
    );
  }

  Future<void> sendConnectionToServer(String? code) async {
    await _sendRequestToServer(
      path: 'family/connection',
      body: {
        'code': code,
      },
      functionName: 'sendConnectionToServer',
    );
  }

  Future<void> createQuestionToServer() async {
    await _sendRequestToServer(
      path: 'family/question/create',
      body: {},
      functionName: 'createQuestionToServer',
    );
  }

  Future<void> sendAnswerToServer(int? questionId, String content) async {
    await _sendRequestToServer(
      path: 'answer/register',
      body: {
        'questionId': questionId,
        'content': content,
      },
      functionName: 'sendAnswerToServer',
    );
  }
}
