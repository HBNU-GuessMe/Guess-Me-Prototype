import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'shared_data.dart';
import 'auth_service.dart';

class ApiGet {
  final String _baseUrl = "http://3.35.87.49:8000";

  Future<String?> get accessToken async => await AuthService.getAccessToken();

  Future<void> requestQuestion(int familyId) async {
    final path = "family/today/question?familyId=$familyId";
    final uri = Uri.parse('$_baseUrl/$path');
    String? token = await accessToken;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedBody);
      print(jsonResponse);
      if (jsonResponse.containsKey('data')) {
        final data = jsonResponse['data'];
        if (data.containsKey('content')) {
          String question = data['content'];
          print('Question: $question');
          QuestionManager().setQuestion(question);
        } else {
          print('data 객체에 content가 없습니다.');
        }
        if (data.containsKey('questionId')) {
          int questionId = data['questionId'];
          print('QuestionId: $questionId');
          QuestionManager().setQuestionId(questionId);
        } else {
          print('data 객체에 questionId가 없습니다.');
        }
      } else {
        print('응답에 data 객체가 없습니다.');
      }
    } else {
      print("질문을 불러오지 못했습니다: ${response.statusCode}");
    }
  }

  Future<Response> checkFamilyCode(String familyCode) async {
    final path = "user/code/input/validate?code=$familyCode";
    final uri = Uri.parse('$_baseUrl/$path');
    String? token = await accessToken;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedBody);
      print(jsonResponse);
      if (jsonResponse.containsKey('data')) {
        final data = jsonResponse['data'];
        if (data.containsKey('isCodeConnected')) {
          bool isCodeConnected = data['isCodeConnected'];
          print('isCodeConnected: $isCodeConnected');
          FamilyManager().updateCodeConnected(isCodeConnected);
        } else {
          print('data 객체에 isCodeConnected가 없습니다.');
        }
      } else {
        print('응답에 data 객체가 없습니다.');
      }
    } else {
      print("질문을 불러오지 못했습니다: ${response.statusCode}");
    }

    return response;
  }

  Future<void> checkFamilyInfo(int familyId) async {
    final path = "family/info/$familyId";
    final uri = Uri.parse('$_baseUrl/$path');
    String? token = await accessToken;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedBody);

      final data = jsonResponse['data'];
      final users = data['users'];
      final count = data['count'];
      List<String> nicknames = [];
      List<int> userIds = [];

      for (var user in users) {
        nicknames.add(user['nickname']);
        userIds.add(user['userId']);
      }

      if (data.containsKey('familyCode')) {
        String ownerCode = data['familyCode'];
        print('familyCode: $ownerCode');
        FamilyManager().updateOwnerCode(ownerCode);
      } else {
        print('data 객체에 familyCode가 없습니다.');
      }

      print(nicknames);
      FamilyManager().updateFamilyList(nicknames, userIds, count);
    } else {
      print("Failed to fetch familyInfo: ${response.statusCode}");
    }
  }

  Future<String> requestUserCode() async {
    const path = "user/code";
    final uri = Uri.parse('$_baseUrl/$path');
    String? token = await accessToken;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedBody);
      print(jsonResponse);
      if (jsonResponse.containsKey('data')) {
        final data = jsonResponse['data'];
        if (data.containsKey('code')) {
          String fCode = data['code'];
          print('유저가 생성한 가족코드: $fCode');
          FamilyManager().updateFamilyCode(fCode);
          return fCode;
        } else {
          print('data 객체에 code가 없습니다.');
          return '';
        }
      } else {
        print('응답에 data 객체가 없습니다.');
        return '';
      }
    } else {
      print("Failed to fetch question: ${response.statusCode}");
      return '';
    }
  }

  // Future<String?> requestUserCode() async {
  //   final url = Uri.parse('https://41bb-221-158-131-160.ngrok-free.app/');
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final responseData = jsonDecode(response.body);
  //     String message = responseData['message'];
  //     FamilyManager().updateFamilyCode(message);
  //     return message;
  //   }
  //   return null;
  // }

  Future<void> requestFamilyId() async {
    const path = "user/info";
    final uri = Uri.parse('$_baseUrl/$path');
    String? token = await accessToken;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedBody);
      print(jsonResponse);
      if (jsonResponse.containsKey('data')) {
        final data = jsonResponse['data'];
        if (data.containsKey('familyId')) {
          int familyId = data['familyId'] ?? 1; // null 체크 및 기본값 0 할당
          print('가족아이디: $familyId');
          FamilyManager().updateFamilyId(familyId);
        } else {
          print('data 객체에 id가 없습니다.');
        }
      } else {
        print('응답에 data 객체가 없습니다.');
      }
    } else {
      print("Failed to fetch question: ${response.statusCode}");
    }
  }

  Future<void> requestFamilyAnswer(int questionId) async {
    //가족 전체 답변
    final path = "answer/getAll?questionId=$questionId";
    final uri = Uri.parse('$_baseUrl/$path');
    String? token = await accessToken;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedBody);

      final data = jsonResponse['data'];
      final answers = data['answers'];
      List<String> contents = [];
      List<int> userIds = [];

      for (var user in answers) {
        contents.add(user['content']);
        userIds.add(user['userId']);
      }

      QuestionManager().updateAnswerList(contents, userIds);
    } else {
      print("Failed to fetch question: ${response.statusCode}");
    }
  }

  Future<void> privateCommentQuestion(int questionId) async {
    final path = "comment/get?questionId=$questionId";
    final uri = Uri.parse('$_baseUrl/$path');
    String? token = await accessToken;
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedBody);
      print(jsonResponse);
      if (jsonResponse.containsKey('data')) {
        final data = jsonResponse['data'];
        if (data.containsKey('commentQuestionContent')) {
          String commentQuestionContent = data['commentQuestionContent'];
          print('1대1질문: $commentQuestionContent');
          //FamilyManager().;
        } else {
          print('data 객체에 commentQuestionContent가 없습니다.');
        }
      } else {
        print('응답에 data 객체가 없습니다.');
      }
    } else {
      print("Failed to fetch question: ${response.statusCode}");
    }
  }
}
