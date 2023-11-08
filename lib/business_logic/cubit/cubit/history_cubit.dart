import 'dart:ui';

import 'package:domenos_counter/modules/history_screen/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../constants/colors.dart';
import '../../../modules/home_screen/home_screen.dart';

part 'history_state.dart';

enum TeamLarger { teamALarger, teamBLarger }

enum TeamToAdd { addToTeamA, addToTeamB }

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  static HistoryCubit get(context) => BlocProvider.of(context);

  late final Box _box;

  var teamAcontroller = TextEditingController();
  var teamBcontroller = TextEditingController();

  List<Widget> screens = const [HomeScreen(), HistoryScreen()];

  Widget widget = const HomeScreen();

  int currentIndex = 0;
  void changeScreen(int index) {
    currentIndex = index;
    widget = screens[currentIndex];
    emit(ChangeScreen());
    // if (index == 0) {
    //   widget = const HomeScreen();
    //   currentIndex = 0;
    //   emit(ChangeScreen());
    // } else {
    //   widget = const HistoryScreen();
    //   currentIndex = 1;
    //   emit(ChangeScreen());
    // }
  }

  num teamA = 0;
  num teamB = 0;
  num adding = 0;

  List history = [];
  Map<String, dynamic> map = {};
  void initializeBox() async {
    _box = await Hive.openBox('history');
    emit(BoxInitialize());
  }

  void addToDataBase() async {
    map = {
      'teamA': teamA,
      'teamB': teamB,
      'teamAName': teamAcontroller.text,
      'teamBName': teamBcontroller.text,
      'date': DateTime.now().toString().substring(0, 10),
    };

    if (map['teamA'] == 0 &&
        map['teamB'] == 0 &&
        map['teamAName'] == '' &&
        map['teamBName'] == '') {
      emit(Error(error: 'ادخل قيم لكي يتم الحفظ'));
    } else {
      try {
        await _box.add(map);
        getHistory();

        reset();
      } catch (e) {
        emit(Error(error: e.toString()));
      }
      emit(AddToHistory());
    }
  }

  void getHistory() {
    history = _box.values.toList();
    print(history);
    emit(GetHistory());
  }

  void clearHistory() async {
    await _box.clear();
    history = [];
    // _model =
    //     MatchModel(date: '', teamA: 0, teamB: 0, teamAName: '', teamBName: '');
    emit(Reset());
  }

  TeamLarger? teamLarger;

  TeamToAdd? teamToAdd;

  void addingToTeam(int whatToAdd) {
    adding = whatToAdd;
    if (teamToAdd == TeamToAdd.addToTeamA) {
      teamA += adding;
      compare();
    }
    if (teamToAdd == TeamToAdd.addToTeamB) {
      teamB += adding;
      compare();
    }
  }

  void compare() {
    if (teamA > teamB) {
      teamLarger = TeamLarger.teamALarger;
      emit(TeamALarger());
    } else if (teamB > teamA) {
      teamLarger = TeamLarger.teamBLarger;
      emit(TeamBLarger());
    } else {
      teamLarger = null;
    }
  }

  void reset() {
    teamLarger = null;
    adding = 0;
    teamA = 0;
    teamB = 0;
    teamAcontroller.text = '';
    teamBcontroller.text = '';
    emit(Reset());
  }

  void showBottomSheetToAdd(context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 150,
              decoration: BoxDecoration(
                color: primary.withOpacity(.6),
              ),
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 40,
                  color: primary,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value) {
                  addingToTeam(int.parse(value));
                  Navigator.pop(context);
                },
                decoration: InputDecoration(
                  isDense: true,
                  hintText: '00',
                  hintStyle: const TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
