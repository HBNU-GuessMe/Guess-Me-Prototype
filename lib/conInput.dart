import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guessme/conList.dart';
import 'common_appbar.dart';
import 'api_service_get.dart';

class InsCode extends StatefulWidget {
  const InsCode({super.key});

  @override
  State<InsCode> createState() => _InsCodeState();
}

class _InsCodeState extends State<InsCode> {
  final ApiGet _apiGet = ApiGet();
  String selectedFamilyCode = "";
  final _contentEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentEditController.addListener(() {
      selectedFamilyCode = _contentEditController.text;
    });
  }

  @override
  void dispose() {
    _contentEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 246, 1),
      appBar: const CommonAppBar(),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 119,
          ),
          const Text(
            '가족의 코드를 입력해주세요!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.5,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 80.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 100, 100, 150),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-z A-Z 0-9]'),
                      ),
                    ],
                    textAlign: TextAlign.center,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: '코드 입력하기',
                    ),
                    keyboardType: TextInputType.name,
                    controller: _contentEditController,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
            child: ElevatedButton(
              onPressed: () async {
                if (selectedFamilyCode.length != 10) {
                  showToast('코드는 10자리여야 합니다.');
                  return;
                }

                final response =
                    await _apiGet.checkFamilyCode(selectedFamilyCode);
                if (response.statusCode == 200) {
                  showToast('가족 연결중입니다.\n다음페이지에서 연결을 확인하세요.');
                  await _apiGet.requestFamilyId();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FamilyList()));
                } else {
                  showToast('가족코드를 연결할 수 없어요. 코드를 확인해주세요.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(248, 187, 208, 1),
                padding: const EdgeInsets.all(5),
              ),
              child: const Text(
                '가족과 연결하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 18,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
