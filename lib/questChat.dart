import 'package:flutter/material.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [
    {
      'nickname': '해피',
      'text':
          '쓔리쓔리걸님은 겨울에 필리핀 여행을 가고 싶군요!\n가족들과 함께하는 일본 여행은 어떠신가요?\n속마음 토크를 통해 알려주세요 ><'
    }
  ];
  final TextEditingController _controller = TextEditingController();
  Timer? _timer1;
  Timer? _timer2;

  void _handleSubmitted(String text) {
    _controller.clear();
    setState(() {
      _messages.add({'nickname': '나', 'text': text});
    });

    _startResponseTimers();
  }

  void _startResponseTimers() {
    _timer1?.cancel();
    _timer2?.cancel();

    _timer1 = Timer(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'nickname': '맘',
            'text':
                '오, 일본 여행이라니!\t 예전부터 가고 싶다고 했잖아.\n가서 맛있는 것도 먹고, 예쁜 곳도 많이 다니자!'
          });
        });
      }

      _timer2 = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _messages.add({
              'nickname': '대디',
              'text': '일본 여행 좋지. 나도 오랜만에 가고 싶네.\n그럼 우리 다 같이 계획해볼까?'
            });
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer1?.cancel();
    _timer2?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['nickname'] == '나';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message['nickname']!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: isUser
                    ? const Color.fromRGBO(202, 236, 255, 1)
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: isUser
                      ? const Radius.circular(20.0)
                      : const Radius.circular(0),
                  topRight: isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(20.0),
                  bottomLeft: const Radius.circular(20.0),
                  bottomRight: const Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.70,
              ),
              child: Text(
                message['text']!,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
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
                decoration: const InputDecoration.collapsed(hintText: '메시지 입력'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5F3FF),
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '쓔리쓔리걸네 가족',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xFFE5F3FF),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int index) => _buildMessage(_messages[index]),
              itemCount: _messages.length,
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
    );
  }
}
