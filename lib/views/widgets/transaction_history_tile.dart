import 'package:budget_app/models/transaction_history.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'circular_indicator.dart';

class TransactionHistoryTile extends StatefulWidget {
  const TransactionHistoryTile(
      {Key? key, required this.transaction, required this.budget})
      : super(key: key);
  final TransactionHistory transaction;
  final String budget;

  @override
  _TransactionHistoryTileState createState() => _TransactionHistoryTileState();
}

class _TransactionHistoryTileState extends State<TransactionHistoryTile> {
  bool _showDetails = false;

  onTap() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: SizeConfig.blockSizeHorizontal * 6,
                backgroundColor:
                    widget.transaction.total > double.parse(widget.budget)
                        ? Colors.red
                        : Colors.green,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(widget.transaction.total.toStringAsFixed(1),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeVertical * 2.5)),
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                    "${widget.transaction.month} ${widget.transaction.year}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeVertical * 2.2)),
              ),
              const Spacer(),
              IconButton(
                  onPressed: onTap,
                  icon: Icon(_showDetails
                      ? Icons.arrow_upward_sharp
                      : Icons.arrow_downward_sharp)),
            ],
          ),
          _showDetails
              ? SizedBox(height: SizeConfig.blockSizeVertical * 2)
              : Container(),
          _showDetails
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularIndicator(
                        value: widget.transaction.food,
                        total: widget.transaction.total,
                        color: Colors.purple,
                        title: 'Food'),
                    CircularIndicator(
                        value: widget.transaction.clothes,
                        total: widget.transaction.total,
                        color: Colors.yellow,
                        title: 'Clothes'),
                    CircularIndicator(
                        value: widget.transaction.travel,
                        total: widget.transaction.total,
                        color: Colors.blueAccent,
                        title: 'Travel'),
                    CircularIndicator(
                        value: widget.transaction.miscellaneous,
                        total: widget.transaction.total,
                        color: Colors.teal,
                        title: 'Miscellaneous')
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
