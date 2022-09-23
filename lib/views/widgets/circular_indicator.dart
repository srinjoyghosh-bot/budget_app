import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../size_config.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator(
      {Key? key,
      required this.value,
      required this.total,
      required this.color,
      required this.title})
      : super(key: key);
  final double value, total;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: SizeConfig.blockSizeVertical * 4,
      lineWidth: 5.0,
      animation: true,
      percent: total == 0
          ? 0
          : (value / total) > 1
              ? 1
              : (value / total),
      center: Text(
        "${((total == 0 ? 0 : value / total) * 100).toStringAsFixed(1)}%",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.blockSizeVertical * 1.6),
      ),
      footer: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeVertical * 1.9),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: color,
    );
  }
}
