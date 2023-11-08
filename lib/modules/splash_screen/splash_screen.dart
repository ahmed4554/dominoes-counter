import 'package:domenos_counter/modules/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                spreadRadius: 3,
                color: Colors.black38,
                offset: Offset.zero,
              )
            ],
            borderRadius: BorderRadius.circular(150),
            color: Colors.white,
          ),
          child: LottieBuilder(
            lottie: AssetLottie('assets/lotties/dominoes.json'),
            onLoaded: (duration) {
              Future.delayed(duration.duration, () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false);
              });
            },
          ),
        ),
      ),
    );
  }
}
