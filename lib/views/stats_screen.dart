import 'package:budget_app/view_models/main_viewmodel.dart';
import 'package:budget_app/views/widgets/expenditure_summary_tile.dart';
import 'package:budget_app/views/widgets/transaction_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';
import '../styles.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late MainViewModel _model;

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<MainViewModel>(context);
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
          ExpenditureSummaryTile(
            total: _model.total,
            food: _model.food,
            clothes: _model.clothes,
            miscellaneous: _model.miscellaneous,
            travel: _model.travel,
          ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                Text(
                  'History',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 3),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2),
                _model.history == null
                    ? const CircularProgressIndicator()
                    : _model.history!.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text(
                                'No transactions in previous months',
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.5),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal * 5),
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    TransactionHistoryTile(
                                  budget: _model.budget ?? '0',
                                  transaction: _model.history![index],
                                ),
                                itemCount: _model.history!.length,
                              ),
                            ),
                          )
                // TransactionHistoryTile(
                //     transaction: TransactionHistory(
                //         month: 'September',
                //         year: '2022',
                //         total: 1400,
                //         food: 70,
                //         clothes: 1200,
                //         travel: 30,
                //         miscellaneous: 100),
                //     budget: '2000'),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
