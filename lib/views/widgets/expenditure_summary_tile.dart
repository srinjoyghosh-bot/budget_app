import 'package:budget_app/size_config.dart';
import 'package:budget_app/views/widgets/circular_indicator.dart';
import 'package:flutter/material.dart';

class ExpenditureSummaryTile extends StatelessWidget {
  const ExpenditureSummaryTile(
      {Key? key,
      required this.total,
      required this.food,
      required this.clothes,
      required this.miscellaneous,
      required this.travel})
      : super(key: key);
  final double total, food, clothes, travel, miscellaneous;

  @override
  Widget build(BuildContext context) {
    // final List<ChartData> chartData = [
    //   ChartData(title: 'David', value: 25, color: Colors.green),
    //   ChartData(title: 'Srin', value: 34, color: Colors.blue),
    //   ChartData(title: 'Hello', value: 12, color: Colors.purple),
    //   ChartData(title: 'YYYY', value: 34, color: Colors.teal),
    // ];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [Text('Total spent : '), Text('Rs 200')],
          // ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Total Spent this month: Rs $total',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 2.7),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircularIndicator(
                  value: food,
                  total: total,
                  color: Colors.purple,
                  title: 'Food'),
              CircularIndicator(
                  value: clothes,
                  total: total,
                  color: Colors.yellow,
                  title: 'Clothes'),
              CircularIndicator(
                  value: travel,
                  total: total,
                  color: Colors.blueAccent,
                  title: 'Travel'),
              CircularIndicator(
                  value: miscellaneous,
                  total: total,
                  color: Colors.teal,
                  title: 'Miscellaneous')
            ],
          ),
          // SfCircularChart(
          //   // backgroundColor: brandColor,
          //   title: ChartTitle(text: 'Spent this month: Rs 200'),
          //   legend: Legend(isVisible: true),
          //   tooltipBehavior: TooltipBehavior(enable: true),
          //   series: <CircularSeries>[
          //     PieSeries<ChartData, String>(
          //       dataSource: chartData,
          //       pointColorMapper: (ChartData data, _) => data.color,
          //       xValueMapper: (ChartData data, _) => data.title,
          //       yValueMapper: (ChartData data, _) => data.value,
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

// Widget circularIndicator(double value,double total, Color color, String title) {
//   return CircularPercentIndicator(
//     radius: SizeConfig.blockSizeVertical * 4,
//     lineWidth: 5.0,
//     animation: true,
//     percent: total == 0
//         ? 0
//         : (value / total) > 1
//             ? 1
//             : (value / total),
//     center: Text(
//       "${((total == 0 ? 0 : value / total) * 100).toStringAsFixed(1)}%",
//       style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: SizeConfig.blockSizeVertical * 1.6),
//     ),
//     footer: FittedBox(
//       fit: BoxFit.scaleDown,
//       child: Text(
//         title,
//         style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: SizeConfig.blockSizeVertical * 1.9),
//       ),
//     ),
//     circularStrokeCap: CircularStrokeCap.round,
//     progressColor: color,
//   );
// }
}
