import 'package:flutter/material.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({super.key});

  @override
  State<DailyReport> createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Center(
          child: Image.asset(
            'assets/GuessMe_reportHappy.gif',
            width: 200,
            height: 200,
          ),
        ),
        const ReportContainer(
          title: '해피의 속마음 토크 리뷰 한마디',
          content:
              '오늘의 대화를 통해 서로를 더 이해하게 되셨네요. 앞으로도 이렇게 열린 마음으로 대화를 나누시길 바랍니다. 다음 주제로는 "서로의 재능 인정하기"는 어떨까요?',
        ),
        const SizedBox(height: 40),
        const ReportContainer(
          title: '우리 가족 주요 속마음 토크 주제',
          content: '#진로 #미래 #성적',
        ),
        const SizedBox(height: 40),
        const ReportContainer(
          title: '가장 활발하게 토크한 가족 구성원',
          content: '🎉엄마🎉',
        ),
        const SizedBox(height: 40),
        const ReportContainer(
          title: '우리 가족 소통 감정',
          content: '감정 그래프',
        ),
      ],
    );
  }
}

class ReportContainer extends StatelessWidget {
  final String title;
  final String content;

  const ReportContainer(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              title == '해피의 속마음 토크 리뷰 한마디'
                  ? 'assets/GuessMe_replyButton.png'
                  : 'assets/GuessMe_hearthappy1.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x1E000000),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (title == '우리 가족 소통 감정') {
      return const Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(202, 236, 255, 1)),
                    strokeWidth: 20,
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: 0.65,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(255, 220, 233, 1)),
                    strokeWidth: 20,
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: 0.35,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(248, 187, 208, 1)),
                    strokeWidth: 20,
                  ),
                ),
                Text(
                  '🙂',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('긍정 35%', style: TextStyle(fontSize: 16)),
            Text('중립 40%', style: TextStyle(fontSize: 16)),
            Text('부정 25%', style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    } else if (title == '가장 활발하게 토크한 가족 구성원') {
      return Center(
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Text(
        content,
        style: const TextStyle(
          fontSize: 14,
        ),
      );
    }
  }
}
