import 'package:flutter/material.dart';
import 'shared_data.dart';
import 'package:guessme/questNew.dart';

class AnswerReply extends StatefulWidget {
  const AnswerReply({super.key});

  @override
  State<AnswerReply> createState() => _AnswerReplyState();
}

class _AnswerReplyState extends State<AnswerReply> {
  String? question = "개별적으로 구체적이고, 심화된 질문";
  int? questionId = QuestionManager().questionId;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, String>> conversation = [
    {'nickname': '해피', 'message': '개별적으로 구체적이고, 심화된 질문'},
  ];

  bool hasAskedAnotherQuestion = false;

  void _handleSubmitted(String text) {
    _controller.clear();
    setState(() {
      conversation.add({'nickname': '나', 'message': text});
      if (!hasAskedAnotherQuestion) {
        conversation
            .add({'nickname': '해피', 'message': '또 다른 심화된 질문입니다. 답변 부탁드려요!'});
        hasAskedAnotherQuestion = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.black),
              onPressed: () {
                // Add your camera functionality here
              },
            ),
            IconButton(
              icon: const Icon(Icons.image, color: Colors.black),
              onPressed: () {
                // Add your gallery functionality here
              },
            ),
            Flexible(
              child: TextField(
                controller: _controller,
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: '댓글을 입력하세요'),
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.black),
                onPressed: () => _handleSubmitted(_controller.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text('댓글'),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: conversation.map((entry) {
                    return entry['nickname'] == '해피'
                        ? _buildQuestionContainer(
                            entry['nickname']!, entry['message']!)
                        : _buildAnswerContainer(
                            entry['nickname']!, entry['message']!);
                  }).toList(),
                ),
              ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildTextComposer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionContainer(String nickname, String question) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNicknameContainer(nickname, color: const Color(0xFFF8BBD0)),
          const SizedBox(height: 8),
          _buildMessageContainer(question,
              color: const Color(0xFFF8BBD0), width: 340),
        ],
      ),
    );
  }

  Widget _buildAnswerContainer(String nickname, String answer) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildNicknameContainer(nickname, color: const Color(0xFFFFF0F6)),
          const SizedBox(height: 8),
          _buildMessageContainer(answer,
              color: const Color(0xFFFFF0F6), width: 280),
        ],
      ),
    );
  }

  Widget _buildNicknameContainer(String nickname, {required Color color}) {
    return Container(
      padding: const EdgeInsets.all(6),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        nickname,
        style: const TextStyle(
          color: Color(0xFF111111),
          fontSize: 14,
          fontFamily: 'Pretendard JP',
          fontWeight: FontWeight.w600,
          letterSpacing: 0.20,
        ),
      ),
    );
  }

  Widget _buildMessageContainer(String message,
      {required Color color, required double width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFF161616),
          fontSize: 16,
          fontFamily: 'Pretendard JP',
          fontWeight: FontWeight.w400,
          letterSpacing: 0.09,
        ),
      ),
    );
  }
}
