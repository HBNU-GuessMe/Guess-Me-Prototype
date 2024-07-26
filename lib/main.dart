import 'package:flutter/material.dart';
import 'package:guessme/preSplash.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'shared_data.dart';

Future<void> main() async {
  KakaoSdk.init(nativeAppKey: '3bfa15a0b1b68cc42f84cf9328fb44e5');
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialization();
  runApp(
    ChangeNotifierProvider(
      create: (context) => SharedData(),
      child: const MyApp(),
    ),
  );
}

Future initialization() async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color(0xFFF8BBD0),
          ),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
