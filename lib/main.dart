import 'package:flutter/material.dart';

import 'modules/splash_screen/splash_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp._intern();

  static final  _instance = MyApp._intern();

  factory MyApp()  => _instance;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
