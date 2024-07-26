import 'package:flutter/material.dart';
import 'package:guessme/infoPosition.dart';
import 'package:guessme/kakao_login.dart';
import 'package:guessme/main_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final viewModel = MainViewModel(KakaoLogin());
  dynamic loginState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/GuessMe_happy_login.gif',
                  width: 300,
                  height: 300,
                ),
                Image.asset(
                  'assets/GuessMe_logo.png',
                  width: 300,
                  height: 510,
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                final result = await viewModel.login();
                // 비동기 작업이 완료된 후에 setState 호출
                if (mounted) {
                  setState(() {
                    loginState = result;
                  });

                  print('Login result: $loginState');
                  if (loginState) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isLoggedIn', true);
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PositionPage(),
                        ),
                      );
                    }
                  }
                }
              },
              child: Container(
                width: 280,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE617),
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/GuessMe_kakaologo.png',
                      width: 26,
                      height: 26,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '카카오로 3초만에 시작하기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await viewModel.logout();
            //     setState(() {
            //       print('Login result: $loginState');
            //     });
            //   },
            //   child: const Text('Logout'),
            // ),
          ],
        ),
      ),
    );
  }
}
