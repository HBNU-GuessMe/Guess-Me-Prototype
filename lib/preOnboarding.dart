import 'package:flutter/material.dart';
import 'package:guessme/preLogin.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page;
      if (page != null) {
        setState(() {
          _currentPage = page.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: isActive ? 12.0 : 8.0,
      width: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromRGBO(248, 187, 208, 1)
            : const Color.fromRGBO(255, 240, 246, 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  List<Widget> _buildPageIndicators() {
    List<Widget> list = [];
    int numPages = 3;
    for (int i = 0; i < numPages; i++) {
      list.add(i == _currentPage
          ? _buildPageIndicator(true)
          : _buildPageIndicator(false));
    }
    return list;
  }

  Widget _buildOnboardingPage(String imagePath, String text) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 90),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          //const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                imagePath,
                height: 630,
                width: 300,
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          _buildOnboardingPage('assets/GuessMe_onboarding1.png',
              'AI 해피가 주는\n가족 맞춤형 질문에 답변해보세요!'),
          _buildOnboardingPage(
              'assets/GuessMe_onboarding2.png', '24시간 속마음 토크로\n가족과 더 가까워져요 :)'),
          _buildOnboardingPage('assets/GuessMe_onboarding3.png',
              'AI 해피가 가족 대화를 분석하여\n리포트를 발행해줘요.'),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        width: double.infinity,
        height: 110,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicators(),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 310,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(248, 187, 208, 1),
                  padding: const EdgeInsets.all(5),
                ),
                child: Text(
                  _currentPage < 2 ? '다음' : '즐거운 가족 맞춤 소통 시작하기',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
