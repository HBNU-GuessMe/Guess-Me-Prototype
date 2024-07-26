import 'package:flutter/material.dart';
import 'package:guessme/preLogin.dart';
import 'package:guessme/main_view_model.dart';
import 'package:guessme/kakao_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = MainViewModel(KakaoLogin());
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20),
            child: Text(
              '마이페이지                                 ',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 150.0),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () async {
              await viewModel.logout();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', false);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LoginPage()));
            },
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    '로그아웃',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 26.0,
                    color: Color.fromRGBO(248, 187, 208, 1.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () {},
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    '회원 정보 수정',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 26.0,
                    color: Color.fromRGBO(248, 187, 208, 1.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () {},
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    '문의하기',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 26.0,
                    color: Color.fromRGBO(248, 187, 208, 1.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () {},
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    '가족 관리',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 26.0,
                    color: Color.fromRGBO(248, 187, 208, 1.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
