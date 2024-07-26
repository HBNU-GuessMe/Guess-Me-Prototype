import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:guessme/conInput.dart';
import 'package:guessme/conList.dart';
import 'package:guessme/shared_data.dart';
import 'common_appbar.dart';
import 'api_service_get.dart';

class GenCode extends StatefulWidget {
  const GenCode({super.key});

  @override
  State<GenCode> createState() => _GenCodeState();
}

class _GenCodeState extends State<GenCode> {
  String _newcode = '';
  final ApiGet _apiGet = ApiGet();

  @override
  void initState() {
    super.initState();
    _fetchUserCode();
  }

  Future<void> _fetchUserCode() async {
    String newcode = await _apiGet.requestUserCode();
    setState(() {
      _newcode = newcode;
      FamilyManager().updateFamilyCode(newcode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 246, 1),
      appBar: const CommonAppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              '가족을 연결하고\n행복한 대화를 시작해보세요.',
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 150,
            ),
            const Text(
              '나의 코드 복사하기!',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              width: 200,
              height: 45,
              child: TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _newcode));
                  showToast();
                },
                child: Text(
                  _newcode,
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            SizedBox(
              width: 270,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  await _apiGet.requestFamilyId();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FamilyList()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(248, 187, 208, 1),
                  padding: const EdgeInsets.all(5),
                ),
                child: const Text(
                  '연결된 가족 보러가기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 270,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const InsCode()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(248, 187, 208, 1),
                  padding: const EdgeInsets.all(5),
                ),
                child: const Text(
                  '가족의 코드로 연결하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: '나의 코드가 복사되었습니다!\n가족에게 초대장을 보내보세요!',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 18,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
