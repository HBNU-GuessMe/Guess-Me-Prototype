import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guessme/infoInterest.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'common_appbar.dart';

class NicknamePage extends StatefulWidget {
  const NicknamePage({super.key});

  @override
  State<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  String selectedNickname = "";
  final _contentEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentEditController.addListener(() {
      final text = _contentEditController.text;
      selectedNickname = _contentEditController.text;
      if (text.length == 10) {
        Fluttertoast.showToast(
          msg: "10자를 초과하였습니다!",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          fontSize: 18,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    });
  }

  @override
  void dispose() {
    _contentEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<SharedData>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 246, 1),
      appBar: const CommonAppBar(),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              const SizedBox(
                height: 119,
              ),
              const Text(
                '가족에게 불리는 호칭을 입력해주세요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 3.0,
              ),
              const Text(
                '한글, 영어, 숫자로 최대 10자까지 가능합니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              Padding(
                padding: const EdgeInsets.all(100.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-z A-Z ㄱ-ㅎ|가-힣|·|：]'),
                          ),
                        ],
                        textAlign: TextAlign.center,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: '호칭 입력하기',
                        ),
                        keyboardType: TextInputType.name,
                        controller: _contentEditController,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
            ],
          ),
          Positioned(
            bottom: 100,
            right: 40,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                if (_contentEditController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "한 글자 이상 입력해야 합니다!",
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.grey,
                    fontSize: 18,
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else {
                  sharedData.updateNicknameData(selectedNickname);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const InterestPage()));
                }
              },
              child: const Row(
                children: [
                  Text(
                    '다음',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
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
