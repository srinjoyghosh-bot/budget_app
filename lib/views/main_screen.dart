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
  late MainViewModel _model;

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
    await model.fetchStats();
    await model.fetchHistory();
  }

  void onTapped(int index) {
    _model.setPage(index);
  }

  List<Widget> pages = [
    HomeScreen(onClick: () {}),
    const TransactionsScreen(),
    const StatsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    _model = Provider.of<MainViewModel>(context);
    SizeConfig().init(context);
    return Scaffold(
      body: pages[_model.index],
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
            bottomNavBarItem(0, Icons.home, 'Home'),
            bottomNavBarItem(1, Icons.menu, 'Transactions'),
            const Expanded(child: SizedBox()),
            bottomNavBarItem(2, Icons.stacked_bar_chart, 'Stats'),
            bottomNavBarItem(3, Icons.person, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget bottomNavBarItem(int index, IconData icon, String title) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: _model.index == index
                ? SizeConfig.blockSizeVertical * 3.5
                : SizeConfig.blockSizeVertical * 4.5,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: () {
              onTapped(index);
            },
          ),
          if (_model.index == index)
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.blockSizeVertical * 2),
              ),
            ),
          SizedBox(height: SizeConfig.blockSizeVertical),
        ],
      ),
    );
  }
}
