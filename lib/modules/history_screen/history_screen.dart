import 'package:domenos_counter/business_logic/cubit/cubit/history_cubit.dart';
import 'package:domenos_counter/components/components.dart';
import 'package:domenos_counter/extensions.dart';
import 'package:domenos_counter/models/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        var c = HistoryCubit.get(context);
        return c.history.isEmpty
            ? LottieBuilder.asset(
                'assets/lotties/nodata.json',
                repeat: false,
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return HistoryComponent(
                    model: MatchModel.fromMap(
                      c.history[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) => 15.h,
                itemCount: c.history.length);
      },
    );
  }
}
