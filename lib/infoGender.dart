import 'package:flutter/material.dart';
import 'package:guessme/infoBirthday.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'common_appbar.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String selectedGender = "";

  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isPressed3 = false;

  void showToast() {
    Fluttertoast.showToast(
        msg: "성별을 하나 선택해야 합니다.",
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
      appBar: const CommonAppBar(),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  '성별을 선택해주세요!',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 120,
                ),
                SizedBox(
                  width: 92,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedGender = '여';
                      setState(() {
                        isPressed1 = true;
                        isPressed2 = false;
                        isPressed3 = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPressed1
                          ? const Color.fromRGBO(248, 187, 208, 1)
                          : Colors.white,
                      padding: const EdgeInsets.all(5),
                    ),
                    child: Text(
                      '여자',
                      style: TextStyle(
                        color: isPressed1 ? Colors.white : Colors.black,
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 92,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedGender = '남';
                      setState(() {
                        isPressed1 = false;
                        isPressed2 = true;
                        isPressed3 = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPressed2
                          ? const Color.fromRGBO(248, 187, 208, 1)
                          : Colors.white,
                      padding: const EdgeInsets.all(5),
                    ),
                    child: Text(
                      '남자',
                      style: TextStyle(
                        color: isPressed2 ? Colors.white : Colors.black,
                        fontSize: 19.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 92,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedGender = '기타';
                      setState(() {
                        isPressed1 = false;
                        isPressed2 = false;
                        isPressed3 = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPressed3
                          ? const Color.fromRGBO(248, 187, 208, 1)
                          : Colors.white,
                      padding: const EdgeInsets.all(5),
                    ),
                    child: Text(
                      '기타',
                      style: TextStyle(
                        color: isPressed3 ? Colors.white : Colors.black,
                        fontSize: 19.0,
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
                if (isPressed1 || isPressed2 || isPressed3) {
                  sharedData.updateGenderData(selectedGender);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const BirthdayPage()));
                } else {
                  showToast();
                }
              },
              child: const Row(
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
