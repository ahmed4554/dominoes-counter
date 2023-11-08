
import 'package:domenos_counter/components/components.dart';
import 'package:domenos_counter/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/cubit/history_cubit.dart';
import '../../constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {
        if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            showSnackBar(state.error),
          );
        }
      },
      buildWhen: (previous, current) {
        if (previous != current) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        var c = HistoryCubit.get(context);
        return Column(
          children: [
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
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        fillColor: primary,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: '00',
                        hintStyle: const TextStyle(
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
                        c.teamToAdd = TeamToAdd.addToTeamA;
                        c.showBottomSheetToAdd(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              c.teamA.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: c.teamLarger != null
                                    ? c.teamLarger == TeamLarger.teamALarger
                                        ? Colors.green
                                        : Colors.grey
                                    : Colors.grey,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          15.h,
                          TextFormField(
                            controller: c.teamAcontroller,
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Team A',
                              hintStyle: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                        c.teamToAdd = TeamToAdd.addToTeamB;
                        c.showBottomSheetToAdd(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: Text(
                              c.teamB.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: c.teamLarger != null
                                    ? c.teamLarger == TeamLarger.teamBLarger
                                        ? Colors.green
                                        : Colors.grey
                                    : Colors.grey,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          15.h,
                          TextFormField(
                            controller: c.teamBcontroller,
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Team B',
                              hintStyle: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
            ),
          ],
        );
      },
    );
  }
}
