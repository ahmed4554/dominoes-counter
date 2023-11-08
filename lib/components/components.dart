import 'package:domenos_counter/extensions.dart';
import 'package:domenos_counter/models/match_model.dart';
import 'package:flutter/material.dart';

class BuildColorPalletItem extends StatelessWidget {
  const BuildColorPalletItem({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: color,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}

class HistoryComponent extends StatelessWidget {
  const HistoryComponent({
    super.key,
    required this.model,
  });
  final MatchModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber[100]),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1,
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ]),
                    child: Text(
                      model.date!,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              model.teamA.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          15.h,
                          Text(
                            model.teamAName!,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 10,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              model.teamB.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          15.h,
                          Text(
                            model.teamBName!,
                            style: const TextStyle(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

SnackBar showSnackBar(String message) {
  return SnackBar(
    backgroundColor: Colors.red[400],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
