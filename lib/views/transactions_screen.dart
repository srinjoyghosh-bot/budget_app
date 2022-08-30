import 'package:budget_app/size_config.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: brandColor,
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 0.4),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5),
              child: SingleChildScrollView(
                child: DefaultTabController(
                  length: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 3,
                            left: SizeConfig.blockSizeVertical * 0.4,
                            right: SizeConfig.blockSizeVertical * 0.4,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: brandColor,
                          ),
                          height: SizeConfig.blockSizeVertical * 7,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: TabBar(
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: brandColor),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white54,
                              tabs: const [
                                Tab(text: 'This Month'),
                                Tab(text: 'Last 12 Months'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 0.4,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 70,
                          child: const TabBarView(children: <Widget>[
                            Center(
                              child: Text('This month'),
                            ),
                            Center(
                              child: Text('12 month'),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
