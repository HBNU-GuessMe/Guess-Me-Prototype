import 'package:flutter/material.dart';
import 'package:guessme/conGenerator.dart';
import 'common_appbar.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'api_service_post.dart';
import 'auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoOutroPage extends StatefulWidget {
  const InfoOutroPage({super.key});

  @override
  State<InfoOutroPage> createState() => _InfoOutroPageState();
}

class _InfoOutroPageState extends State<InfoOutroPage> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<SharedData>(context);
    String? newToken = AccessTokenManager().accessToken;
    String role = sharedData.positionData;
    String nickname = sharedData.nicknameData;
    String gender = sharedData.genderData;
    String birth = sharedData.birthdayData;
    List<String?> interest = sharedData.interestData;
    List<String?> gomin = sharedData.gominData;

    String? interestString = interest.where((item) => item != null).isNotEmpty
        ? interest.where((item) => item != null).join(',')
        : null;
    String? gominString = gomin.where((item) => item != null).isNotEmpty
        ? gomin.where((item) => item != null).join(',')
        : null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(backgroundColor: Colors.white),
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/GuessMe_talkBox.jpg',
                        fit: BoxFit.contain,
                      ),
                      const Positioned(
                        top: 95,
                        left: 20,
                        right: 20,
                        child: Text(
                          '답변을 완료해주셔서 감사해요!\n이제 저 해피가 질문을\n잘 만들어낼 수 있을거에요!\n이제 가족과 연결하고,\n해피의 질문을 받으러 가볼까요?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: Image.asset('assets/GuessMe_happy_Complete.gif'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 40,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () async {
                if (newToken != null) {
                  AuthService.saveAccessToken(newToken);
                  _apiService.sendUserInfoToServer(
                      role, nickname, gender, birth);
                  _apiService.sendUserInfo2ToServer(
                      interestString, gominString);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('hasProfile', true);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GenCode()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('토큰을 가져오는데 실패했습니다. 다시 시도해주세요.')),
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GenCode()));
                }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '가족 연결하러 가기',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
