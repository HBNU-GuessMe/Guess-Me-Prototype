import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class CumulativeReport extends StatefulWidget {
  const CumulativeReport({super.key});

  @override
  State<CumulativeReport> createState() => _CumulativeReportState();
}

class _CumulativeReportState extends State<CumulativeReport> {
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
          title: '우리 가족 소통 레벨',
          content: '',
        ),
        const SizedBox(height: 16),
        const ReportContainer(
          title: '우리 가족 속마음 토크 주제 TOP3',
          content: '1. 미래\n2. 공부\n3. 진로',
        ),
        const SizedBox(height: 16),
        const ReportContainer(
          title: '우리 가족 소통 스타일',
          content: '수현 - #직접적 #논리적\n\n 소통 코칭\n',
        ),
        const SizedBox(height: 16),
        const ReportContainer(
          title: '우리 가족 속마음 토크 참여도 통계',
          content: '',
        ),
        const SizedBox(height: 16),
        const ReportContainer(
          title: '우리 가족 소통 감정 통계',
          content: '행복',
        ),
      ],
    );
  }
}

class ReportContainer extends StatelessWidget {
  final String title;
  final String content;

  const ReportContainer({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/GuessMe_hearthappy2.png',
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
          child: title == '우리 가족 소통 레벨'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/GuessMe_level1.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: index == 0
                                            ? const Color(0xFFF8BBD0)
                                            : const Color(0x4CF8BBD0),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '가족 모두 질문과 속마음 토크에 참여하여 소통 레벨을 올려보세요. 다음 레벨까지 4번 남았어요 :)',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : title == '우리 가족 속마음 토크 주제 TOP3'
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('1. 미래', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 4),
                          Text('2. 공부', style: TextStyle(fontSize: 14)),
                          SizedBox(height: 4),
                          Text('3. 진로', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    )
                  : title == '우리 가족 소통 스타일'
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '수현 - #직접적 #논리적\n\n 소통 코칭\n',
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 16,
                                fontFamily: 'Pretendard JP',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "너무 직접적인 표현보다는 '나는 ~라고 느꼈어'와 같은 표현을 사용하면 더 효과적일 수 있습니다.",
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 16,
                                fontFamily: 'Pretendard JP',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Divider(),
                            SizedBox(height: 8),
                            Text(
                              '엄마 - #직접적 #감성적\n아빠 - #간접적 #논리적',
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 16,
                                fontFamily: 'Pretendard JP',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      : title == '우리 가족 속마음 토크 참여도 통계'
                          ? BarChart()
                          : title == '우리 가족 소통 감정 통계'
                              ? LineChart()
                              : Text(
                                  content,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
        ),
      ],
    );
  }
}

class BarChart extends StatelessWidget {
  final List<String> dates = ['7/1', '7/4', '7/7', '7/9', '7/12'];
  final List<String> members = ['나', '아빠', '엄마', '동생'];
  final Random random = Random();

  BarChart({super.key});

  List<charts.Series<BarData, String>> _createSampleData() {
    List<BarData> data = [];

    for (String date in dates) {
      for (String member in members) {
        data.add(BarData(date, member, random.nextInt(101)));
      }
    }

    return [
      charts.Series<BarData, String>(
        id: '나',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(const Color(0xFFFFF0F6)),
        domainFn: (BarData data, _) => data.date,
        measureFn: (BarData data, _) => data.value,
        data: data.where((d) => d.member == '나').toList(),
      ),
      charts.Series<BarData, String>(
        id: '아빠',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(const Color(0xFFFFDCE9)),
        domainFn: (BarData data, _) => data.date,
        measureFn: (BarData data, _) => data.value,
        data: data.where((d) => d.member == '아빠').toList(),
      ),
      charts.Series<BarData, String>(
        id: '엄마',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(const Color(0xFFF8BBD0)),
        domainFn: (BarData data, _) => data.date,
        measureFn: (BarData data, _) => data.value,
        data: data.where((d) => d.member == '엄마').toList(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: charts.BarChart(
        _createSampleData(),
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [
          charts.SeriesLegend(
            position: charts.BehaviorPosition.bottom,
            outsideJustification: charts.OutsideJustification.middleDrawArea,
          )
        ],
      ),
    );
  }
}

class BarData {
  final String date;
  final String member;
  final int value;

  BarData(this.date, this.member, this.value);
}

class LineChart extends StatelessWidget {
  final Random random = Random();

  LineChart({super.key});

  List<charts.Series<LineData, DateTime>> _createSampleData() {
    final data = List.generate(
      12,
      (index) => LineData(
        DateTime(2023, 7, index + 1),
        random.nextInt(10) + 1,
      ),
    );

    return [
      charts.Series<LineData, DateTime>(
        id: 'Emotional Score',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            const Color.fromRGBO(248, 187, 208, 1)),
        domainFn: (LineData data, _) => data.date,
        measureFn: (LineData data, _) => data.score,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: charts.TimeSeriesChart(
        _createSampleData(),
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        domainAxis: charts.DateTimeAxisSpec(
          tickProviderSpec: charts.StaticDateTimeTickProviderSpec(
            [
              charts.TickSpec(DateTime(2023, 7, 1)),
              charts.TickSpec(DateTime(2023, 7, 4)),
              charts.TickSpec(DateTime(2023, 7, 7)),
              charts.TickSpec(DateTime(2023, 7, 9)),
              charts.TickSpec(DateTime(2023, 7, 12)),
            ],
          ),
          tickFormatterSpec: charts.BasicDateTimeTickFormatterSpec(
            (DateTime dateTime) => '${dateTime.month}/${dateTime.day}',
          ),
        ),
        primaryMeasureAxis: const charts.NumericAxisSpec(
          viewport: charts.NumericExtents(0, 10),
          tickProviderSpec: charts.StaticNumericTickProviderSpec(
            [
              charts.TickSpec(0,
                  label: '😡', style: charts.TextStyleSpec(fontSize: 24)),
              charts.TickSpec(5,
                  label: '🙂', style: charts.TextStyleSpec(fontSize: 24)),
              charts.TickSpec(10,
                  label: '😄', style: charts.TextStyleSpec(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

class LineData {
  final DateTime date;
  final int score;

  LineData(this.date, this.score);
}
