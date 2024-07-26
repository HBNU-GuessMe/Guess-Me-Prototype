import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guessme/conComplete.dart';
import 'common_appbar.dart';
import 'api_service_get.dart';
import 'shared_data.dart';

class FamilyList2 extends StatefulWidget {
  const FamilyList2({super.key});

  @override
  State<FamilyList2> createState() => _FamilyList2State();
}

class _FamilyList2State extends State<FamilyList2> {
  final ApiGet _apiGet = ApiGet();
  List<String> familyMembers = [];
  int? familyId;

  Timer? _timer;
  int _start = 15;

  @override
  void initState() {
    super.initState();
    fetchFamilyList();
    startTimer();
  }

  Future<void> fetchFamilyList() async {
    final familyId = FamilyManager().familyId;
    _apiGet.checkFamilyInfo(familyId!);
    final familyList = FamilyManager().familyList;
    setState(() {
      familyMembers = familyList;
    });
  }

  void startTimer() {
    _start = 1;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        setState(() {
          fetchFamilyList();
          _start = 15;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
              height: 30,
            ),
            const Text(
              '현재 연결된 가족을 확인하세요',
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '15초마다 새로고침 됩니다. $_start초',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: familyMembers.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      familyMembers[index],
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 300,
              height: 57,
              child: ElevatedButton(
                onPressed: () {
                  startTimer();
                  //카카오 로그인 구현 후 연결 가능
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(248, 187, 208, 1),
                  padding: const EdgeInsets.all(5),
                ),
                child: const Text(
                  '아직 연결 못한 가족이 있어요!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 57,
              child: ElevatedButton(
                onPressed: () {
                  _timer?.cancel();
                  familyId = FamilyManager().familyId;
                  //_apiGet.requestQuestion(familyId!);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ComCode()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(248, 187, 208, 1),
                  padding: const EdgeInsets.all(5),
                ),
                child: const Text(
                  '가족과 모두 연결되었어요!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
