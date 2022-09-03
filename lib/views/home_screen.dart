import 'package:budget_app/size_config.dart';
import 'package:budget_app/styles.dart';
import 'package:budget_app/view_models/main_viewmodel.dart';
import 'package:budget_app/views/widgets/home_expenditure_tile.dart';
import 'package:budget_app/views/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.onClick}) : super(key: key);
  final Function() onClick;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MainViewModel _model;

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<MainViewModel>(context);
    final user = _model.user;
    final transactions = _model.today;
    return Scaffold(
      backgroundColor: brandColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: brandColor,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 7,
              child: Image.asset('assets/icons/user.png'),
            ),
            const SizedBox(width: 10),
            user == null
                ? Container()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeVertical * 2.4),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
          ],
        ),
        actions: [
          IconButton(
            iconSize: SizeConfig.blockSizeHorizontal * 7,
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        children: [
          // const ExpenditureSummaryTile(),
          (user != null && transactions != null)
              ? HomeExpenditureTile(
                  budget: user.budget,
                  spent: '2000',
                )
              : Container(),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Text(
                    'Today\'s Transactions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 3),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),
                  // const TransactionTile(),
                  // const TransactionTile(),
                  // const TransactionTile(),
                  transactions == null
                      ? Container()
                      : transactions.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Text(
                                  'No transactions today',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 2.5),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    TransactionTile(
                                  transaction: transactions[index],
                                ),
                                itemCount: transactions.length,
                              ),
                            ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
