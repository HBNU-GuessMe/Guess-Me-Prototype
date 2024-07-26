import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:guessme/infoNickname.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';

class BirthdayPage extends StatefulWidget {
  const BirthdayPage({super.key});

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  String selectedDate = "";

  void _onPickerChanged(DateTime date) {
    final textDate = date.toString().split(' ').first;
    setState(() {
      selectedDate = textDate;
    });
    print(textDate);
  }

  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<SharedData>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 246, 1),
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset('assets/GuessMe_AppBar_newLogo.png'),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 240, 246, 1),
        elevation: 0.0,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  '생년월일을 선택해주세요!',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 340,
                  height: 270,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    minimumYear: 1900,
                    maximumYear: DateTime.now().year,
                    initialDateTime: DateTime.now(),
                    maximumDate: DateTime.now(),
                    // dateOrder: DatePickerDateOrder.ymd,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    onDateTimeChanged: _onPickerChanged,
                  ),
                ),
                const SizedBox(
                  height: 100,
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
                sharedData.updateBirthdayData(selectedDate);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const NicknamePage()));
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
