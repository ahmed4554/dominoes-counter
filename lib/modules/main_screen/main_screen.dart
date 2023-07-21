import 'package:domenos_counter/extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

enum TeamLarger { teamALarger, teamBLarger }

class _MainScreenState extends State<MainScreen> {
  TeamLarger? teamLarger;
  var teamAController = TextEditingController();

  var teamBController = TextEditingController();
  var finalScore = TextEditingController();
  num teamA = 0;
  num teamB = 0;

  void compare() {
    if (teamAController.text.isNotEmpty) {
      teamA = int.parse(teamAController.text);
    }
    if (teamBController.text.isNotEmpty) {
      teamB = int.parse(teamBController.text);
    }
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

  void reset() {
    teamLarger = null;
    teamAController.text = '';
    finalScore.text = '';
    teamBController.text = '';
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
          'final Score',
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 140,
                          child: TextFormField(
                            style: TextStyle(
                              color: teamLarger == TeamLarger.teamALarger
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                            controller: teamAController,
                            onChanged: (value) {
                              compare();
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: '00',
                              hintStyle: TextStyle(
                                fontSize: 70,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
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
                  Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 140,
                          child: TextFormField(
                            style: TextStyle(
                              color: teamLarger == TeamLarger.teamBLarger
                                  ? Colors.green
                                  : Colors.grey,
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                            controller: teamBController,
                            onChanged: (value) {
                              compare();
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: '00',
                              hintStyle: TextStyle(
                                fontSize: 70,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
