import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:guessme/infoGomininput.dart';
import 'package:guessme/infoOutro.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'common_appbar.dart';

class GominPage extends StatefulWidget {
  const GominPage({super.key});

  @override
  State<GominPage> createState() => _GominPageState();
}

class _GominPageState extends State<GominPage> {
  late GroupButtonController _groupButtonController;
  List<String> gominList = [];
  int selectedCount = 0;

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
        children: <Widget>[
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
                        '요즘 고민거리를 선택해주세요!',
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
                      "가계경제",
                      "가정환경",
                      "건강",
                      "교우관계",
                      "대인관계",
                      "성",
                      "성격",
                      "외모",
                      "돈",
                      "음주",
                      "이성",
                      "인터넷 중독",
                      "진로",
                      "친구",
                      "학교폭력",
                      "학업",
                      "흡연",
                      "직접입력",
                    ],
                    isRadio: false,
                    controller: _groupButtonController,
                    onSelected: (value, index, isSelected) {
                      if (isSelected) {
                        if (index != 17) {
                          gominList.add(value);
                          print('ADD - $gominList');
                        }
                        selectedCount++;
                      } else {
                        if (index != 17) {
                          gominList.remove(value);
                          print('REMOVE - $gominList');
                        }
                        selectedCount--;
                      }
                    }),
              )
            ],
          ),
          Positioned(
            bottom: 100,
            right: 40,
            child: TextButton(
              onPressed: () {
                if (selectedCount > 5) {
                  selectedCount = 0;
                  deselectAllButtons();
                  showToast();
                } else if (selectedCount == 0) {
                  showZeroToast();
                } else if (selectedCount < 6 &&
                    _groupButtonController.selectedIndexes.contains(17)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GominInput(gominList: gominList)),
                  );
                } else if (selectedCount < 6 &&
                    !_groupButtonController.selectedIndexes.contains(17)) {
                  sharedData.updateGominData(gominList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InfoOutroPage()),
                  );
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor:
                    const Color.fromARGB(255, 255, 240, 246), // Text Color
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
      gominList.clear();
      print('CLEAR - $gominList');
    });
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: "고민거리는 5개까지 선택 가능합니다!",
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color.fromRGBO(100, 100, 100, 1),
    fontSize: 15,
  );
}

void showZeroToast() {
  Fluttertoast.showToast(
    msg: "고민거리를 1개 이상 선택해주세요!",
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color.fromRGBO(100, 100, 100, 1),
    fontSize: 15,
  );
}
