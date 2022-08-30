import 'package:budget_app/styles.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class EditBudgetScreen extends StatefulWidget {
  const EditBudgetScreen({Key? key}) : super(key: key);
  static const String id = '/budget';

  @override
  _EditBudgetScreenState createState() => _EditBudgetScreenState();
}

class _EditBudgetScreenState extends State<EditBudgetScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Budget'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Set Monthly Budget',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 3),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 3),
              TextField(
                textAlign: TextAlign.center,
                controller: _controller,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: brandColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 3),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 2.5),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
