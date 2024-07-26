import 'package:flutter/material.dart';
import 'package:guessme/infoGender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'common_appbar.dart';

class PositionPage extends StatefulWidget {
  const PositionPage({super.key});

  @override
  State<PositionPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  String selectedPosition = "";

  bool isPressed1 = false;
  bool isPressed2 = false;

  void showToast() {
    Fluttertoast.showToast(
        msg: "반드시 하나 선택해야 합니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<SharedData>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 246, 1),
      appBar: const CommonAppBar(
        showBackButton: false,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  '본인에게 해당하는 것을 선택해주세요!',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedPosition = '보호자';
                      setState(() {
                        isPressed1 = true;
                        isPressed2 = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPressed1
                          ? const Color.fromRGBO(248, 187, 208, 1)
                          : Colors.white,
                      padding: const EdgeInsets.all(5),
                    ),
                    child: Text(
                      '부모/보호자(보호하는 사람)',
                      style: TextStyle(
                        color: isPressed1 ? Colors.white : Colors.black,
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
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedPosition = '피보호자';
                      setState(() {
                        isPressed1 = false;
                        isPressed2 = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPressed2
                          ? const Color.fromRGBO(248, 187, 208, 1)
                          : Colors.white,
                      padding: const EdgeInsets.all(5),
                    ),
                    child: Text(
                      '자녀/피보호자(보호받는 사람)',
                      style: TextStyle(
                        color: isPressed2 ? Colors.white : Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 40,
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: () {
                if (!isPressed1 && !isPressed2) {
                  showToast();
                } else {
                  sharedData.updatePositionData(selectedPosition);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const GenderPage()));
                }
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '다음',
                    style: TextStyle(fontSize: 22.0),
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
