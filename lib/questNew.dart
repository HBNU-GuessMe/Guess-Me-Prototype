import 'package:flutter/material.dart';
import 'package:guessme/questAnswer.dart';
import 'package:guessme/questChat.dart';
import 'package:guessme/questMypage.dart';
import 'package:guessme/questReport.dart';
import 'package:guessme/questReply.dart';
import 'shared_data.dart';
import 'package:provider/provider.dart';
import 'api_service_get.dart';

class NewQuest extends StatefulWidget {
  const NewQuest({super.key});

  @override
  State<NewQuest> createState() => _NewQuestState();
}

class _NewQuestState extends State<NewQuest> {
  final ApiGet _apiGet = ApiGet();
  int? familyId;
  var _index = 0;
  List<Map<String, dynamic>> answerList = [
    {
      "type": "question",
      "content": "질문을 불러오지 못했습니다.",
    },
    {
      "type": "myAnswer",
      "username": "username1",
      "answer": "답변을 입력해주세요.",
    },
  ];

  @override
  void initState() {
    super.initState();
    updateQuestionContent();
    familyId = FamilyManager().familyId;
    _apiGet.requestQuestion(familyId!);
  }

  void updateQuestionContent() {
    String? question = QuestionManager().question;
    answerList[0]["content"] = question;
    print('Updated content: ${answerList[0]["content"]}'); // 콘솔에 출력
  }

  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<SharedData>(context);
    String myAnswer = sharedData.myanswerData;
    String myNickname = sharedData.nicknameData;

    if (myAnswer == "답변을 입력해주세요.") {
      for (var i = 0; i < answerList.length; i++) {
        if (answerList[i]["type"] == "memberAnswer") {
          answerList[i]["answer"] = "답변을 입력해주세요.";
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _index,
        children: [
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 230,
                  child: Image.asset(myAnswer != "답변을 입력해주세요."
                      ? 'assets/GuessMe_question3.gif'
                      : 'assets/GuessMe_question1.gif'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: answerList.length,
                    itemBuilder: (BuildContext con, int index) {
                      final item = answerList[index];
                      switch (item["type"]) {
                        case "question":
                          return questionContainer(item["content"] as String);
                        case "myAnswer":
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AnswerQuest()));
                            },
                            child: Column(
                              children: [
                                answerContainer(
                                  username: myNickname,
                                  answer: myAnswer,
                                  isMyAnswer: true,
                                ),
                                Visibility(
                                  visible:
                                      _index == 0 && myAnswer != "답변을 입력해주세요.",
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const AnswerReply()));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/GuessMe_replyButton.png',
                                              width: 20,
                                              height: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            const Text(
                                              '해피의 1:1 댓글 보기',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 14.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        case "memberAnswer":
                          return answerContainer(
                            username: item["username"] as String,
                            answer: item["answer"] as String,
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          const ReportPage(),
          const OptionPage(),
        ],
      ),
      floatingActionButton: _index == 0 && myAnswer != "답변을 입력해주세요."
          ? Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatScreen()),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/chat_floatingBtn.png'),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
              ),
            )
          : null,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: SizedBox(
          height: kBottomNavigationBarHeight * 2.2,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            currentIndex: _index,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/GuessMe_bottomBar11.png"),
                  size: 55.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/GuessMe_bottomBar21.png"),
                  size: 55.0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/GuessMe_bottomBar31.png"),
                  size: 55.0,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionContainer(String question) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 355,
            padding: const EdgeInsets.all(24),
            decoration: ShapeDecoration(
              color: const Color(0xFFF8BBD0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Pretendard JP',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget answerContainer(
      {String username = '', String answer = '', bool isMyAnswer = false}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 355,
            padding: const EdgeInsets.all(24),
            decoration: ShapeDecoration(
              color: const Color(0xFFFFF0F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Text(
                  answer,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 16,
                    fontFamily: 'Pretendard JP',
                    fontWeight: FontWeight.w400,
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
