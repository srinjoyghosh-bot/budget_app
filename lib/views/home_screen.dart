import 'package:budget_app/size_config.dart';
import 'package:budget_app/styles.dart';
import 'package:budget_app/views/widgets/home_expenditure_tile.dart';
import 'package:budget_app/views/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.onClick}) : super(key: key);
  final Function() onClick;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Srinjoy Ghosh',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 2.4),
                ),
                Text(
                  'srinjoygh@gmail.com',
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
          const HomeExpenditureTile(),
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
                    'Recent Transactions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 3),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 3),
                  const TransactionTile(),
                  const TransactionTile(),
                  const TransactionTile(),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeVertical * 2.5),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
