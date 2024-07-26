import 'package:flutter/material.dart';
import 'package:guessme/report/reportCumulative.dart';
import 'package:guessme/report/reportDaily.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '우리 가족 소통 리포트',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Pretendard JP',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                color: const Color(0xFFE8E8EA),
                child: const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Color(0xFFF8BBD0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Pretendard JP',
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(text: '일일 분석 리포트'),
                    Tab(text: '누적 분석 리포트'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    DailyReport(),
                    CumulativeReport(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
