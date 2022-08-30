import 'package:budget_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExpenditureSummaryTile extends StatelessWidget {
  const ExpenditureSummaryTile({Key? key}) : super(key: key);

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
            child: Text(
              'Total Spent this month: Rs 2000',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 2.7),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircularPercentIndicator(
                radius: SizeConfig.blockSizeVertical * 4,
                lineWidth: 5.0,
                animation: true,
                percent: 0.7,
                center: Text(
                  "70.0%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 1.6),
                ),
                footer:  Text(
                  "Food",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.blockSizeVertical * 1.9),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purple,
              ),
              CircularPercentIndicator(
                radius: SizeConfig.blockSizeVertical * 4,
                lineWidth: 5.0,
                animation: true,
                percent: 0.1,
                center: Text(
                  "10.0%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 1.6),
                ),
                footer:  Text(
                  "Stationary",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.blockSizeVertical * 1.9),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.yellow,
              ),
              CircularPercentIndicator(
                radius: SizeConfig.blockSizeVertical * 4,
                lineWidth: 5.0,
                animation: true,
                percent: 0.2,
                center: Text(
                  "20.0%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 1.6),
                ),
                footer: Text(
                  "Miscellaneous",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 1.9),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.teal,
              ),
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
}
