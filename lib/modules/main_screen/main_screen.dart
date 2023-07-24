import 'dart:developer';
import 'dart:ui';

import 'package:domenos_counter/extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

enum TeamLarger { teamALarger, teamBLarger }

enum TeamToAdd { addToTeamA, addToTeamB }

class _MainScreenState extends State<MainScreen> {
  TeamLarger? teamLarger;

  TeamToAdd? teamToAdd;

  var finalScore = TextEditingController();

  num teamA = 0;
  num teamB = 0;
  num adding = 0;

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
    num _finalScore = int.parse(finalScore.text);
    if (teamA > teamB) {
      teamLarger = TeamLarger.teamALarger;
    } else if (teamB > teamA) {
      teamLarger = TeamLarger.teamBLarger;
    } else {
      teamLarger = null;
    }
    if (teamA >= _finalScore) {
      showWinner('Team A wins');
    } else if (teamB >= _finalScore) {
      showWinner('Team B wins');
    }
  }

  void showWinner(String winner) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          LottieBuilder.asset('assets/lotties/winner.json'),
          20.h,
          Text(
            winner,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheetToAdd() {
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
              alignment: Alignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(.6),
              ),
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value) {
                  addingToTeam(int.parse(value));
                  log(adding.toString());
                  setState(() {});
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

  void reset() {
    teamLarger = null;
    finalScore.text = '';
    adding = 0;
    teamA = 0;
    teamB = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
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
              reset();
            },
            icon: Icon(
              Icons.restore_rounded,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'final Score',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                15.w,
                Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 4,
                  color: Colors.black38,
                  child: SizedBox(
                    width: 140,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: finalScore,
                      onEditingComplete: () {
                        compare();
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        fillColor: Colors.orange,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: '00',
                        hintStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            40.h,
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        teamToAdd = TeamToAdd.addToTeamA;
                        showBottomSheetToAdd();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              teamA.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: teamLarger != null
                                    ? teamLarger == TeamLarger.teamALarger
                                        ? Colors.green
                                        : Colors.grey
                                    : Colors.grey,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          15.h,
                          const Text(
                            'Team A',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        teamToAdd = TeamToAdd.addToTeamB;
                        showBottomSheetToAdd();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              teamB.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: teamLarger != null
                                    ? teamLarger == TeamLarger.teamBLarger
                                        ? Colors.green
                                        : Colors.grey
                                    : Colors.grey,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          15.h,
                          const Text(
                            'Team B',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
