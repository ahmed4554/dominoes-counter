import 'package:domenos_counter/business_logic/cubit/bloc_observer.dart';
import 'package:domenos_counter/business_logic/cubit/cubit/history_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';

import 'firebase_options.dart';
import 'modules/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    Hive.initFlutter(),
    MobileAds.instance.initialize(),
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp._intern();

  static const _instance = MyApp._intern();

  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..initializeBox(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
