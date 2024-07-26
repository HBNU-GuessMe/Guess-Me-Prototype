import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:guessme/infoGomin.dart';
import 'package:guessme/infoInterestinput.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'common_appbar.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  late GroupButtonController _groupButtonController;
  int selectedCount = 0;
  List<String> interestList = [];

  @override
  void initState() {
    _groupButtonController = GroupButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<SharedData>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 246, 1),
      appBar: const CommonAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '관심사를 선택해주세요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '5개까지 선택 가능합니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: 333,
                child: GroupButton(
                    options: GroupButtonOptions(
                      borderRadius: BorderRadius.circular(25),
                      selectedColor: Colors.pink[100],
                      elevation: 3,
                      unselectedColor: Colors.white,
                      buttonHeight: 48,
                      textPadding: const EdgeInsets.all(15.0),
                    ),
                    buttons: const [
                      "국제정세",
                      "건강",
                      "과학",
                      "게임",
                      "다큐멘터리",
                      "독서",
                      "동물",
                      "댄스",
                      "드라마",
                      "뷰티",
                      "스포츠",
                      "언어",
                      "애니메이션 및 만화",
                      "여행",
                      "영화",
                      "예능",
                      "예술",
                      "음식",
                      "음악",
                      "자동차",
                      "자연",
                      "패션",
                      "헬스",
                      "ASMR",
                      "DIY",
                      "직접 입력"
                    ],
                    isRadio: false,
                    controller: _groupButtonController,
                    onSelected: (value, index, isSelected) {
                      if (isSelected) {
                        if (index != 25) {
                          interestList.add(value);
                          print('ADD - $interestList');
                        }
                        selectedCount++;
                      } else {
                        if (index != 25) {
                          interestList.remove(value);
                          print('REMOVE - $interestList');
                        }
                        selectedCount--;
                      }
                    }),
              )
            ],
          ),
          Positioned(
            right: 40,
            bottom: 100,
            child: TextButton(
              onPressed: () {
                if (selectedCount > 5) {
                  selectedCount = 0;
                  deselectAllButtons();
                  showToast();
                } else if (selectedCount == 0) {
                  showZeroToast();
                } else if (selectedCount < 6 &&
                    _groupButtonController.selectedIndexes.contains(25)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            InterestInput(interestList: interestList)),
                  );
                } else if (selectedCount < 6 &&
                    !_groupButtonController.selectedIndexes.contains(25)) {
                  sharedData.updateInterestData(interestList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GominPage()),
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color.fromARGB(255, 255, 240, 246),
              ),
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

  void deselectAllButtons() {
    _groupButtonController.selectedIndexes.clear();
    setState(() {
      interestList.clear();
      print('CLEAR - $interestList');
    });
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: "관심사는 5개까지 선택 가능합니다!",
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color.fromRGBO(100, 100, 100, 1),
    fontSize: 15,
  );
}

void showZeroToast() {
  Fluttertoast.showToast(
    msg: "관심사를 1개 이상 선택해주세요!",
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color.fromRGBO(100, 100, 100, 1),
    fontSize: 15,
  );
}
