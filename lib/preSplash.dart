import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guessme/questNew.dart';
import 'package:guessme/infoPosition.dart';
import 'package:guessme/preOnboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool hasProfile = prefs.getBool('hasProfile') ?? false;

    if (isLoggedIn) {
      if (hasProfile) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NewQuest()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PositionPage()),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
