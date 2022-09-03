import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../size_config.dart';

class HomeExpenditureTile extends StatelessWidget {
  HomeExpenditureTile({
    Key? key,
    required this.spent,
    required this.budget,
  }) : super(key: key);
  String spent;
  String budget;

  @override
  Widget build(BuildContext context) {
    final percent =
        (double.tryParse(spent) ?? 0) / (double.tryParse(budget) ?? 1);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Spent this month: Rs $spent',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Budget: Rs $budget',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeVertical * 2.1),
                ),
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: SizeConfig.blockSizeVertical * 5,
            lineWidth: 6.0,
            animation: true,
            percent: percent,
            center: Text(
              "${(percent * 100).toStringAsFixed(2)}%",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 1.9),
            ),
            // footer:  Text(
            //   "Food",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.blockSizeVertical * 1.9),
            // ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
