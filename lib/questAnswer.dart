import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'api_service_post.dart';
import 'package:guessme/questNew.dart';

class AnswerQuest extends StatefulWidget {
  const AnswerQuest({super.key});

  @override
  State<AnswerQuest> createState() => _AnswerQuestState();
}

class _AnswerQuestState extends State<AnswerQuest> {
  final ApiService _apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  String _answer = '';
  //String? question = QuestionManager().question;
  String? question = "쓔리쓔리걸, 여행을 좋아하는데, 다음 목적지로 생각 중인 곳이 어디인지 말해줘.";
  int? questionId = QuestionManager().questionId;

  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<SharedData>(context);
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NewQuest()),
            (Route<dynamic> route) => false,
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(''),
            elevation: 0.0,
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 355,
                    minHeight: 70,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF8BBD0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Text(
                        question ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Pretendard JP',
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  height: 200,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    maxLength: 150,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: '답변을 입력해주세요.(최대 100자 입력 가능)',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(255, 240, 246, 1),
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 280,
                      ),
                      SizedBox(
                        width: 92,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _answer = _controller.text;
                                sharedData.updateMyAnswerData(_answer);
                              });
                              _apiService.sendAnswerToServer(
                                  questionId, _answer);
                              showToast();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(248, 187, 208, 1),
                              padding: const EdgeInsets.all(5),
                            ),
                            child: const Text(
                              '답변 완료',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard JP',
                                fontWeight: FontWeight.w400,
                                height: 0.09,
                                letterSpacing: 0.09,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: '답변이 기록되었어요.',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 18,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
