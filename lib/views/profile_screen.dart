import 'package:budget_app/size_config.dart';
import 'package:budget_app/styles.dart';
import 'package:budget_app/views/edit_budget_screen.dart';
import 'package:budget_app/views/widgets/profile_screen_tile.dart';
import 'package:flutter/material.dart';

import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(color: brandColor),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 0.4),
          Image.asset('assets/icons/user.png'),
          SizedBox(height: SizeConfig.blockSizeVertical),
          Text(
            'Srinjoy Ghosh',
            style: TextStyle(
                color: brandColor,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.8),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
          Text(
            'srinjoygh@gmail.com',
            style: TextStyle(
                color: brandColor,
                fontSize: SizeConfig.blockSizeVertical * 2.2,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          ProfileScreenTile(
            title: 'Edit Profile',
            icon: const Icon(Icons.edit),
            onTap: () {},
          ),
          ProfileScreenTile(
            title: 'Edit Budget',
            icon: const Icon(Icons.attach_money),
            onTap: () {
              Navigator.pushNamed(context, EditBudgetScreen.id);
            },
          ),
          ProfileScreenTile(
            title: 'Change Password',
            icon: const Icon(Icons.password),
            onTap: () {
              Navigator.pushNamed(context, ChangePasswordScreen.id);
            },
          ),
          ProfileScreenTile(
            title: 'Log Out',
            icon: const Icon(Icons.logout),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
