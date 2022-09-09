import 'package:budget_app/size_config.dart';
import 'package:budget_app/view_models/main_viewmodel.dart';
import 'package:budget_app/views/widgets/transaction_tile.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/enums.dart';
import '../styles.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late MainViewModel _model;

  void getTransactions(DateTime date) async {
    _model.setSelectedDate(date);
    await _model.fetchBodyTransactions(date);
  }

  @override
  void initState() {
    print('initstate');
    Future.delayed(Duration.zero).then((value) {
      getTransactions(DateTime.now());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<MainViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: brandColor,
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 0.4),
          CalendarTimeline(
            initialDate: _model.selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 90)),
            lastDate: DateTime.now().add(const Duration(days: 90)),
            onDateSelected: getTransactions,
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: brandColor,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: brandColor,
            dotsColor: const Color(0xFF333A47),
            locale: 'en_ISO',
          ),
          Expanded(
              child: (_model.body == null || _model.state == ViewState.busy)
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: brandColor,
                      ),
                    )
                  : _model.body!.isEmpty
                      ? Center(
                          child: Text(
                            'No transactions on this day',
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2.5),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 5),
                          child: ListView.builder(
                            itemBuilder: (context, index) => TransactionTile(
                                transaction: _model.body![index]),
                            itemCount: _model.body!.length,
                          ),
                        ))
        ],
      ),
      // body: Column(
      //   children: [
      //     SizedBox(height: SizeConfig.blockSizeVertical * 0.4),
      //     Expanded(
      //       child: Container(
      //         width: double.infinity,
      //         decoration: const BoxDecoration(
      //           borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(16),
      //               topRight: Radius.circular(16)),
      //           color: Colors.white,
      //         ),
      //         padding: EdgeInsets.symmetric(
      //             horizontal: SizeConfig.blockSizeHorizontal * 5),
      //         child: SingleChildScrollView(
      //           child: DefaultTabController(
      //             length: 2,
      //             child: SingleChildScrollView(
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     margin: EdgeInsets.only(
      //                       top: SizeConfig.blockSizeVertical * 3,
      //                       left: SizeConfig.blockSizeVertical * 0.4,
      //                       right: SizeConfig.blockSizeVertical * 0.4,
      //                     ),
      //                     decoration: const BoxDecoration(
      //                       borderRadius: BorderRadius.all(Radius.circular(5)),
      //                       color: brandColor,
      //                     ),
      //                     height: SizeConfig.blockSizeVertical * 7,
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(2),
      //                       child: TabBar(
      //                         indicator: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(5),
      //                             color: brandColor),
      //                         labelColor: Colors.white,
      //                         unselectedLabelColor: Colors.white54,
      //                         tabs: const [
      //                           Tab(text: 'This Month'),
      //                           Tab(text: 'Last 12 Months'),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: SizeConfig.blockSizeVertical * 0.4,
      //                   ),
      //                   Container(
      //                     height: SizeConfig.blockSizeVertical * 70,
      //                     child: const TabBarView(children: <Widget>[
      //                       Center(
      //                         child: Text('This month'),
      //                       ),
      //                       Center(
      //                         child: Text('12 month'),
      //                       ),
      //                     ]),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
