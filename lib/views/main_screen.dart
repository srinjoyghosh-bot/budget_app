import 'package:budget_app/size_config.dart';
import 'package:budget_app/styles.dart';
import 'package:budget_app/view_models/main_viewmodel.dart';
import 'package:budget_app/views/add_transaction_screen.dart';
import 'package:budget_app/views/profile_screen.dart';
import 'package:budget_app/views/stats_screen.dart';
import 'package:budget_app/views/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String id = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int page = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      fetch();
    });
    super.initState();
  }

  void fetch() async {
    final model = Provider.of<MainViewModel>(context, listen: false);
    await model.fetchProfile();
    await model.fetchTodayTransactions();
  }

  void onTapped(int index) {
    setState(() {
      page = index;
    });
  }

  void moveToTransactionPage() {
    setState(() {
      page = 1;
    });
  }

  List<Widget> pages = [
    HomeScreen(onClick: () {}),
    const TransactionsScreen(),
    const StatsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: pages[page],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTransactionScreen.id);
        },
        backgroundColor: brandColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: brandColor,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: page == 0
                        ? SizeConfig.blockSizeVertical * 3.5
                        : SizeConfig.blockSizeVertical * 4.5,
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onTapped(0);
                    },
                  ),
                  if (page == 0)
                    Text(
                      'Home',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 2),
                    ),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    iconSize: page == 1
                        ? SizeConfig.blockSizeVertical * 3.5
                        : SizeConfig.blockSizeVertical * 4.5,
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onTapped(1);
                    },
                  ),
                  if (page == 1)
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Transactions',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                    ),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    iconSize: page == 2
                        ? SizeConfig.blockSizeVertical * 3.5
                        : SizeConfig.blockSizeVertical * 4.5,
                    icon: const Icon(
                      Icons.stacked_bar_chart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onTapped(2);
                    },
                  ),
                  if (page == 2)
                    Text(
                      'Stats',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 2),
                    ),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    iconSize: page == 3
                        ? SizeConfig.blockSizeVertical * 3.5
                        : SizeConfig.blockSizeVertical * 4.5,
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onTapped(3);
                    },
                  ),
                  if (page == 3)
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 2),
                    ),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
