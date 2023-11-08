import 'dart:io';

import 'package:domenos_counter/business_logic/cubit/cubit/history_cubit.dart';
import 'package:domenos_counter/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../components/components.dart';
import '../../constants/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  late AdSize adSize;

  late double screenWidth, screenHeight;
  void initVars() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    adSize = AdSize(height: screenHeight.floor(), width: screenWidth.floor());
  }

  @override
  void initState() {
    loadAd();
    super.initState();
  }

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  /// Loads a banner ad.
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    initVars();
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<HistoryCubit>(context).addToDataBase();
        },
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        height: 60,
        color: primary,
        child: Row(
          children: [
            20.w,
            InkWell(
              onTap: () {
                BlocProvider.of<HistoryCubit>(context).changeScreen(0);
              },
              child: const SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    Text('Home'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                BlocProvider.of<HistoryCubit>(context).getHistory();
                BlocProvider.of<HistoryCubit>(context).changeScreen(1);
              },
              child: const SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                    ),
                    Text('History'),
                  ],
                ),
              ),
            ),
            20.w,
          ],
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
          child: Column(
            children: [
              const Text(
                'Choose A Color To App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              30.h,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    colors.length,
                    (index) => GestureDetector(
                          onTap: () {
                            primary = colors[index];
                            setState(() {});
                          },
                          child: BuildColorPalletItem(
                            color: colors[index],
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Domineos Counter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (BlocProvider.of<HistoryCubit>(context).currentIndex == 0) {
                print('homescreen');
                BlocProvider.of<HistoryCubit>(context).reset();
              } else {
                print('history screen');
                BlocProvider.of<HistoryCubit>(context).clearHistory();
              }
            },
            icon: const Icon(
              Icons.restore_rounded,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        buildWhen: (previous, current) {
          if (previous == current) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                if (_bannerAd != null)
                  Positioned(
                    bottom: 80,
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble() ,
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.h,
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 150,
                      child: BlocProvider.of<HistoryCubit>(context).widget,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
