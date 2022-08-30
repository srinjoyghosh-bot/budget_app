import 'package:budget_app/views/widgets/expenditure_summary_tile.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';
import '../styles.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: brandColor,
        title: const Text('Statistics'),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 0.4),
          // Expanded(
          //     child: Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          //     color: Colors.white,
          //   ),
          //   padding: EdgeInsets.symmetric(
          //       horizontal: SizeConfig.blockSizeHorizontal * 5),
          // )),
          const ExpenditureSummaryTile(),
          SizedBox(height: SizeConfig.blockSizeVertical * 0.4),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 5),
          )),
        ],
      ),
    );
  }
}
