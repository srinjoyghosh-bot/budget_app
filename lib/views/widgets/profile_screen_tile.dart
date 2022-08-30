import 'package:budget_app/styles.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class ProfileScreenTile extends StatelessWidget {
  const ProfileScreenTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final Widget icon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 5, vertical: 16),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 3, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: brandColor),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            icon,
            SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 3),
            )
          ],
        ),
      ),
    );
  }
}
