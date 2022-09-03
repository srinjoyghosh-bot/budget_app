import 'package:budget_app/models/transaction.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal,
          vertical: SizeConfig.blockSizeVertical),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 3, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 10,
            height: SizeConfig.blockSizeHorizontal * 10,
            child: Image.asset('assets/icons/hamburger.png'),
          ),
          SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(transaction.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeVertical * 2.2)),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
              Text('Food 22/2/21',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeVertical * 1.8)),
            ],
          ),
          const Spacer(),
          Text('Rs ${transaction.amount}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: SizeConfig.blockSizeVertical * 2.5))
        ],
      ),
    );
  }
}
