import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guessme/infoGomin.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'common_appbar.dart';

class InterestInput extends StatefulWidget {
  final List<String> interestList;
  const InterestInput({super.key, required this.interestList});

  @override
  State<InterestInput> createState() => _InterestInputState();
}

class _InterestInputState extends State<InterestInput> {
  final TextEditingController _controller = TextEditingController();
  String interestText = '';
  bool usedInput = false;
  late List<String> interestList;

  @override
  void initState() {
    super.initState();
    interestList = List.from(widget.interestList);
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
                        '관심사를 단어로 입력해주세요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '1개만 입력 가능합니다.',
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
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: TextFormField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: '관심사 입력하기',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[a-z A-Z ㄱ-ㅎ|가-힣|·|：]'),
                    ),
                  ],
                  onChanged: (text) {
                    setState(() {
                      interestText = text;
                    });
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 100,
            right: 40,
            child: TextButton(
              onPressed: () {
                if (interestText != '' && usedInput == false) {
                  print('Interest Text: $interestText');
                  interestList.add(interestText);
                  print('Interest List: $interestList');
                  usedInput = true;
                  sharedData.updateInterestData(interestList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GominPage()),
                  );
                } else if (interestText != '' && usedInput == true) {
                  print('Interest Text: $interestText');
                  interestList.removeLast();
                  interestList.add(interestText);
                  print('Interest List: $interestList');
                } else {
                  showToast();
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 240, 246),
                elevation: 0,
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
}

void showToast() {
  Fluttertoast.showToast(
    msg: "관심사를 입력해주세요!",
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color.fromRGBO(100, 100, 100, 1),
    fontSize: 15,
  );
}
