import 'package:flutter/material.dart';

extension Spaces on int {
  Widget get h => SizedBox(
        height: toDouble(),
      );

  Widget get w => SizedBox(
        width: toDouble(),
      );
}
