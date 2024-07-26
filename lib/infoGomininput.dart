import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guessme/infoOutro.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';
import 'common_appbar.dart';

class GominInput extends StatefulWidget {
  final List<String> gominList;
  const GominInput({super.key, required this.gominList});

  @override
  State<GominInput> createState() => _GominInputState();
}

class _GominInputState extends State<GominInput> {
  final TextEditingController _controller = TextEditingController();
  String gominText = '';
  late List<String> gominList;
  bool usedInput = false;

  @override
  void initState() {
    super.initState();
    gominList = List.from(widget.gominList);
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
                  width: 250,
                  height: 45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '요즘 고민거리를 단어로 입력해주세요!',
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
                    hintText: '고민거리 입력하기',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[a-z A-Z ㄱ-ㅎ|가-힣|·|：]'),
                    ),
                  ],
                  onChanged: (text) {
                    setState(() {
                      gominText = text;
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
                if (gominText != '' && usedInput == false) {
                  print('Gomin Text: $gominList');
                  gominList.add(gominText);
                  print('Gomin List: $gominList');
                  usedInput = true;
                  sharedData.updateGominData(gominList);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InfoOutroPage()),
                  );
                } else if (gominText != '' && usedInput == true) {
                  print('Gomin Text: $gominText');
                  gominList.removeLast();
                  gominList.add(gominText);
                  print('Gomin List: $gominList');
                } else {
                  showToast();
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color.fromARGB(255, 255, 240, 246),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
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

void showToast() {
  Fluttertoast.showToast(
    msg: "고민거리를 입력해주세요!",
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: const Color.fromRGBO(100, 100, 100, 1),
    fontSize: 15,
  );
}
