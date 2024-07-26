import 'dart:convert';
import 'package:guessme/kakao_login_sub.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'shared_data.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;
  String? accessToken;

  MainViewModel(this._socialLogin);

  Future<bool> login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      try {
        user = await UserApi.instance.me();
        print(user?.id);
        sendUserId(user?.id.toString());
      } catch (e) {
        print('User 정보를 가져오는데 실패했습니다: $e');
        isLogined = false;
        user = null;
      }
    }
    return isLogined;
  }

  Future<void> logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }

  Future<void> sendUserId(id) async {
    const url = "http://3.35.87.49:8000/oauth/kakao/token/create";
    final uri = Uri.parse(url);
    final body = jsonEncode({'snsId': id});
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse.containsKey('data')) {
        final data = jsonResponse['data'];
        if (data.containsKey('userId')) {
          int userId = data['userId'];
          print('userId: $userId');
          UserIdManager().setUserId(userId);
        } else {
          print('data 객체에 userId가 없습니다.');
        }
        if (data.containsKey('accessToken')) {
          accessToken = data['accessToken'];
          print('accessToken: $accessToken');
          AccessTokenManager().setAccessToken(accessToken!);
        } else {
          print('data 객체에 accessToken이 없습니다.');
        }
      } else {
        print('응답에 data 객체가 없습니다.');
      }
    } else {
      print("Failed to send user ID: ${response.statusCode}");
    }
  }
}
