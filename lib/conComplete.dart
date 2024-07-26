import 'package:flutter/material.dart';
import 'package:guessme/questNew.dart';
import 'common_appbar.dart';
// import 'api_service_post.dart';
import 'shared_data.dart';

class ComCode extends StatefulWidget {
  const ComCode({super.key});

  @override
  State<ComCode> createState() => _ComCodeState();
}

class _ComCodeState extends State<ComCode> {
  //final ApiService _apiService = ApiService();
  int? familyId;

  // @override
  // void initState() {
  //   super.initState();
  //   _apiService.createQuestionToServer();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(backgroundColor: Colors.white),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
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
                        top: 106,
                        left: 20,
                        right: 20,
                        child: Text(
                          '환영해요!\n이제 연결된 가족과 함께\n해피가 주는 질문에 답하며\n행복한 대화 나누어 보세요 :)',
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
                  child: Image.asset('assets/GuessMe_happy_smile.gif'),
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
                String? question = QuestionManager().question;
                QuestionManager().updateCurrentQuestion(question!);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const NewQuest()));
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '질문 받으러 가기',
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
